#!/usr/bin/env python
# coding: utf-8

import pylab
import pymoc
import numpy as np
#get_ipython().run_line_magic('matplotlib', 'inline')
import pylab as plt
from astropy.io import fits
from astropy.table import Table
from astropy.table import Column
from astropy import wcs
import glob
import csv
import sys
import os
import glob
import pandas as pd
import xidplus
import pickle
from xidplus import moc_routines



# ## Read in Masterlist
# Read in Masterlist and select only sources that are detected in mid-infrared and at least one other wavelength domain (i.e. optical or nir). This will remove most of the objects in the catalogue that are artefacts. We can do this by using the `flag_optnir_det` flag and selecting sources that have a binary value of $>= 5$

field = 'HDF-N'
date = 'ipac'
masterfile='n_mips_1_s1_v0.91_srclist.tbl'#'master_catalogue_hdf-n_20201103.fits'#'master_catalogue_hdf-n_20180427.fits'
masterlist=Table.read('../dmu26_XID+MIPS_HDF-N/data/n_mips_1_s1_v0.91_srclist.tbl', format='ascii.ipac') #fits.open('../../dmu1/dmu1_ml_'+field+'/data/'+masterfile)
# good=masterlist[1].data['flag_optnir_det']>=5

MIPS_lower=np.full(len(masterlist),0.0)
MIPS_upper=np.full(len(masterlist),1E5)

# MIPS_lower=np.full(good.sum(),0.0)
# MIPS_upper=np.full(good.sum(),1E5)

# for i in range(0,good.sum()):
#     if ~np.isnan(masterlist[1].data['f_irac_i4'][good][i]):
#         MIPS_lower[i]=masterlist[1].data['f_irac_i4'][good][i]/500.0
#         MIPS_upper[i]=masterlist[1].data['f_irac_i4'][good][i]*500.0
#     elif ~np.isnan(masterlist[1].data['f_irac_i3'][good][i]):
#         MIPS_lower[i]=masterlist[1].data['f_irac_i3'][good][i]/500.0
#         MIPS_upper[i]=masterlist[1].data['f_irac_i3'][good][i]*500.0
#     elif ~np.isnan(masterlist[1].data['f_irac_i2'][good][i]):
#         MIPS_lower[i]=masterlist[1].data['f_irac_i2'][good][i]/500.0
#         MIPS_upper[i]=masterlist[1].data['f_irac_i2'][good][i]*500.0
#     elif ~np.isnan(masterlist[1].data['f_irac_i1'][good][i]):
#         MIPS_lower[i]=masterlist[1].data['f_irac_i1'][good][i]/500.0
#         MIPS_upper[i]=masterlist[1].data['f_irac_i1'][good][i]*500.0
        
# np.savez('./tmp_mips_prior2', MIPS_lower, MIPS_upper)


# npzfile = np.load('./data/tmp_mips_prior2.npz')
# MIPS_lower=npzfile['arr_0']
# MIPS_upper=npzfile['arr_1']


# ## Read in PSF

MIPS_psf=fits.open('../../dmu17/dmu17_HELP_SEIP_maps/'+field+'/data/output_data/dmu17_MIPS_HDF-N_20201111.fits')

dat=MIPS_psf[1].data
plt.hist(dat.flatten(),bins=np.arange(-100.0,200.0,1.0));
plt.yscale('log')


centre=np.long((MIPS_psf[1].header['NAXIS1']-1)/2)
radius=11

#plt.imshow(np.log10(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1]/np.max(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1])))
#plt.colorbar()


######################################################################


# ## Read in MOCs & Files
# The selection functions required are the main MOC associated with the masterlist. Here we use the DataFusion-Spitzer MOC.

filename = np.sort(glob.glob(f"../../dmu17/dmu17_HELP_SEIP_maps/HDF-N/data/*help.fits", recursive=True))
moc_file = np.sort(glob.glob(f"../../dmu17/dmu17_HELP_SEIP_maps/HDF-N/data/*moc.fits", recursive=True))

Sel_func=pymoc.MOC()
Sel_func.read('../../dmu4/dmu4_sm_'+field+'/data/holes_HDF-N_irac1_O16_20190201_WARNING-MADE-WITH-Lockman-SWIRE-PARAMS.fits')


######################################################################

# with open('./data/changed_psf/large_tiles.csv', 'w') as l_tiles_file:
#     tiles_writer = csv.writer(l_tiles_file, delimiter=',')
#     tiles_writer.writerow(['job_array'])
# l_tiles_file.close()

# with open('./data/changed_psf/tiles.csv', 'w') as tiles_file:
#     tiles_writer = csv.writer(tiles_file, delimiter=',')
#     tiles_writer.writerow(['job_array'])
# tiles_file.close()


with open('./data/'+date+'/large_tiles.csv', 'w') as l_tiles_file:
    tiles_writer = csv.writer(l_tiles_file, delimiter=',')
    tiles_writer.writerow(['job_array'])
l_tiles_file.close()

