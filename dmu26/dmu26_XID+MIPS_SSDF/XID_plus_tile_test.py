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
path='/users/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SSDF/data/'
os.chdir(path)

data = pd.read_csv('tiles.csv', header=None)
task = []
task.append([f[0] for f in data.values[1:]])

## run on every folder
temp = np.sort([int(f[:-1]) for f in glob.glob('**/', recursive=False)])
folders = [str(f)+'/' for f in temp]

src='/users/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SSDF/test.sh'
for index, name in enumerate(folders):
        # change to new folder
        os.chdir(path+name)
        # copy file in new folder and modify it
        shutil.copy(src, './')
        s = open("./test.sh").read()
        s = s.replace('path_here', 'cd %s' % path+name)
        s = s.replace('array_here', '%s' % task[0][index])
        f = open("test.sh", 'w')
        f.write(s)
        f.close()
        # submit the array job
        print('submitting job test.sh')
        os.system('sbatch test.sh')
              
