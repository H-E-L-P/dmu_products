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
#path='/home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SPIRE-NEP/data/'
path='./data/'

os.chdir(path)

data = pd.read_csv('large_tiles.csv', header=None)
task = []
task.append([f[0] for f in data.values[1:]])

## run on every folder
folders = [f for f in glob.glob('**/', recursive=False)]


#src='/home/mc741/Documents/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SPIRE-NEP/XID_plus_hier.sh'
src='./XID_plus_hier.sh'

for index, name in enumerate(folders):
        os.chdir(path+name)
        shutil.copy(src, './')
        s = open("./XID_plus_hier.sh").read()
        s = s.replace('path_here', 'cd %s' % path+name)
        f = open("XID_plus_hier.sh", 'w')
        f.write(s)
        f.close()
        print('qsub -t 1-%s XID_plus_hier.sh' % task[0][index])
        os.system('qsub -t 1-%s XID_plus_hier.sh' % task[0][index])
        
        
        
