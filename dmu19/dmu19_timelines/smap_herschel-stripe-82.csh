#!/bin/bash

echo ------------------------
echo Begining script
echo ------------------------

cd /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/

source /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/HELP_apollo_spire_smap_setup.csh

cd createmap

echo 'create_itermap_from_conf, "conffiles/helms-hers.conf"' > tmp_idl.pro

echo 'exit' >> tmp_idl.pro
/mnt/pactsw/itt/idl80/bin/idl  tmp_idl.pro &> ../logs/smap_herschel-stripe-82.idl_log

echo ------------------------
echo Ending script
echo ------------------------
