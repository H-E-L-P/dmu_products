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
    taskid = np.int(os.environ['SLURM_ARRAY_TASK_ID'])
    #task_first=np.int(os.environ['SGE_TASK_FIRST'])
    #task_last=np.int(os.environ['SGE_TASK_LAST'])

except KeyError:
    print("Error: could not read SLURM_ARRAY_TASK_ID from environment")
    taskid = int(input("Please enter task id: "))
    print("you entered", taskid)


output_folder='./'


#First run: Tiles.pkl
#####################
outfile=output_folder+'Tiles.pkl'
with open(outfile, 'rb') as f:
   obj=pickle.load(f)

#Second run: failed_tiles.pkl
#############################
#outfile=output_folder+'failed_tiles.pkl'
#with open(outfile, 'rb') as f:
#   obj=pickle.load(f)


tiles=obj['tiles']
order=obj['order']
order_large=obj['order_large']

tile_large=moc_routines.tile_in_tile(order,tiles[taskid-1],order_large)
outfile=output_folder+'Tile_'+str(tile_large)+'_'+str(order_large)+'.pkl'
with open(outfile, 'rb') as f:
    obj=pickle.load(f)
priors=obj['priors']
moc=moc_routines.get_fitting_region(order,tiles[taskid-1])
priors[0].moc=moc
priors[0].cut_down_prior()

print('taskid '+ str(taskid)+' \n')
dirpath = os.getcwd()
print("current directory is : " + dirpath)

print('fitting '+ str(priors[0].nsrc)+' sources \n')
print('there are '+ str(priors[0].snpix)+' pixels')
print('fitting tile:'+str(tiles[taskid-1])+' order: '+str(order)+' of '+str(len(tiles))+' tiles')


from xidplus.stan_fit import MIPS