with open('./data/'+date+'/tiles.csv', 'w') as tiles_file:
    tiles_writer = csv.writer(tiles_file, delimiter=',')
    tiles_writer.writerow(['job_array'])
tiles_file.close()



##############################################################

print('iterate over each mosaic')
for index, mosaic in enumerate (moc_file):
    print('mosaic: ', index)
    mosaic_MOC=pymoc.MOC()
    mosaic_MOC.read(mosaic)

    Final=Sel_func.intersection(mosaic_MOC)
    
#     Final.write('./data/changed_psf/testMoc.fits', overwrite=True)
    Final.write('./data/'+date+'/testMoc.fits', overwrite=True)
    
    if len(Final) == 0:
        print ('MOC not in field')
        continue
        
    else:
## Read in Map
        MIPS_Map=fits.open(filename[index])

        w_im = wcs.WCS(MIPS_Map[1].header) 
        w_nim = wcs.WCS(MIPS_Map[2].header) 
        #print('w_im: ', w_im, '\n w_nim: ', w_nim)

        MIPS_Map[1].header['CRVAL1']=MIPS_Map[2].header['CRVAL1']
        MIPS_Map[1].header['CRVAL2']=MIPS_Map[2].header['CRVAL2']

        data=MIPS_Map[1].data
        mean_data = np.mean(data[~np.isnan(data)])
        
# ## Set XID+ prior class
        print('setting XID+ priors')
        prior_MIPS=xidplus.prior(MIPS_Map[1].data - mean_data,MIPS_Map[2].data,MIPS_Map[0].header,MIPS_Map[1].header,moc=Final)
        prior_MIPS.prior_cat(masterlist['ra'],masterlist['dec'],masterfile,flux_lower=MIPS_lower, flux_upper=MIPS_upper, ID=masterlist['SrcID'])

#         prior_MIPS.prior_cat(masterlist[1].data['ra'][good],masterlist[1].data['dec'][good],masterfile,flux_lower=MIPS_lower, flux_upper=MIPS_upper,ID=masterlist[1].data['help_id'][good])


    #prior_MIPS.sra

    #xidplus.plot_map([prior_MIPS])

#         prior_MIPS.set_prf(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1]/1.0E6,np.arange(0,11/2.0,0.5),np.arange(0,11/2.0,0.5))

# # fix bug on psf resolution
#         prior_MIPS.set_prf(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1]/1.0E6,np.arange(0,11.0,1.0),np.arange(0,11.0,1.0))

        prior_MIPS.set_prf(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1]/1.0E6,np.arange(0,23/2.0,0.5),np.arange(0,23/2.0,0.5))


# ## Calculate tiles
# As fitting the whole map would be too computationally expensive, I split based on HEALPix pixels. For MIPS, the optimum order is 11. So that I don't have to read the master prior based on the whole map into memory each time (which requires a lot more memory) I also create another layer of HEALPix pixels based at the lower order of 6.


#from moc, get healpix pixels at a given order

        order=11
        tiles=moc_routines.get_HEALPix_pixels(order,prior_MIPS.sra,prior_MIPS.sdec,unique=True)
        order_large=6
        tiles_large=moc_routines.get_HEALPix_pixels(order_large,prior_MIPS.sra,prior_MIPS.sdec,unique=True)
    
#         with open('./data/changed_psf/large_tiles.csv', 'a') as l_tiles_file:
#             tiles_writer = csv.writer(l_tiles_file, delimiter=',')
#             tiles_writer.writerow([str(len(tiles_large))])
#         tiles_file.close()
    
#         with open('./data/changed_psf/tiles.csv', 'a') as tiles_file:
#             tiles_writer = csv.writer(tiles_file, delimiter=',')
#             tiles_writer.writerow([str(len(tiles))])
#         tiles_file.close()
        
        with open('./data/'+date+'/large_tiles.csv', 'a') as l_tiles_file:
            tiles_writer = csv.writer(l_tiles_file, delimiter=',')
            tiles_writer.writerow([str(len(tiles_large))])
        tiles_file.close()
    
        with open('./data/'+date+'/tiles.csv', 'a') as tiles_file:
            tiles_writer = csv.writer(tiles_file, delimiter=',')
            tiles_writer.writerow([str(len(tiles))])
        tiles_file.close()
    
    
        print('----- There are '+str(len(tiles))+' tiles required for input catalogue and '+str(len(tiles_large))+' large tiles in mosaic' + str(mosaic[:]))
#         output_folder='./data/changed_psf/'+str(index)+'/'

        output_folder='./data/'+date+'/'+str(index)+'/'
        os.mkdir(output_folder)
        outfile=output_folder+'Master_prior.pkl'
        with open(outfile, 'wb') as f:
            pickle.dump({'priors':[prior_MIPS],'tiles':tiles,'order':order,'version':xidplus.io.git_version()},f)
        outfile=output_folder+'Tiles.pkl'
        with open(outfile, 'wb') as f:
            pickle.dump({'tiles':tiles,'order':order,'tiles_large':tiles_large,'order_large':order_large,'version':xidplus.io.git_version()},f)
raise SystemExit()









