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
output_folder='./data/'

with open(output_folder+'Tiles_SPUDS.pkl', "rb") as f:
        Master = pickle.load(f)
tiles=Master['tiles']
order=Master['order']

outfile=output_folder+'Master_prior_SPUDS.pkl'
obj=xidplus.io.pickle_load(outfile)
priors = obj['priors']


#hdulist24=fits.open(output_folder+'dmu26_XID+MIPS_Lockman-SWIRE_Bayes_Pval.fits')
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
	

hdulist24.writeto(output_folder+'dmu26_XID+MIPS_XMM-LSS_Bayes_Pval_SPUDS.fits',clobber=True)

outfile=output_folder+'failed_tiles_SPUDS.pkl'
with open(outfile, 'wb') as f:
   pickle.dump({'tiles':failed_tiles,'order':order},f)
print('There are '+str(len(failed_tiles))+' failed tiles')
