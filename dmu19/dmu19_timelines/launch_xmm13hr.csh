#!/bin/bash
#$ -S /bin/bash
#$ -q trail.q
#S -e /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/
#$ -o /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/
#$ -m eas
#$ -M sjo@sussex.ac.uk

echo testing1
#-bash-4.1$ module load sge 
#-bash-4.1$ qsub -q mps.q /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/launch_xmm13hr.csh

echo testing2

source /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/test_xmm13hr.csh

echo testing3
/research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/test_xmm13hr.csh
echo testing4
