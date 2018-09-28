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


output_folder='./output/'
outfile=output_folder+'failed_tiles.pkl'
with open(outfile, 'rb') as f:
   obj=pickle.load(f)


tiles=obj['tiles']
order=obj['order']
order_large=6#obj['order_large']

tile_large=moc_routines.tile_in_tile(order,tiles[taskid-1],order_large)
outfile=output_folder+'Tile_'+str(tile_large)+'_'+str(order_large)+'.pkl'
with open(outfile, 'rb') as f:
    obj=pickle.load(f)
priors=obj['priors']
moc=moc_routines.get_fitting_region(order,tiles[taskid-1])

for p in priors:
    p.moc=moc
    p.cut_down_prior()
    p.prior_bkg(0.0,5)
    p.get_pointing_matrix()
    p.upper_lim_map()

print('fitting '+ str(priors[0].nsrc)+' sources \n')
print('there are '+ str(priors[0].snpix)+' pixels')
print('fitting tile:'+str(tiles[taskid-1])+' order: '+str(order)+' of '+str(len(tiles))+' tiles')


from xidplus.stan_fit import SPIRE

fit=SPIRE.all_bands(priors[0],priors[1],priors[2],iter=1000)

posterior=xidplus.posterior_stan(fit,priors)

outfile=output_folder+'Tile_'+str(tiles[taskid-1])+'_'+str(order)

posterior=xidplus.posterior_stan(fit,priors)
xidplus.save(priors,posterior,outfile)
      
post_rep_map=postmaps.replicated_maps(priors,posterior,nrep=2000)
band=['psw','pmw','plw']
for i,p in enumerate(priors):
    Bayesian_Pval=postmaps.make_Bayesian_pval_maps(priors[i],post_rep_map[i])
    wcs_temp=wcs.WCS(priors[i].imhdu)
    ra,dec=wcs_temp.wcs_pix2world(priors[i].sx_pix,priors[i].sy_pix,0)
    kept_pixels=np.array(moc_routines.sources_in_tile([tiles[taskid-1]],order,ra,dec))
    Bayesian_Pval[np.invert(kept_pixels)]=np.nan
    Bayes_map=postmaps.make_fits_image(priors[i],Bayesian_Pval)
    Bayes_map.writeto(outfile+'_'+band[i]+'_Bayes_Pval.fits',overwrite=True)

cat=catalogue.create_SPIRE_cat(posterior, priors[0],priors[1],priors[2])
kept_sources=moc_routines.sources_in_tile([tiles[taskid-1]],order,priors[0].sra,priors[0].sdec)
kept_sources=np.array(kept_sources)
cat[1].data=cat[1].data[kept_sources]
outfile=output_folder+'Tile_'+str(tiles[taskid-1])+'_'+str(order)

cat.writeto(outfile+'_SPIRE_cat.fits',overwrite=True)

