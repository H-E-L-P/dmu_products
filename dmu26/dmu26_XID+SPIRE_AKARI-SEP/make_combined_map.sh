#!/bin/bash

#SBATCH --job-name='joinMap_job'

echo "Submitting SLURM job"
singularity exec /idia/software/containers/SF-PY3-bionic.simg python make_combined_map.py
