import sys
import os
import glob
import numpy as np
import csv
import pandas as pd
import shutil
import subprocess as sp
import string
import subprocess

# read in csv file to check how many files there are
path='/its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+SPIRE_Herschel-Stripe-82/data/prior_f5/'
os.chdir(path)


## run on every folder
temp = np.sort([int(f[:-1]) for f in glob.glob('**/', recursive=False)])
folders = [str(f)+'/' for f in temp]



for name in folders:
    os.chdir(path+name)
    print('python ../../../make_combined_map.py')
    os.system('python ../../../make_combined_map.py')
    #print ('ls ./*cat.fits > cat_files')
    #os.system('ls ./*cat.fits > cat_files')
    #print('stilts tcat ifmt=fits in=@cat_files out=dmu26_XID+SPIRE_HS82_%s_cat.fits' % name[:-1])
    #os.system('stilts tcat ifmt=fits in=@cat_files out=dmu26_XID+SPIRE_HS82S_%s_cat.fits' % name[:-1])

