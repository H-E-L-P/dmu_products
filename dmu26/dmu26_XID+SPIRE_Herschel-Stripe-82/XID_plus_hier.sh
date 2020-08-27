#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err
echo "this is from the run script"

export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/"

echo $(pwd)
path_here
echo $(pwd)


python -c 'from xidplus import HPC;import sys; sys.path.remove("/mnt/pact/im281/HELP/XID_plus");sys.path.remove("/mnt/pact/im281/HELP/herschelhelp_python");HPC.hierarchical_tile("Master_prior.pkl", "Tiles.pkl")'

