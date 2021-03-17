# #! /bin/bash
# #$ -S /bin/bash
# #$ -o /lustre/scratch/astro/pdh21/log/out
# #$ -e /lustre/scratch/astro/pdh21/log/err
# cd /lustre/scratch/astro/pdh21/CDFS-SWIRE/MIPS/
# echo "this is from the run script"

# module load use.own
# module load fir/software
# export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH

# python XIDp_run_script_mips_tile.py


### New masterlist
#! /bin/bash
#$ -S /bin/bash
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err
cd /its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_CDFS-SWIRE/
echo "this is from the run script"

module load use.own
module load fir/software
export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH

python XIDp_run_script_mips_tile.py
