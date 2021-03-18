# /bin/bash
# #$ -S /bin/bash
# #$ -o /lustre/scratch/astro/pdh21/log/out
# #$ -e /lustre/scratch/astro/pdh21/log/err
# cd /lustre/scratch/astro/pdh21/CDFS-SWIRE/PACS/output/
# echo "this is from the run script"

# module load use.own
# module load fir/software
# export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/"

# python -c 'from xidplus import HPC;HPC.hierarchical_tile("Master_prior.pkl", "Tiles.pkl")'

## New Masterlist

/bin/bash
#$ -S /bin/bash
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err
cd /its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+PACS_CDFS-SWIRE/data/

echo "this is from the run script"
. /etc/profile.d/modules.sh

module load gcc

export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH
source activate herschelhelp

python -c 'from xidplus import HPC;HPC.hierarchical_tile("Master_prior.pkl", "Tiles.pkl")'
