/bin/bash
#$ -S /bin/bash
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err
cd /its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+PACS_EGS/data/
echo "this is from the run script"

module load use.own
module load fir/software
export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/"

python -c 'from xidplus import HPC;import sys; sys.path.remove("/mnt/pact/im281/HELP/XID_plus");sys.path.remove("/mnt/pact/im281/HELP/herschelhelp_python");HPC.hierarchical_tile("Master_prior.pkl", "Tiles.pkl")'
