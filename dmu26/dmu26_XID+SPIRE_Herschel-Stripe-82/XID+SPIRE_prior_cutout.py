    #!/usr/bin/env python
# coding: utf-8

import pylab
import pymoc
import numpy as np
import pylab as plt
from astropy.io import fits
from astropy.table import Table, join
from astropy.table import Column
from astropy import wcs
import glob
import csv
import sys
import os
import xidplus
import pickle
from xidplus import moc_routines
import time

#####################################################

# ## Read in Masterlist
# Read in Masterlist and select only sources that are detected in mid-infrared and at least one other wavelength domain (i.e. optical or nir). This will remove most of the objects in the catalogue that are artefacts. We can do this by using the `flag_optnir_det` flag and selecting sources that have a binary value of $>= 5$
print('read in prior_list: prior_fpred_f5.csv')

prior=Table.read('./data/prior_fpred_f5.csv')



####################################################

# ## Read in MOCs & Files
# The selection functions required are the main MOC associated with the masterlist. Here we use the DataFusion-Spitzer MOC.

bands = ['PSW', 'PMW', 'PLW']
filename = []
moc_file = []
for i in [1,2,3,4]:
    filename.append(np.sort(glob.glob(f"./data/*cutout{i}.fits", recursive=True)))
 
moc_file = np.sort(glob.glob(f"./data/test*MOC.fits", recursive=True))

print('filenames: ', filename)
print('moc_files: ', moc_file)


######################################################################

with open('./data/large_tiles_f5.csv', 'w') as l_tiles_file:
    tiles_writer = csv.writer(l_tiles_file, delimiter=',')
    tiles_writer.writerow(['job_array'])
l_tiles_file.close()

with open('./data/tiles_f5.csv', 'w') as tiles_file:
    tiles_writer = csv.writer(tiles_file, delimiter=',')
    tiles_writer.writerow(['job_array'])
tiles_file.close()


##############################################################

print('iterate over each cutout and band')



