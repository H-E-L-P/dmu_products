#! /bin/bash
#$ -S /bin/bash
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err
cd /its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+SPIRE_HDF-N/

echo "this is from the run script"
. /etc/profile.d/modules.sh

module load gcc

export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH
source activate herschelhelp

python XIDp_run_script_spire_tile.py
