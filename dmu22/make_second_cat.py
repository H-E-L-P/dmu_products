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

loc = "data_HELP_v1.0/"


all_names =  ['GAMA-09_SPIRE','GAMA-12_SPIRE','GAMA-15_SPIRE','HATLAS-NGP_SPIRE','HATLAS-SGP_SPIRE','SSDF_SPIRE','AKARI-SEP_SPIRE','Bootes_SPIRE','CDFS-SWIRE_SPIRE','COSMOS_SPIRE','EGS_SPIRE',\
              'ELAIS-N1_SPIRE','ELAIS-N2_SPIRE','ELAIS-S1_SPIRE','HDF-N_SPIRE','Lockman-SWIRE_SPIRE','SA13_SPIRE',\
              'SPIRE-NEP_SPIRE','xFLS_SPIRE','XMM-13hr_SPIRE','XMM-LSS_SPIRE']


band = ['250','350','500']
for j in range(np.size(all_names)):


	################################ source detections

	name = all_names[j]+band[0]+'_v1.0.fits'
	hdulist1 = fits.open(loc+name)
	name = all_names[j]+band[1]+'_v1.0.fits'
	hdulist2 = fits.open(loc+name)
	name = all_names[j]+band[2]+'_v1.0.fits'
	hdulist3 = fits.open(loc+name)

	ff = fits.open(loc+all_names[j]+'250_cat.fits')
	ra1,dec1 = (ff[1].data)['RA'],(ff[1].data)['DEC']

	r_1, ra_1, dec_1, S250_1, E250_1, S350_1, E350_1, S500_1, E500_1 = \
	            fc.corr_psf_max_MF(hdulist1,hdulist2,hdulist3,ra1, dec1)
	hdu = fits.BinTableHDU.from_columns(\
	     [fits.Column(name='RA', array=ra_1, format ='F'),
	     fits.Column(name='Dec', array=dec_1, format='F'),
	     fits.Column(name='F_BLIND_MF_SPIRE_250', array=S250_1, format ='F'),
	     fits.Column(name='FErr_BLIND_MF_SPIRE_250', array=E250_1, format ='F'),
	     fits.Column(name='F_BLIND_MF_SPIRE_350', array=S350_1, format ='F'),
	     fits.Column(name='FErr_BLIND_MF_SPIRE_350', array=E350_1, format ='F'),
	     fits.Column(name='F_BLIND_MF_SPIRE_500', array=S500_1, format ='F'),
	     fits.Column(name='FErr_BLIND_MF_SPIRE_500', array=E500_1, format ='F'),
	     fits.Column(name='r', array=r_1, format ='F'),
	     fits.Column(name='P', array=(ff[1].data)['P'], format ='F'),
	     fits.Column(name='RA_pix', array=(ff[1].data)['RA'], format ='F'), 
	     fits.Column(name='Dec_pix', array=(ff[1].data)['Dec'], format ='F'), 
	     fits.Column(name='F_BLIND_pix_SPIRE_250', array=(ff[1].data)['F_BLIND_pix_SPIRE_250'], format ='F'), 
	     fits.Column(name='FErr_BLIND_pix_SPIRE_250', array=(ff[1].data)['FErr_BLIND_pix_SPIRE_250'], format ='F') 
	     ])
	hdu.writeto(loc+all_names[j]+'250_cat_MF.fits') 

	ff = fits.open('data_HELP_v1.0_cat/'+all_names[j]+'350_cat.fits')
	ra2,dec2 = (ff[1].data)['RA'],(ff[1].data)['DEC']
	r_2, ra_2, dec_2, S350_2, E350_2, S250_2, E250_2, S500_2, E500_2 = \
	            fc.corr_psf_max_MF(hdulist2,hdulist1,hdulist3,ra2, dec2)

	hdu = fits.BinTableHDU.from_columns(\
	     [fits.Column(name='RA', array=ra_2, format ='F'),
	     fits.Column(name='Dec', array=dec_2, format='F'),
	     fits.Column(name='F_BLIND_MF_SPIRE_250', array=S250_2, format ='F'),
	     fits.Column(name='FErr_BLIND_MF_SPIRE_250', array=E250_2, format ='F'),
	     fits.Column(name='F_BLIND_MF_SPIRE_350', array=S350_2, format ='F'),
	     fits.Column(name='FErr_BLIND_MF_SPIRE_350', array=E350_2, format ='F'),
	     fits.Column(name='F_BLIND_MF_SPIRE_500', array=S500_2, format ='F'),
	     fits.Column(name='FErr_BLIND_MF_SPIRE_500', array=E500_2, format ='F'),
	     fits.Column(name='r', array=r_2, format ='F'),
	     fits.Column(name='P', array=(ff[1].data)['P'], format ='F'),
	     fits.Column(name='RA_pix', array=(ff[1].data)['RA'], format ='F'), 
	     fits.Column(name='Dec_pix', array=(ff[1].data)['Dec'], format ='F'), 
	     fits.Column(name='F_BLIND_pix_SPIRE_350', array=(ff[1].data)['F_BLIND_pix_SPIRE_350'], format ='F'), 
	     fits.Column(name='FErr_BLIND_pix_SPIRE_350', array=(ff[1].data)['FErr_BLIND_pix_SPIRE_350'], format ='F') 
	     ])
	hdu.writeto(loc+all_names[j]+'350_cat_MF.fits') 



	ff = fits.open('data_HELP_v1.0_cat/'+all_names[j]+'500_cat.fits')
	ra3,dec3 = (ff[1].data)['RA'],(ff[1].data)['DEC']
	r_3, ra_3, dec_3, S500_3, E500_3, S250_3, E250_3, S350_3, E350_3 = \
	            fc.corr_psf_max_MF(hdulist3,hdulist1,hdulist2,ra3, dec3)

	hdu = fits.BinTableHDU.from_columns(\
	     [fits.Column(name='RA', array=ra_3, format ='F'),
	     fits.Column(name='DEC', array=dec_3, format='F'),
	     fits.Column(name='S250', array=S250_3, format ='F'),
	     fits.Column(name='E250', array=E250_3, format ='F'),
	     fits.Column(name='S350', array=S350_3, format ='F'),
	     fits.Column(name='E350', array=E350_3, format ='F'),
	     fits.Column(name='S500', array=S500_3, format ='F'),
	     fits.Column(name='E500', array=E500_3, format ='F'),
	     fits.Column(name='r', array=r_3, format ='F'),
	     fits.Column(name='P', array=(ff[1].data)['P'], format ='F'),
	     fits.Column(name='RA_old', array=(ff[1].data)['RA'], format ='F'), 
	     fits.Column(name='DEC_old', array=(ff[1].data)['DEC'], format ='F'), 
	     fits.Column(name='S500_old', array=(ff[1].data)['S500'], format ='F'), 
	     fits.Column(name='E500_old', array=(ff[1].data)['E500'], format ='F') 
	     ])
	hdu.writeto(loc+all_names[j]+'500_cat_MF.fits') 