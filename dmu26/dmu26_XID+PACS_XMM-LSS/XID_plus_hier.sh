/bin/bash
#$ -S /bin/bash
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err
cd /its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+PACS_XMM-LSS/data/
echo "this is from the run script"

. /etc/profile.d/modules.sh
module load use.own
module load fir/software
export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/"

python -c 'from xidplus import HPC;HPC.hierarchical_tile("Master_prior_SPUDS.pkl", "Tiles_SPUDS.pkl")'
