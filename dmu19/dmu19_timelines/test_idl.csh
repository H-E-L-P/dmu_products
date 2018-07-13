#!/bin/bash
#$ -S /bin/bash
#$ -q serial.q
#S -e /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/logs/
#$ -o /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/logs/
#$ -m eas
#$ -l m_mem_free=128G
#$ -M sjo@sussex.ac.uk


source /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/smap_herschel-stripe-82_test.csh
sleep 50
