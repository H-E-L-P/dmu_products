import numpy as np
from astropy.table import Table
from astropy import units as u
from astropy.coordinates import SkyCoord, search_around_sky
from pymoc import MOC
from utils import inMoc
#from tqdm import tqdm, tnrange, tqdm_notebook
from concurrent.futures import ProcessPoolExecutor, as_completed
#from test import gen_rand_cat_inMOC

## general functions
def describe(var, decimals=3, nullvalue=-999):
    """Describe one variable
    """
    format_string_base = ("{{:.{d}f}} +/- {{:.{d}f}}; "
                          "median: {{:.{d}f}}; "
                          "limits: [{{:.{d}f}}, {{:.{d}f}}]; "
                          "N={{}} ({{}} NaN; {{}} masked)")
    format_string = format_string_base.format(d=decimals)
    print(format_string.format(np.nanmean(var), np.nanstd(var), np.nanmedian(var), 
                               np.nanmin(var), np.nanmax(var), len(var), 
                               np.sum(np.isnan(var)), len(var[var == nullvalue])))
    
def gen_rand_cat_inMOC(n,RAmax,RAmin,DECmax,DECmin,catmoc):

    ''' 
    generate a random catalogue of positions within the given MOC
    the positions are generated within the RA and DEC defined and
    then removed if not within the given MOC. This is repeated 
    until n points lie within the MOC
    
    
    '''
    
    randfieldinmoc = 0
    randfieldra = []
    randfielddec = []
    randfield = []

    while n!=0:
        #print (n)
        randfieldtemp = generate_random_catalogue(n,RAmin,RAmax,DECmin,DECmax)
        randfieldtempra  = randfieldtemp.ra.value
        randfieldtempdec = randfieldtemp.dec.value

        randfieldtempinmoc = (inMoc(randfieldtempra,randfieldtempdec,catmoc))

        randfieldra = np.append( randfieldra,randfieldtempra[randfieldtempinmoc])
        randfielddec = np.append( randfielddec,randfieldtempdec[randfieldtempinmoc])

        n = n - sum(randfieldtempinmoc)

    return(SkyCoord(randfieldra,randfielddec,unit='deg'))


## Sky functions
def ru2ra(x, ra1=0., ra2=360.):
    """Transform a random uniform number to a RA between
    the RA specified as an input"""
    return x*(ra2-ra1)+ra1

def ru2dec(y, dec1=-90, dec2=90.):
    """Transform a random uniform number to a Dec between
    the decs. specified as an input"""
    sin_dec1rad = np.sin(np.deg2rad(dec1))
    sin_dec2rad = np.sin(np.deg2rad(dec2))
    inner = y*(sin_dec2rad - sin_dec1rad) + sin_dec1rad
    return np.rad2deg(np.arcsin(inner))

def generate_random_catalogue(n, ra1=0., ra2=360., dec1=-90, dec2=90.):
    """Generate a random catalogue in the zone deffined by the 
    input coordinates
    """
    x = np.random.rand(n)
    y = np.random.rand(n)
    ra = ru2ra(x, ra1=ra1, ra2=ra2)
    dec = ru2dec(y, dec1=dec1, dec2=dec2)
    return SkyCoord(ra, dec,
                    unit=(u.deg, u.deg), 
                    frame='icrs')

def area_ra_dec(ra_down, ra_up, dec_down, dec_up):
    """Compute the area in a region between two right ascentions and
    two declinations.
    The unit of the output is squared arsecs.
    """
    return ((np.deg2rad(ra_up) - np.deg2rad(ra_down)) *
            (np.sin(np.deg2rad(dec_up)) - np.sin(np.deg2rad(dec_down))) *
            np.rad2deg(3600.)**2)

