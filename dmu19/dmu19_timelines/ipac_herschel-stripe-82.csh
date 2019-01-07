#!/bin/bash

echo ------------------------
echo Begining script
echo ------------------------

export HOME=/data/scat/
cd .

echo about to launch startup script
source ./HELP_ipac_spire_smap_setup.csh

pwd
cd createmap
pwd
echo creating idl script
echo 'create_itermap_from_conf, "conffiles/helms-hers.conf"' > tmp_idl.pro

echo 'exit' >> tmp_idl.pro
echo which idl?
which idl
idl  tmp_idl.pro
pwd
cd ..
pwd
echo ------------------------
echo Ending script
echo ------------------------