for index, cutout in enumerate(filename):
    print('mosaic: ', str(index))
    Final=pymoc.MOC()
    Final.read(moc_file[index]) 

 # Read in Map
    pswfits= cutout[2] #SPIRE 250 map
    pmwfits= cutout[1] #SPIRE 350 map
    plwfits= cutout[0] #SPIRE 500 map
    print('PSW_',str(index),' : ', pswfits)
    print('PMW_',str(index),' : ', pmwfits)
    print('PLW_',str(index),' : ', plwfits)
    #-----250-------------
    hdulist = fits.open(pswfits)
    im250phdu=hdulist[0].header
    im250hdu=hdulist['IMAGE'].header
    im250=hdulist['IMAGE'].data*1.0E3 #convert to mJy
    nim250=hdulist['ERROR'].data*1.0E3 #convert to mJy
    w_250 = wcs.WCS(hdulist['IMAGE'].header)
    pixsize250=3600.0*w_250.wcs.cdelt[1]#[1,1] #pixel size (in arcseconds)
    hdulist.close()
    #-----350-------------
    hdulist = fits.open(pmwfits)
    im350phdu=hdulist[0].header
    im350hdu=hdulist['IMAGE'].header

    im350=hdulist['IMAGE'].data*1.0E3 #convert to mJy
    nim350=hdulist['ERROR'].data*1.0E3 #convert to mJy
    w_350 = wcs.WCS(hdulist['IMAGE'].header)
    pixsize350=3600.0*w_350.wcs.cdelt[1]#[1,1] #pixel size (in arcseconds)
    hdulist.close()
    #-----500-------------
    hdulist = fits.open(plwfits)
    im500phdu=hdulist[0].header
    im500hdu=hdulist['IMAGE'].header

    im500=hdulist['IMAGE'].data*1.0E3 #convert to mJy
    nim500=hdulist['ERROR'].data*1.0E3 #convert to mJy
    w_500 = wcs.WCS(hdulist['IMAGE'].header)
    pixsize500=3600.0*w_500.wcs.cdelt[1]#[1,1] #pixel size (in arcseconds)
    hdulist.close()


 ## Set XID+ prior class
    print('setting XID+ priors')
    start = time.time()
   
    #---prior250--------
    prior250=xidplus.prior(im250,nim250,im250phdu,im250hdu, moc=Final)#Initialise with map, uncertianty map, wcs info and primary header
    prior250.prior_cat(prior['RA'], prior['DEC'], 'prior_fpred_f20.fits',ID=prior['help_id'] )#Set input catalogue
    prior250.prior_bkg(-5.0,5)#Set prior on background (assumes Gaussian pdf with mu and sigma)
    end = time.time()
    print('finished init prior250', end - start)

    #---prior350--------
    start = time.time()
    prior350=xidplus.prior(im350,nim350,im350phdu,im350hdu, moc=Final)
    prior350.prior_cat(prior['RA'], prior['DEC'], 'prior_fpred_f20.fits',ID=prior['help_id'] )
    prior350.prior_bkg(-5.0,5)
    end = time.time()
    print('finished init prior350', end - start)
   
    #---prior500--------
    start = time.time()
    prior500=xidplus.prior(im500,nim500,im500phdu,im500hdu, moc=Final)
    prior500.prior_cat(prior['RA'], prior['DEC'], 'prior_fpred_f20.fits',ID=prior['help_id'] )
    prior500.prior_bkg(-5.0,5)
    end = time.time()
    print('finished init prior500', end - start)

        
   #pixsize array (size of pixels in arcseconds)
    pixsize=np.array([pixsize250,pixsize350,pixsize500])
   #point response function for the three bands
    prfsize=np.array([18.15,25.15,36.3])
    #use Gaussian2DKernel to create prf (requires stddev rather than fwhm hence pfwhm/2.355)
    from astropy.convolution import Gaussian2DKernel

    ##---------fit using Gaussian beam-----------------------
    prf250=Gaussian2DKernel(prfsize[0]/2.355,x_size=101,y_size=101)
    prf250.normalize(mode='peak')
    prf350=Gaussian2DKernel(prfsize[1]/2.355,x_size=101,y_size=101)
    prf350.normalize(mode='peak')
    prf500=Gaussian2DKernel(prfsize[2]/2.355,x_size=101,y_size=101)
    prf500.normalize(mode='peak')

    pind250=np.arange(0,101,1)*1.0/pixsize[0] #get 250 scale in terms of pixel scale of map
    pind350=np.arange(0,101,1)*1.0/pixsize[1] #get 350 scale in terms of pixel scale of map
    pind500=np.arange(0,101,1)*1.0/pixsize[2] #get 500 scale in terms of pixel scale of map

    prior250.set_prf(prf250.array,pind250,pind250)#requires psf as 2d grid, and x and y bins for grid (in pixel scale)
    prior350.set_prf(prf350.array,pind350,pind350)
    prior500.set_prf(prf500.array,pind500,pind500)


# ## Calculate tiles
# As fitting the whole map would be too computationally expensive, I split based on HEALPix pixels. For MIPS, the optimum order is 11. So that I don't have to read the master prior based on the whole map into memory each time (which requires a lot more memory) I also create another layer of HEALPix pixels based at the lower order of 6.

    #from moc, get healpix pixels at a given order
    order=9
    tiles=moc_routines.get_HEALPix_pixels(order,prior250.sra,prior250.sdec,unique=True)
    order_large=6
    tiles_large=moc_routines.get_HEALPix_pixels(order_large,prior250.sra,prior250.sdec,unique=True)
    with open('./data/large_tiles_f5.csv', 'a') as l_tiles_file:
        tiles_writer = csv.writer(l_tiles_file, delimiter=',')
        tiles_writer.writerow([str(len(tiles_large))])
    l_tiles_file.close()

    with open('./data/tiles_f5.csv', 'a') as tiles_file:
        tiles_writer = csv.writer(tiles_file, delimiter=',')
        tiles_writer.writerow([str(len(tiles))])
    tiles_file.close()
    print('----- There are '+str(len(tiles))+' tiles required for input catalogue and '+str(len(tiles_large))+' large tiles in cutout' + str(index+1))
    
    output_folder='./data/'+str(index)+'/'
    os.mkdir(output_folder)
    outfile=output_folder+'Master_prior.pkl'
    
    xidplus.io.pickle_dump({'priors':[prior250,prior350,prior500],'tiles':tiles,'order':order,'version':xidplus.io.git_version()},outfile)
    outfile=output_folder+'Tiles.pkl'
    with open(outfile, 'wb') as f:
        pickle.dump({'tiles':tiles,'order':order,'tiles_large':tiles_large,'order_large':order_large,'version':xidplus.io.git_version()},f)
    #raise SystemExit()
    #from moc, get healpix pixels at a given order