## Data holding classes
class Field(object):
    """
    Class to represent a region of the sky between two right ascensions 
    and two declinations.
    """
    def __init__(self, ra_down, ra_up, dec_down, dec_up, moc = None):
        self.ra_down = ra_down
        self.ra_up = ra_up
        self.dec_down = dec_down
        self.dec_up = dec_up
        self.moc = moc
        if self.moc == None:
            print('field area is defined by a rectangular box')
        else:
            print('field area is defined by a MOC')
        if self.moc == None:
            self.area = area_ra_dec(self.ra_down, self.ra_up, 
                                    self.dec_down, self.dec_up)
        else:
            self.area = self.moc.area * (180/np.pi)**2 * (3600**2)
        
    def filter_catalogue(self, catalogue, colnames=("ra", "dec")):
        """
        Filter a catalogue to the 
        """
        # TODO: Check if colnames in the catalogue
        
        if self.moc == None:
            print('filtering in a rectangular sky area')
            return catalogue[
                ((catalogue[colnames[0]] >= self.ra_down)  & 
                 (catalogue[colnames[0]] <= self.ra_up)    & 
                 (catalogue[colnames[1]] >= self.dec_down) & 
                 (catalogue[colnames[1]] <= self.dec_up))]
        else:
            print('filtering in a MOC')
            return catalogue[ ( inMoc(catalogue[colnames[0]],catalogue[colnames[1]],self.moc) ) ]
    
    def random_catalogue(self, n):
        """
        Generate a random catalogue in the area with n sources
        """
        if self.moc == None:
            return generate_random_catalogue(
                n, ra1=self.ra_down, ra2=self.ra_up, 
                dec1=self.dec_down, dec2=self.dec_up)
        else:
            return gen_rand_cat_inMOC(
                n, self.ra_up, self.ra_down, self.dec_up, self.dec_down, self.moc)

class Q_0(object):
    """
    Compute the Q_0 given a set of catalogues and a field
    """
    def __init__(self, coords_small, coords_big, field, radius=5.):
        self.coords_small = coords_small
        self.coords_big = coords_big
        self.field = field
        self.radius = radius
        self.n_small = len(self.coords_small)
        self.n_big = len(self.coords_big)
    
    def __call__(self, radius=None):
        """Compute the Q_0 for a given radius (in arcsecs)"""
        if radius is None:
            radius = self.radius
        
        # Generate random catalogue with n sources as the small one
        random_small = self.field.random_catalogue(self.n_small)
        idx_random_small, idx_big, d2d, d3d = search_around_sky(
            random_small, self.coords_big, radius*u.arcsec)
        
        nomatch_random = self.n_small - len(np.unique(idx_random_small))
        #print('number of random sources with no matches: {:4d}'.format(nomatch_random))
        # Compute match in radius
        idx_small, idx_big, d2d, d3d = search_around_sky(
            self.coords_small, self.coords_big, radius*u.arcsec)
        nomatch_small = self.n_small - len(np.unique(idx_small))
        #print('number of real sources with no matches: {:4d}'.format(nomatch_small)) 

        return (1. - float(nomatch_small)/float(nomatch_random))
    
## Error functions
def get_sigma(maj_error, min_error, pos_angle, 
              radio_ra, radio_dec, 
              opt_ra, opt_dec, opt_ra_err, opt_dec_err, 
              additonal_error=0.6):
    """
    Get the combined error between an elongated radio source and an 
    optical source.
    
    Input:
    * maj_error: error in the major axis of the radio Gaussian in arsecs
    * min_error: error in the minor axis of the radio Gaussian in arsecs
    * pos_angle: position angle of the radio Gaussian in degrees
    * radio_ra: Right ascension of the radio source in degrees
    * radio_dec: Declination of the radio source in degrees
    * opt_ra: Right ascension of the optical source in degrees
    * opt_dec: Declination of the optical source in degrees
    * opt_ra_err: Error in right ascension of the optical source in degrees
    * opt_dec_err: Error in declination of the optical source in degrees
    * additonal_error: Additonal term to add to the error. By default
        it adds an astrometic error of 0.6 arcsecs.
    
    Output:
    * sigma: Combined error
    """
    factor = 0.60056120439322491 # sqrt(2.0) / sqrt(8.0 * log(2)); see Condon(1997) for derivation of adjustment factor
    majerr = factor * maj_error
    minerr = factor * min_error
    cosadj = np.cos(np.deg2rad(0.5*(radio_dec + opt_dec)))
    phi = np.arctan2((opt_dec - radio_dec), ((opt_ra - radio_ra)*cosadj))
    # angle from direction of major axis to vector joining LOFAR source and optical source
    sigma = np.pi/2.0 - phi - np.deg2rad(pos_angle) 
    loferrsquared  = (majerr * np.cos(sigma))**2 + (minerr * np.sin(sigma))**2
    opterrsquared  = (opt_ra_err * np.cos(phi))**2 + (opt_dec_err * np.sin(phi))**2
    return np.sqrt(loferrsquared + opterrsquared + additonal_error**2)



