#! /bin/bash
#$ -S /bin/bash
#$ -o /mnt/lustre/users/astro/pdh21/log/out
#$ -e /mnt/lustre/users/astro/pdh21/log/err

cd /mnt/lustre/users/astro/pdh21/HELP_DR2/COSMOS/SPIRE/
echo "this is from the run script"

export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH
source activate herschelhelp
module load gcc

python XIDp_run_script_spire_tile.py
