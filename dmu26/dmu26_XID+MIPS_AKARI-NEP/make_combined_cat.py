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
path='/home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_AKARI-NEP/data/'
os.chdir(path)

## run on every folder
folders = [f for f in glob.glob('**/', recursive=False)]




#os.system('module load stilts')

for name in folders:
    os.chdir(path+name)
    print('ls ./*cat.fits > cat_files')
    os.system('ls *cat.fits > cat_files')
    os.system('stilts tcat ifmt=fits in=@cat_files out=dmu26_XID+MIPS_AKARI_cat_'+name[:-1]+'.fits')