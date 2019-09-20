#!/bin/bash

#SBATCH --job-name='joinMap_job'
#SBATCH --mem-per-cpu=100

ls ./*cat.fits > cat_files

srun singularity exec /idia/software/containers/SF-PY3-bionic.simg stilts tcat ifmt=fits in=@cat_files out=dmu26_XID+MIPS_SSDF_cat.fits
    
    
