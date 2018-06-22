#!/bin/tcsh


set dmu_dir=/Users/sjo/GitHub/dmu_products/dmu17/dmu17_SEIP_maps/

foreach  field (AKARI-NEP AKARI-SEP Bootes CDFS-SWIRE COSMOS EGS ELAIS-N1 ELAIS-N2 ELAIS-S1 GAMA-09 GAMA-12 GAMA-15 HDF-N Herschel-Stripe-82 Lockman-SWIRE NGP SA13 SGP SPIRE-NEP SSDF XMM-13hr XMM-LSS xFLS) 


cd $dmu_dir/$field
source wget_$field.csh &

end
exit


