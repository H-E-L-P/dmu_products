#! /bin/bash
#$ -S /bin/bash
#$ -o /lustre/scratch/astro/pdh21/log/out
#$ -e /lustre/scratch/astro/pdh21/log/err
cd /lustre/scratch/astro/pdh21/Lockman-SWIRE/MIPS/
echo "this is from the run script"

module load use.own
module load fir/software
export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH

python XIDp_run_script_mips_tile.py
