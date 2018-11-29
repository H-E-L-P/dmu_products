/bin/bash
#$ -S /bin/bash
#$ -o /lustre/scratch/astro/mc741/log/out
#$ -e /lustre/scratch/astro/mc741/log/err
cd /lustre/scratch/astro/mc741/dmu_products/dmu26/dmu26_XID+SPIRE_ELAIS-N2/data/
echo "this is from the run script"

module load use.own
module load fir/software
export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH

python -c 'from xidplus import HPC;HPC.hierarchical_tile("Master_prior_SWIRE.pkl", "Tiles_SWIRE.pkl")'
