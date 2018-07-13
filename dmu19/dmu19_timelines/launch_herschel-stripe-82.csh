#!/bin/bash
#$ -S /bin/bash
#$ -q serial.q
#$ -e /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/logs/
#$ -o /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/logs/
#$ -m eas
#$ -l m_mem_free=128G 
#$ -M sjo@sussex.ac.uk


#-bash-4.1$ module load sge 
#-bash-4.1$ qsub -q mps.q /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/launch_xmm13hr.csh


source /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/smap_herschel-stripe-82.csh

