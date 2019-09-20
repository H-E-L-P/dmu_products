#! /bin/bash
#$ -S /bin/bash
#$ -o /users/mc741/git_hub/dmu_products/log/out
#$ -e /users/mc741/git_hub/dmu_products/log/err
cd /users/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_SSDF/
echo "this is from the run script"

python XID+MIPS_prior_mosaic.py