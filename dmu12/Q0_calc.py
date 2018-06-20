

import numpy as np
from astropy.table import Table
from astropy import units as u
from astropy.coordinates import SkyCoord, search_around_sky
from IPython.display import clear_output
from pymoc import MOC
from pymoc.util.catalog import catalog_to_moc

from mltier import Field, Q_0, parallel_process, describe, gen_rand_cat_inMOC


'''
Finds Q0 (see Flueren et al 2012 for a definition of this parameter and the method used to calculate it) for the given catalogues as well as the optimum radius for crossmatching 

INPUTS
------------
cat1 - the radio catalogue
cat2 - the masterlist
cat1ra - column name of the ra column for cat1
cat1dec - column name of the dec column for cat1
cat2ra - column name of the ra column for cat2
cat2dec - column name of the dec column for cat2
cat2flux - column name of the flux of the sources in cat2 in the band that is being used for the crossmatching
ra_down - the ra that defines the left side of a rectangle encompasing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
ra_up - the ra that defines the right side of a rectangle encompasing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
dec_down - the dec that defines the bottom side of a rectangle encompasing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
dec_up - the dec that defines the upper side of a rectangle encompassing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
radius_low - lower radius that Q0 is computed for in arcseconds. Value given must be >0 and if too small may cause the code to crash (would advise >=0.01)
radius_high - upper radius that Q0 is computed forcin arcseconds
steps - the number of intermediate radii that Q0 is computed for
moc - a moc defining the area the crossmatching will be done in 

OUTPUTS
------------
Q0 - the maximum value of Q0
rads - the radius at which the maximum value of Q0 is found in arcseconds
''' 

def Q0_calc(cat1,cat2,cat1ra,cat1dec,cat2ra,cat2dec,cat2flux,ra_down,ra_up,dec_down,dec_up,radius_low,radius_up,steps,moc=None):   
    
    field = Field(ra_down, ra_up, dec_down, dec_up, moc)
    
    radio = cat1
    
    masterlist_data = cat2
    
    radio = field.filter_catalogue(radio, colnames=(cat1ra,cat1dec))
    
    masterlist = field.filter_catalogue(masterlist_data, colnames=(cat2ra,cat2dec))
    
    coords_masterlist = SkyCoord(masterlist[cat2ra], 
                               masterlist[cat2dec], 
                               unit=(u.deg, u.deg), 
                               frame='icrs')
    
    coords_radio = SkyCoord(radio[cat1ra], 
                           radio[cat1dec], 
                           unit=(u.deg, u.deg), 
                           frame='icrs')
    
    n_iter = 10
    
    rads = np.linspace(radius_low,radius_up,steps)
    
    q_0_comp_i = Q_0(coords_radio, coords_masterlist, field)
    
    q_0_rad_i = []
    print('starting to find Q0. This will take a while')
    for radius in rads:
        print('finding Q0 with radius = {} arcseconds'.format(radius))
        q_0_rad_aux = []
        for i in range(n_iter):
            out = q_0_comp_i(radius=radius)
            q_0_rad_aux.append(out)
        q_0_rad_i.append(np.mean(q_0_rad_aux))
        #print("{:7.5f} {:7.5f} +/- {:7.5f} [{:7.5f} {:7.5f}]".format(radius, 
        #        np.mean(q_0_rad_aux), np.std(q_0_rad_aux), 
        #        np.min(q_0_rad_aux), np.max(q_0_rad_aux)))
    
    mask = q_0_rad_i == max(q_0_rad_i)
    return(q_0_rad_i,rads)