## ML functions
def get_center(bins):
    """
    Get the central positions for an array defining bins
    """
    return (bins[:-1] + bins[1:]) / 2

def get_n_m(magnitude, bin_list, area):
    """Compute n(m)
    Density of sources per unit of area
    """
    n_hist, _ = np.histogram(magnitude, bin_list)
    return np.cumsum(n_hist)/area

def get_q_m(magnitude, bin_list, n, n_m, area, radius=5):
    """Compute q(m)
    Normalized probability of a real match
    """
    print (n)
    print (n_m)
    print (area)
    n_hist_total, _ = np.histogram(magnitude, bin_list)
    # Correct probability if there are no sources
    if len(magnitude) == 0:
        n_hist_total = np.ones_like(n_hist_total)*0.5
    # Estimate real(m)
    real_m = n_hist_total - n*n_m*np.pi*(radius/3600.)**2
    # Remove small negative numbers
    real_m[real_m <= 0.] = 0.
    real_m_cumsum = np.cumsum(real_m)
    #normalise real_m
    return real_m_cumsum/real_m_cumsum[-1]

def estimate_q_m(magnitude, bin_list, n_m, coords_small, coords_big, radius=5):
    """Compute q(m)
    Estimation of the distribution of real matched sources with respect 
    to a magnitude (normalized to 1). As explained in Fleuren et al.
    """
    assert len(magnitude) == len(coords_big)
    # Cross match
    idx_small, idx_big, d2d, d3d = search_around_sky(
        coords_small, coords_big, radius*u.arcsec)
    n_xm_small = len(np.unique(idx_small))
    idx = np.unique(idx_big)
    # Get the distribution of matched sources
    n_hist_total, _ = np.histogram(magnitude[idx], bin_list)
    # Correct probability if there are no sources
    if len(magnitude[idx]) == 0:
        n_hist_total = np.ones_like(n_hist_total)*0.5
    # Estimate real(m)
    real_m = n_hist_total - n_xm_small*n_m*np.pi*(radius/3600.)**2
    # Remove small negative numbers
    real_m[real_m <= 0.] = 0.
    real_m_cumsum = np.cumsum(real_m)
    return real_m_cumsum/real_m_cumsum[-1]

def fr(r, sigma):
    """Get the probability related to the spatial distribution"""
    s2 = sigma**2
    return 0.5/np.pi/s2*np.exp(-0.5*r**2/s2)

class SingleMLEstimator(object):
    """
    Class to estimate the Maximum Likelihood ratio
    """
    def __init__(self, q0, n_m, q_m, center):
        self.q0 = q0
        self.n_m = n_m
        self.q_m = q_m
        self.center = center
    
    def get_qm(self, m):
        """Get q(m)
        """
        return np.interp(m, self.center, self.q_m*self.q0)

    def get_nm(self, m):
        """Get n(m)"""
        return np.interp(m, self.center, self.n_m)
    
    def __call__(self, m, r, sigma):
        """Get the likelihood ratio"""
        return fr(r, sigma) * self.get_qm(m) / self.get_nm(m)

