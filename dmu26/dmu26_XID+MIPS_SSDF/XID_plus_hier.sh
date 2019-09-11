/bin/bash
#$ -S /bin/bash
#$ -o /users/mc741/git_hub/dmu_products/log/out
#$ -e /users/mc741/git_hub/dmu_products/log/err
cd /users/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SSDF/data/
echo "this is from the run script"


echo $(pwd)
path_here
echo $(pwd)


python -c 'from xidplus import HPC;import sys;HPC.hierarchical_tile("Master_prior.pkl", "Tiles.pkl")'
