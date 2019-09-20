import sys
import os
import glob
import numpy as np
import csv
import pandas as pd
import shutil
import subprocess as sp
import string


# read in csv file to check how many files there are
path='/its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_AKARI-NEP/data/changed_psf/'
os.chdir(path)

data = pd.read_csv('tiles.csv', header=None)
task = []
task.append([f[0] for f in data.values[1:]])

## run on every folder
folders = [f for f in glob.glob('**/', recursive=False)]


src='/its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_AKARI-NEP/XID_plus_tile.sh'
for index, name in enumerate(folders):
        os.chdir(path+name)
        shutil.copy(src, './')
        s = open("./XID_plus_tile.sh").read()
        s = s.replace('path_here', 'cd %s' % path+name)
        f = open("XID_plus_tile.sh", 'w')
        f.write(s)
        f.close()
        print('qsub -t 1-%s -pe openmp 4 -l h_rt=12:00:00 -l m_mem_free=10G -q mps.q XID_plus_tile.sh' % task[0][index])
        os.system('qsub -t 1-%s -pe openmp 4 -l h_rt=12:00:00 -l m_mem_free=10G -q mps.q XID_plus_tile.sh' % task[0][index])
        
        
        