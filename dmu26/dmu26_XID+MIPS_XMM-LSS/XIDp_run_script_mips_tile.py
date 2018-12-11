import numpy as np
from astropy.io import fits
from astropy import wcs
import pickle
import dill
import sys
import os
import xidplus
import copy
from xidplus import moc_routines, catalogue
from xidplus import posterior_maps as postmaps
from builtins import input


try:
    taskid = np.int(os.environ['SGE_TASK_ID'])
    task_first=np.int(os.environ['SGE_TASK_FIRST'])
    task_last=np.int(os.environ['SGE_TASK_LAST'])

except KeyError:
    print("Error: could not read SGE_TASK_ID from environment")
    taskid = int(input("Please enter task id: "))
    print("you entered", taskid)


output_folder='./data/'
outfile=output_folder+'failed_tiles_SPUDS.pkl'
with open(outfile, 'rb') as f:
   obj=pickle.load(f)


tiles=obj['tiles']
order=obj['order']
order_large=7#obj['order_large']

tile_large=moc_routines.tile_in_tile(order,tiles[taskid-1],order_large)
outfile=output_folder+'Tile_'+str(tile_large)+'_'+str(order_large)+'.pkl'
with open(outfile, 'rb') as f:
    obj=pickle.load(f)
priors=obj['priors']
moc=moc_routines.get_fitting_region(order,tiles[taskid-1])
priors[0].moc=moc
priors[0].cut_down_prior()
print('fitting '+ str(priors[0].nsrc)+' sources \n')
print('there are '+ str(priors[0].snpix)+' pixels')
print('fitting tile:'+str(tiles[taskid-1])+' order: '+str(order)+' of '+str(len(tiles))+' tiles')


from xidplus.stan_fit import MIPS
priors[0].prior_bkg(0.0,1)
priors[0].get_pointing_matrix()
#priors[0].upper_lim_map()

#priors[0].prior_flux_upper=(priors[0].prior_flux_upper-10.0+0.02)/np.max(priors[0].prf)

fit=MIPS.MIPS_24(priors[0],iter=1000)

posterior=xidplus.posterior_stan(fit,priors)

outfile=output_folder+'Tile_'+str(tiles[taskid-1])+'_'+str(order)

posterior=xidplus.posterior_stan(fit,priors)
xidplus.save(priors,posterior,outfile)
      
post_rep_map=postmaps.replicated_maps(priors,posterior,nrep=2000)
Bayes_P24=postmaps.Bayes_Pval_res(priors[0],post_rep_map[0])
cat=catalogue.create_MIPS_cat(posterior, priors[0], Bayes_P24)
kept_sources=moc_routines.sources_in_tile([tiles[taskid-1]],order,priors[0].sra,priors[0].sdec)
kept_sources=np.array(kept_sources)
cat[1].data=cat[1].data[kept_sources]
outfile=output_folder+'Tile_'+str(tiles[taskid-1])+'_'+str(order)

cat.writeto(outfile+'_MIPS24_cat.fits',overwrite=True)

Bayesian_Pval=postmaps.make_Bayesian_pval_maps(priors[0],post_rep_map[0])
wcs_temp=wcs.WCS(priors[0].imhdu)
ra,dec=wcs_temp.wcs_pix2world(priors[0].sx_pix,priors[0].sy_pix,0)
kept_pixels=np.array(moc_routines.sources_in_tile([tiles[taskid-1]],order,ra,dec))
Bayesian_Pval[np.invert(kept_pixels)]=np.nan

Bayes_24_map=postmaps.make_fits_image(priors[0],Bayesian_Pval)
Bayes_24_map.writeto(outfile+'_MIPS_24_Bayes_Pval.fits',overwrite=True)
