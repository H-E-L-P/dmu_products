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
path='/home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SPIRE-NEP/data/'
os.chdir(path)

## run on every folder
#folders = [f for f in glob.glob('**/', recursive=False)]

#folders.remove('prev/')
#folders.remove('Pval/')


# for cats files
folders = ['3','4','5','6','7','8','9','10']

for name in folders:
    os.chdir(path+name)
    os.system('scp -r mc741@slurm.ilifu.ac.za:/users/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SPIRE-NEP/data/'+name+'/*cat.fits /home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SPIRE-NEP/data/'+name+'/')