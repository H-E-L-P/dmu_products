import numpy as np
from astropy.io import fits
from astropy.table import Table
import os

import func_make_cat as fc
import matplotlib.pyplot as plt
from astropy.wcs import WCS
from matplotlib.patches import Ellipse
from astropy.coordinates import SkyCoord
from astropy import units as u



loc = "dmu_products/dmu19/dmu19_HELP-SPIRE-maps/data/"
loc = 'data_HELP_v1.0/'
write_loc = 'data_HELP_v1.0_cat/'

all_names =  ['GAMA-09_SPIRE','GAMA-12_SPIRE','GAMA-15_SPIRE','HATLAS-NGP_SPIRE','HATLAS-SGP_SPIRE','SSDF_SPIRE','AKARI-SEP_SPIRE','Bootes_SPIRE','CDFS-SWIRE_SPIRE','COSMOS_SPIRE','EGS_SPIRE',\
              'ELAIS-N1_SPIRE','ELAIS-N2_SPIRE','ELAIS-S1_SPIRE','HDF-N_SPIRE','Lockman-SWIRE_SPIRE','SA13_SPIRE',\
              'SPIRE-NEP_SPIRE','xFLS_SPIRE','XMM-13hr_SPIRE','XMM-LSS_SPIRE','AKARI-NEP_SPIRE']

dmin = 1e-3 # 1 mJy
reload(fc)
band = ['250','350','500']