class MultiMLEstimator(object):
    """
    Class to estimate the Maximum Likelihood ratio in a vectorized 
    fashion.
    """
    def __init__(self, q0, n_m, q_m, center):
        self.q0 = q0
        self.n_m = n_m
        self.q_m = q_m
        self.center = center
    
    def get_qm(self, m, k):
        """Get q(m)
        """
        return np.interp(m, self.center[k], self.q_m[k]*self.q0[k])

    def get_nm(self, m, k):
        """Get n(m)"""
        return np.interp(m, self.center[k], self.n_m[k])
    
    def get_qm_vect(self, m, k):
        """Get q(m) for a given category
        """
        return np.vectorize(self.get_qm)(m, k)

    def get_nm_vect(self, m, k):
        """Get n(m) for a given category
        """
        return np.vectorize(self.get_nm)(m, k)
    
    def __call__(self, m, r, sigma, k):
        """Get the likelihood ratio"""
        return fr(r, sigma) * self.get_qm_vect(m, k) / self.get_nm_vect(m, k)

def q0_min_level(q_0_list, min_level=0.001):
    """Ensures that the minimum value of the Q_0 for each bin is always 
    above a minimum threshold
    """
    q_0 = np.array(q_0_list)
    q_0[q_0 < min_level] = min_level
    return q_0

def q0_min_numbers(q_0_list, numbers_combined_bins):
    """Ensures that the minimum value of the Q_0 for each bin is always 
    above a minimum threshold that depends on the number of sources
    in each bin.
    """
    q_0 = np.array(q_0_list)
    thresholds = 1./numbers_combined_bins
    q_0[q_0 < thresholds] = thresholds[q_0 < thresholds]
    return q_0

def get_threshold(lr_dist, n_bins=200, n_gal_cut=1000):
    """Get the threshold as the position of the first minima in
    the LR distribution in log space"""
    from scipy.signal import savgol_filter
    val, bins = np.histogram(np.log10(lr_dist + 1), bins=200)
    if n_gal_cut is not None:
        val[val >= n_gal_cut] = n_gal_cut
    v1 = savgol_filter(val, 31, 3)
    g1 = np.gradient(v1) # Firt derivative
    g2 = np.gradient(g1) # Second derivative
    center = get_center(bins)
    t_value = 10**(center[np.argmax(g2 < 0)])-1
    return t_value

## Multiprocessing functions
def parallel_process(array, function, n_jobs=3, use_kwargs=False, front_num=3, notebook=False):
    """
        A parallel version of the map function with a progress bar. 
        Args:
            array (array-like): An array to iterate over.
            function (function): A python function to apply to the elements of array
            n_jobs (int, default=16): The number of cores to use
            use_kwargs (boolean, default=False): Whether to consider the elements of array as dictionaries of 
                keyword arguments to function 
            front_num (int, default=3): The number of iterations to run serially before kicking off the parallel job. 
                Useful for catching bugs
        Returns:
            [function(array[0]), function(array[1]), ...]
        see: http://danshiebler.com/2016-09-14-parallel-progress-bar/
    """
#    if notebook:
#        tqdm_f = tqdm_notebook
#    else:
#        tqdm_f = tqdm
    #We run the first few iterations serially to catch bugs
    if front_num > 0:
        front = [function(**a) if use_kwargs else function(a) for a in array[:front_num]]
    #If we set n_jobs to 1, just run a list comprehension. This is useful for benchmarking and debugging.
    if n_jobs==1:
        return front + [function(**a) if use_kwargs else function(a) for a in tqdm_f(array[front_num:])]
    #Assemble the workers
    with ProcessPoolExecutor(max_workers=n_jobs) as pool:
        #Pass the elements of array into function
        if use_kwargs:
            futures = [pool.submit(function, **a) for a in array[front_num:]]
        else:
            futures = [pool.submit(function, a) for a in array[front_num:]]
        kwargs = {
            'total': len(futures),
            'unit': 'it',
            'unit_scale': True,
            'leave': True
        }
        #Print out the progress as tasks complete
        for f in tqdm_f(as_completed(futures), **kwargs):
            pass
    out = []
    #Get the results from the futures. 
    for i, future in enumerate(tqdm_f(futures)):
        out.append(future.result())
    return front + out
