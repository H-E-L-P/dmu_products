#!/bin/bash

echo ------------------------
echo Begining script
echo ------------------------
cd /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/
module load mps
echo about to launch startup script
source /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/HELP_apollo_spire_smap_setup.csh
echo did it work?
pwd
cd createmap
pwd
echo creating idl script
echo 'create_itermap_from_conf, "conffiles/xmm13hr.conf"' > tmp_idl.pro

echo 'exit' >> tmp_idl.pro
echo which idl?
which idl
/mnt/pactsw/itt/idl80/bin/idl  tmp_idl.pro
pwd
cd ..
pwd
echo ------------------------
echo Ending script
echo ------------------------
