#! /bin/bash
#$ -S /bin/bash
#$ -o /lustre/scratch/astro/pdh21/log/out
#$ -e /lustre/scratch/astro/pdh21/log/err
cd /lustre/scratch/astro/pdh21/Lockman-SWIRE/SPIRE/
echo "this is from the run script"

source /etc/profile.d/modules.sh

module load easybuild/software
module load Singularity/2.4-GCC-6.3.0-2.27

singularity shell -B ./:/scratch/ xidplus.simg -c "cd /scratch; python XIDp_run_script_spire_tile.py"
