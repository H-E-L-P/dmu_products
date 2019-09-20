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
path='/home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_AKARI-NEP/data/changed_psf/'
os.chdir(path)

## run on every folder
folders = [f for f in glob.glob('**/', recursive=False)]

folders.remove('output/')

for name in folders:
    os.chdir(path+name)
    os.system('scp -r mc741@apollo2.hpc.susx.ac.uk:/its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_AKARI-NEP/data/changed_psf/'+name+'/dmu26_XID+MIPS_AKARI-NEP_Bayes_Pval.fits /home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_AKARI-NEP/data/changed_psf/output/Pval/dmu26_XID+MIPS_AKARI-NEP_Bayes_Pval'+name[:-1]+'.fits')