for j in range(np.size(all_names)): # loops over all fields and runs the peak finder
    name = all_names[j]+band[0]+'_v1.0.fits' # 250um
    hdulist = fits.open(loc+name)

    dp_250, ep_250, rap_250, decp_250, xp_250, yp_250 = np.array(fc.find_peak(hdulist, dmin)) # run on normal map
    hdulist = fits.open(loc+name)
    # run on inverse map
    dp_n_250, ep_n_250, rap_n_250, decp_n_250, xp_n_250, yp_n_250 = np.array(fc.find_peak(hdulist, dmin, negmap = 'TRUE'))

    name = all_names[j]+band[1]+'_v1.0.fits' # 350um
    hdulist = fits.open(loc+name)
    dp_350, ep_350, rap_350, decp_350, xp_350, yp_350 = np.array(fc.find_peak(hdulist, dmin))
    hdulist = fits.open(loc+name)
    dp_n_350, ep_n_350, rap_n_350, decp_n_350, xp_n_350, yp_n_350 = np.array(fc.find_peak(hdulist, dmin, negmap = 'TRUE'))

    name = all_names[j]+band[2]+'_v1.0.fits' # 500um
    hdulist = fits.open(loc+name)
    dp_500, ep_500, rap_500, decp_500, xp_500, yp_500 = np.array(fc.find_peak(hdulist, dmin))
    hdulist = fits.open(loc+name)
    dp_n_500, ep_n_500, rap_n_500, decp_n_500, xp_n_500, yp_n_500 = np.array(fc.find_peak(hdulist, dmin, negmap = 'TRUE'))

    if all_names[j] == 'AKARI-NEP_SPIRE':
      import pyregion
      region_name = "AKARI-NEP.reg"
      r = pyregion.open(region_name)

      name = all_names[j]+band[0]+'_v1.0.fits' # 250um
      hdulist = fits.open(loc+name)
      r250 = r.get_filter(hdulist[1].header)
      mask = r250.inside(xp_250,yp_250)
      dp_250, ep_250, rap_250, decp_250 = dp_250[mask], ep_250[mask], rap_250[mask], decp_250[mask]
      mask = r250.inside(xp_n_250,yp_n_250)
      dp_n_250, ep_n_250, rap_n_250, decp_n_250 = dp_n_250[mask], ep_n_250[mask], rap_n_250[mask], decp_n_250[mask]

      name = all_names[j]+band[1]+'_v1.0.fits' # 350um
      hdulist = fits.open(loc+name)
      r350 = r.get_filter(hdulist[1].header)
      mask = r350.inside(xp_350,yp_350)
      dp_350, ep_350, rap_350, decp_350 = dp_350[mask], ep_350[mask], rap_350[mask], decp_350[mask]
      mask = r350.inside(xp_n_350,yp_n_350)
      dp_n_350, ep_n_350, rap_n_350, decp_n_350 = dp_n_350[mask], ep_n_350[mask], rap_n_350[mask], decp_n_350[mask]

      name = all_names[j]+band[2]+'_v1.0.fits' # 500um
      hdulist = fits.open(loc+name)
      r500 = r.get_filter(hdulist[1].header)
      mask = r500.inside(xp_500,yp_500)
      dp_500, ep_500, rap_500, decp_500 = dp_500[mask], ep_500[mask], rap_500[mask], decp_500[mask]
      mask = r500.inside(xp_n_500,yp_n_500)
      dp_n_500, ep_n_500, rap_n_500, decp_n_500 = dp_n_500[mask], ep_n_500[mask], rap_n_500[mask], decp_n_500[mask]




    sbin = np.linspace(0.06,0.001,591)

    P = np.zeros(np.size(sbin))
    P_250 = np.zeros(np.size(dp_250))
    for i in range(1,np.size(sbin)):
        use = dp_250 > sbin[i]
        use2 = dp_n_250 > sbin[i]
        if np.size(dp_250[use]) >= 1:
          P[i] =  1. - (1.0*np.size(dp_n_250[use2]))/np.size(dp_250[use])
          use3 = (dp_250 > sbin[i]) & (dp_250 < sbin[i-1])
          P_250[use3] = P[i] 
        else:
          P[i] = 1.0
        
    P[0] = np.max(P)
    bright = dp_250 >= np.max(sbin)
    P_250[bright] = 1
    min_f_250 = np.min(sbin[P>=0.85]) 

    plt.plot(1000*sbin,P, color = 'blue',  linewidth=2)
    plt.plot([1000*min_f_250,1000*min_f_250], [-0.1,1])
    plt.ylim(-0.1,1 )
    plt.xlim(0,60)
    plt.ylabel(r'$1 - \frac{N_{\rm spurious}}{N_{\rm cat}}$',fontsize = 20)
    plt.xlabel('mJy',fontsize = 20)
    plt.title(all_names[j],fontsize = 20)

    P = np.zeros(np.size(sbin))
    P_350 = np.zeros(np.size(dp_350))

    for i in range(np.size(sbin)):
        use = dp_350 > sbin[i]
        use2 = dp_n_350 > sbin[i]
        if np.size(dp_350[use]) >= 1:
          P[i] =  1. - (1.0*np.size(dp_n_350[use2]))/np.size(dp_350[use])
          use3 = (dp_350 > sbin[i]) & (dp_350 < sbin[i-1])
          P_350[use3] = P[i] 
        else:
          P[i] = 1.0
        
    P[0] = np.max(P)
    bright = dp_350 >= np.max(sbin)
    P_350[bright] = 1    
    min_f_350 = np.min(sbin[P>=0.85]) 

    plt.plot(1000*sbin,P, color = 'green',  linewidth=2)
    plt.plot([1000*min_f_350,1000*min_f_350], [-0.1,1])


    P = np.zeros(np.size(sbin))
    P_500 = np.zeros(np.size(dp_500))

    for i in range(np.size(sbin)):
        use = dp_500 > sbin[i]
        use2 = dp_n_500 > sbin[i]
        if np.size(dp_500[use]) >= 1:
          P[i] =  1. - (1.0*np.size(dp_n_500[use2]))/np.size(dp_500[use])
          use3 = (dp_500 > sbin[i]) & (dp_500 < sbin[i-1])
          P_500[use3] = P[i] 
        else:
          P[i] = 1.0

    P[0] = np.max(P)
    bright = dp_500 >= np.max(sbin)
    P_500[bright] = 1    
    min_f_500 = np.min(sbin[P>=0.85]) 

    plt.plot(1000*sbin,P, color = 'red',  linewidth=2)
    plt.plot([1000*min_f_500,1000*min_f_500], [-0.1,1])

    plt.text(30,0.7,'S250 = '+str(1000*min_f_250)+' mJy', fontsize = 15)
    plt.text(30,0.6,'S350 = '+str(1000*min_f_350)+' mJy', fontsize = 15)
    plt.text(30,0.5,'S500 = '+str(1000*min_f_500)+' mJy', fontsize = 15)
    plt.savefig(write_loc+all_names[j]+'_lim.pdf', format='PDF',bbox_inches='tight')
    plt.close()


    hdu = fits.BinTableHDU.from_columns(\
         [fits.Column(name='RA', array=rap_250[P_250 >= 0.85], format ='F'),
         fits.Column(name='Dec', array=decp_250[P_250 >= 0.85], format='F'),
         fits.Column(name='F_BLIND_pix_SPIRE_250', array=dp_250[P_250 >= 0.85], format ='F'),
         fits.Column(name='FErr_BLIND_pix_SPIRE_250', array=ep_250[P_250 >= 0.85], format ='F'),
         fits.Column(name='P', array=P_250[P_250 >= 0.85], format ='F') 
         ])
    hdu.writeto(write_loc+all_names[j]+'250_cat.fits')
    
    hdu = fits.BinTableHDU.from_columns(\
         [fits.Column(name='RA', array=rap_350[P_350 >= 0.85], format ='F'),
         fits.Column(name='Dec', array=decp_350[P_350 >= 0.85], format='F'),
         fits.Column(name='F_BLIND_pix_SPIRE_350', array=dp_350[P_350 >= 0.85], format ='F'),
         fits.Column(name='FErr_BLIND_pix_SPIRE_350', array=ep_350[P_350 >= 0.85], format ='F'),
         fits.Column(name='P', array=P_350[P_350 >= 0.85], format ='F') 
         ])
    hdu.writeto(write_loc+all_names[j]+'350_cat.fits')
    
    hdu = fits.BinTableHDU.from_columns(\
         [fits.Column(name='RA', array=rap_500[P_500 >= 0.85], format ='F'),
         fits.Column(name='Dec', array=decp_500[P_500 >= 0.85], format='F'),
         fits.Column(name='F_BLIND_pix_SPIRE_500', array=dp_500[P_500 >= 0.85], format ='F'),
         fits.Column(name='FErr_BLIND_pix_SPIRE_500', array=ep_500[P_500 >= 0.85], format ='F'),
         fits.Column(name='P', array=P_500[P_500 >= 0.85], format ='F') 
         ])
    hdu.writeto(write_loc+all_names[j]+'500_cat.fits')
    