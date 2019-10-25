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


output_folder='./data/'

with open(output_folder+'Tiles.pkl', "rb") as f:
        Master = pickle.load(f)
tiles=Master['tiles']
order=Master['order']

outfile=output_folder+'Master_prior.pkl'
with open(outfile, 'rb') as f:
    obj=pickle.load(f)
priors=obj['priors']

bands=['psw','pmw','plw']

hdulists=list(map(lambda prior: postmaps.make_fits_image(prior,np.full_like(prior.sim,np.nan)),priors))

failed_tiles=[]
for i in range(0,len(tiles)):
	print('On tile '+str(i)+' out of '+str(len(tiles)))
	try:
		for b in range(0,len(priors)):
			Bayes_tile=fits.open(output_folder+'Tile_'+str(tiles[i])+'_'+str(order)+'_'+bands[b]+'_Bayes_Pval.fits')

			x_ind,y_ind=np.meshgrid(np.arange(0,Bayes_tile[1].header['NAXIS1'],dtype=np.int16)-Bayes_tile[1].header['CRPIX1']+hdulists[b][1].header['CRPIX1'],np.arange(0,Bayes_tile[1].header['NAXIS2'],dtype=np.int16)-Bayes_tile[1].header['CRPIX2']+hdulists[b][1].header['CRPIX2'])

			good=Bayes_tile[1].data>-6

			hdulists[b][1].data[y_ind[good].astype(np.int16),x_ind[good].astype(np.int16)]=Bayes_tile[1].data[good]
		


			Bayes_tile.close()
	except IOError:
		print('issue with tile '+str(tiles[i]))
		failed_tiles.append(tiles[i])
	
for i in range(0,len(priors)):
	hdulists[i].writeto(output_folder+'dmu26_XID+SPIRE_'+bands[i]+'_HDF-N_Bayes_Pval.fits',clobber=True)

outfile=output_folder+'failed_tiles.pkl'
with open(outfile, 'wb') as f:
   pickle.dump({'tiles':failed_tiles,'order':order},f)
