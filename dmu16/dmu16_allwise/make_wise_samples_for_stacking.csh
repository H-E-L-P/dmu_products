########################################################################
# Code for selecting a sub-set of the all wise catalogue for use in
# PSF stacking.  Reduces the file to the set of objects in a single
# HELP field satisfying a Chi^2 criterion on band 4.  Saving just the
# RA, DEC and w4mag columns
#
# Originally writtin at Bootcamp March 2018 by Seb Oliver
# Modified to work in situe with relative paths following dmu product
# conventions 17 June 2018 (but not tested!)
# 
########################################################################

#set field=AKARI-NEP

foreach field (AKARI-NEP ELAIS-S1 SA13 AKARI-SEP GAMA-09 SGP Bootes GAMA-12 SPIRE-NEP CDFS-SWIRE GAMA-15 SSDF COSMOS HDF-N XMM-13hr EGS Herschel-Stripe-82 XMM-LSS ELAIS-N1 Lockman-SWIRE xFLS ELAIS-N2 NGP)

#cd /Volumes/Seagate\ Backup\ Plus\ Drive/HELP/AllWISE
#
cd ../dmu16a_allwise/data


echo  select field==\\\"$field\\\" >! cmds.txt
echo 'select "chi2w4_pm<4"' >> cmds.txt


stilts tcat in="AllWISE_20160512.fits.gz" \
icmd=@cmds.txt \
out="Allwise_PSF_stack_"$field.fits \
ocmd='colmeta -name ra raj2000' \
ocmd='colmeta -name dec dej2000' \
ocmd='keepcols "RA DEC w4mag"'

end
