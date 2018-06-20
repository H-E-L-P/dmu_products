'''
Adopting the liklihood ratio code from https://github.com/nudomarinero/mltier1 to use for crossmatching radio catalogues to the HELP masterlist

The original code was used in Williams et al 2018 using the method described by Fleuren et al 2012
'''
import numpy as np
import astropy
from astropy.table import Table, hstack
from astropy import units as u
from astropy.coordinates import SkyCoord, search_around_sky
from IPython.display import clear_output
from scipy.optimize import curve_fit
import pickle
import os
from pymoc import MOC
from matplotlib import pyplot as plt

#import mltier which is a non standard HELP module 

from mltier import (get_center, get_n_m, estimate_q_m, Field, SingleMLEstimator, MultiMLEstimator,
                     parallel_process, get_sigma, get_q_m, get_threshold, q0_min_level, q0_min_numbers)


'''
Runs an adapted version of the liklihood ratio code from https://github.com/nudomarinero/mltier1 to crossmatch radio catalogues to the HELP masterlist

The original code was used in Williams et al 2018 using the method described by Fleuren et al 2012

INPUTS
------------
cat1 - the radio catalogue
cat2 - the masterlist
cat1ra - column name of the ra column for cat1
cat1dec - column name of the dec column for cat1
cat2ra - column name of the ra column for cat2
cat2dec - column name of the dec column for cat2
cat2mag - column name of the magnitude of the sources in cat2 in the band that is being used for the crossmatching (must be a magnitude or your crossmatch will be incorrect)
Q0_i - the value of Q0 used for the crossmatching
radius - the radius used for the crossmatching in arcseconds
ra_down - the ra that defines the left side of a rectangle encompasing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
ra_up - the ra that defines the right side of a rectangle encompasing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
dec_down - the dec that defines the bottom side of a rectangle encompasing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
dec_up - the dec that defines the upper side of a rectangle encompassing the area the crossmatching will be done in (this parameter is redundant if a moc is provided)
moc - a moc defining the area the crossmatching will be done in 

OUTPUTS
------------
new_table - A masterlist table of the crossmatched sources containing all the columns from cat1 and cat2
'''
def likelihood_ratio(cat1,cat2,cat1ra,cat1dec,cat2ra,cat2dec,cat2mag,Q0_i,radius,
                     ra_down,ra_up,dec_down,dec_up,moc=None):


    field = Field(ra_down, ra_up, dec_down, dec_up, moc)
    
    radio_150mhz = cat1
    masterlist = cat2

    # Filter radio catalogue with the field 
    radio = field.filter_catalogue(radio_150mhz, colnames=(cat1ra,cat1dec))
    print('number of radio sources being crossmatched is {}'.format(len(radio)))

    # Filter the masterlist with the field
    masterlist = field.filter_catalogue(masterlist, colnames=(cat2ra,cat2dec))
    print('number of masterlist sources being crossmatched too is {}'.format(len(masterlist)))

    coords_masterlist = SkyCoord(masterlist[cat2ra], 
                           masterlist[cat2dec], 
                           unit=(u.deg, u.deg), 
                           frame='icrs')

    coords_radio = SkyCoord(radio[cat1ra], 
                       radio[cat1dec], 
                       unit=(u.deg, u.deg), 
                       frame='icrs')

    masterlist[cat2mag][np.isnan(masterlist[cat2mag])] = 0

    catalogue_i = masterlist

    mask = catalogue_i[cat2mag] != 0 
    bin_list_i = np.arange(np.min(catalogue_i[mask][cat2mag]), np.max(catalogue_i[mask][cat2mag]), 0.5) # Bins of 0.5

    center_i = get_center(bin_list_i)
    # get the mid point of each bin i.e if there is a bin from 1 to 4 then the centre will be at 2.5

    n_m_i = get_n_m(catalogue_i[cat2mag], bin_list_i, field.area)
    # get a cumulative distribution of the magnitudes divided by the field area
    q_m_i = estimate_q_m(catalogue_i[cat2mag], bin_list_i, n_m_i, coords_radio, coords_masterlist, radius=radius)
    
    # ### $Q_0$ and likelihood estimators
    q0 = Q0_i
    likelihood_ratio_i = SingleMLEstimator(Q0_i, n_m_i, q_m_i, center_i)
     
    idx_radio, idx_i, d2d, d3d = search_around_sky(
        coords_radio, coords_masterlist, radius*u.arcsec)
    
    idx_radio_unique = np.unique(idx_radio)

    radio["lr_i"] = np.nan                   # Likelihood ratio
    radio["lr_dist_i"] = np.nan              # Distance to the selected source
    radio["lr_index_i"] = np.nan             # Index of the source in masterlist
    
    total_sources = len(idx_radio_unique)
    masterlist_aux_index = np.arange(len(masterlist))
    
    def ml(i):
        
        idx_0 = idx_i[idx_radio == i]
    
        d2d_0 = d2d[idx_radio == i]
    
        i_mag = catalogue_i[cat2mag][idx_0]
        
        
        radio_ra = radio[i]["RA"]
        radio_dec = radio[i]["DEC"]
        radio_pa = radio[i]["PA"]
        radio_maj_err = radio[i]["E_Maj"]
        radio_min_err = radio[i]["E_Min"]
        c_ra = catalogue_i["ra"][idx_0]
        c_dec = catalogue_i["dec"][idx_0]
        # Error for masterlist given as the true error is difficult to compute due to the composite nature of the masterlist
        c_ra_err = 1/3600
        c_dec_err = 1/3600
        
        sigma = get_sigma(radio_maj_err, radio_min_err, radio_pa, 
                          radio_ra, radio_dec, 
                          c_ra, c_dec, c_ra_err, c_dec_err)
        
        lr_0 = likelihood_ratio_i(i_mag, d2d_0.arcsec, sigma)
        
        if len(lr_0) == 0:
            result = [np.nan,np.nan,np.nan]
            return result,np.nan
        chosen_index = np.argmax(lr_0)
        lr_sum = np.sum(lr_0)
        rel = lr_0/(lr_sum + (1-q0))
        result = [masterlist_aux_index[idx_0[chosen_index]], # Index
                  (d2d_0.arcsec)[chosen_index],              # distance
                  lr_0[chosen_index]]                        # LR

    
        return (result,rel[chosen_index])
    
    print('starting the crossmatch')
    res = []
    rel = []
    nomatches = 0
    for i in range(len(radio)):
        result,reliab = ml(i)
        if result == [np.nan,np.nan,np.nan]:
            nomatches = nomatches + 1
            continue
        res.append(result)
        rel.append(reliab)
    
    print('number of sources with no possible match is {}'.format(nomatches))
    
    (radio["lr_index_i"][idx_radio_unique], 
     radio["lr_dist_i"][idx_radio_unique], 
     radio["lr_i"][idx_radio_unique]) = list(map(list, zip(*res)))
    
    
    # #### Threshold and selection for i-band
    
    radio["lr_i"][np.isnan(radio["lr_i"])] = 0
    
    threshold_i = np.percentile(radio[radio['lr_i'] !=0]["lr_i"], 100*(1 - Q0_i))
    print('liklihood ratio threshold using Q0 only is {}'.format(threshold_i))
    
    radio["lrt"] = radio["lr_i"]
    radio["lrt"][np.isnan(radio["lr_i"])] = 0
    
    print('updating threshold of liklihood ratio that can be trusted')      
    def completeness(lr, threshold, q0):
        n = len(lr)
        lrt = lr[lr < threshold]
        return 1. - np.sum((q0 * lrt)/(q0 * lrt + (1 - q0)))/float(n)
    
    def reliability(lr, threshold, q0):
        n = len(lr)
        lrt = lr[lr > threshold]
        return 1. - np.sum((1. - q0)/(q0 * lrt + (1 - q0)))/float(n)
    
    completeness_v = np.vectorize(completeness, excluded=[0])
    reliability_v = np.vectorize(reliability, excluded=[0])
    
    n_test = 100
    threshold_mean = np.percentile(radio["lrt"], 100*(1 - q0))
    
    thresholds = np.arange(0., 10., 0.01)
    thresholds_fine = np.arange(0.1, 1., 0.001)
    
    completeness_t = completeness_v(radio["lrt"], thresholds, q0)
    reliability_t = reliability_v(radio["lrt"], thresholds, q0)
    average_t = (completeness_t + reliability_t)/2
    
    completeness_t_fine = completeness_v(radio["lrt"], thresholds_fine, q0)
    reliability_t_fine = reliability_v(radio["lrt"], thresholds_fine, q0)
    average_t_fine = (completeness_t_fine + reliability_t_fine)/2
    
    threshold_sel = thresholds_fine[np.argmax(average_t_fine)]
    print('liklihood ratio updated threshold considering completeness and reliability is {}'.format(threshold_sel))
    

    
        # ##### create a table containing the radio sources whose likelihood matches were above the new threshold and create a table of the data for the counterparts and then merge then using hstack
    print('creating masterlist table of cross matched sources')
    radio_match = radio[~np.isnan(radio['lr_dist_i'])]
    radio_match = radio_match[radio_match['lr_i']>threshold_sel]

    lockman_match = masterlist[radio_match['lr_index_i'].quantity.value.astype(int)]
    
    new_table = astropy.table.hstack([radio_match,lockman_match],join_type='outer')
    print('number of crossmatched sources is {}'.format(len(new_table)))

    return(new_table)
    