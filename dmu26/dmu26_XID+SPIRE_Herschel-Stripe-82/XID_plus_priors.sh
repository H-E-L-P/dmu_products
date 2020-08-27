#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err

cd /its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+SPIRE_Herschel-Stripe-82/
echo "this is from the run script"

export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/"

python XID+SPIRE_prior_cutout.py
