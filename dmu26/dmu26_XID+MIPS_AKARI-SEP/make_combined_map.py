import xidplus
import pickle
import numpy as np
from xidplus import catalogue
from xidplus import moc_routines
from astropy import wcs
from astropy.io import fits
from xidplus import posterior_maps as postmaps
from astropy import wcs

import os
import sys
import csv

sys.path.remove("/mnt/pact/im281/HELP/XID_plus")
sys.path.remove("/mnt/pact/im281/HELP/herschelhelp_python")


output_folder='./data/changed_psf/'



#First run: Tiles.pkl
#####################
# read in csv file to check how many files there are
total_files = 0
with open('tiles.csv', 'r') as csvFile:
    reader = csv.reader(csvFile)
    for row in reader:
        total_files += 1

csvFile.close()

# run hierarchical_tile on each one:

for t in range(total_files-1):
    with open(output_folder+'Tiles'+str(t)+'.pkl',"rb") as f:
        Master = pickle.load(f)
    tiles=Master['tiles']
    order=Master['order']

    outfile=output_folder+'Master_prior'+str(t)+'.pkl'
    with open(outfile, 'rb') as f:
        obj=pickle.load(f)
    priors=obj['priors']



    hdulist24=postmaps.make_fits_image(priors[0],np.full_like(priors[0].sim,np.nan))


    failed_tiles=[]
    for i in range(0,len(tiles)):
	    print('On tile '+str(i)+' out of '+str(len(tiles)))
	    try:
		    Bayes_24_tile=fits.open(output_folder+'Tile_'+str(tiles[i])+'_'+str(order)+'_MIPS_24_Bayes_Pval.fits')

		    x_ind,y_ind=np.meshgrid(np.arange(0,Bayes_24_tile[1].header['NAXIS1'],dtype=np.int16)-Bayes_24_tile[1].header['CRPIX1']+hdulist24[1].header['CRPIX1'],np.arange(0,Bayes_24_tile[1].header['NAXIS2'],dtype=np.int16)-Bayes_24_tile[1].header['CRPIX2']+hdulist24[1].header['CRPIX2'])

		    good=Bayes_24_tile[1].data>-6

		    hdulist24[1].data[y_ind[good].astype(np.int16),x_ind[good].astype(np.int16)]=Bayes_24_tile[1].data[good]
		


		    Bayes_24_tile.close()
	    except IOError:
		    print('issue with tile '+str(tiles[i]))
		    failed_tiles.append(tiles[i])
	

    hdulist24.writeto(output_folder+'dmu26_XID+MIPS_AKARI-SEP_Bayes_Pval'+str(t)+'.fits',clobber=True)

    outfile=output_folder+'failed_tiles'+str(t)+'.pkl'
    with open(outfile, 'wb') as f:
        pickle.dump({'tiles':failed_tiles,'order':order},f)
