import sys
import os
import numpy as np


# read in csv file to check how many files there are
path='/home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_Herschel-Stripe-82/data/'
os.chdir(path)

## run on every folder
for name in range(466):
    print('loop in folder: '+str(name))
    try:
        print('creating folder: '+str(name))
        os.mkdir(str(name)+'/')
        print('downloading folder: '+str(name))
        os.system('scp -r mc741@slurm.ilifu.ac.za:/users/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_Herschel-Stripe-82/data/'+str(name)+'/*cat.fits /home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_Herschel-Stripe-82/data/'+str(name)+'/')    
    
    except:
        print('It failed in folder: '+str(name))