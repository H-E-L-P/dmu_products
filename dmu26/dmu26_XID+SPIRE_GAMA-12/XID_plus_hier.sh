/bin/bash
#$ -S /bin/bash
#$ -o /lustre/scratch/astro/pdh21/log/out
#$ -e /lustre/scratch/astro/pdh21/log/err
cd /lustre/scratch/astro/pdh21/GAMA-12/SPIRE/output/
echo "this is from the run script"

module load use.own
module load fir/software
export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH

python -c 'from xidplus import HPC;HPC.hierarchical_tile("Master_prior.pkl", "Tiles.pkl")'
