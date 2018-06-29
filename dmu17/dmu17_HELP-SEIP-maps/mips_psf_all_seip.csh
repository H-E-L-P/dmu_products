#!/bin/tcsh


# script written for PSF stacking by Seb Oliver original July 2017, last updated 20th June 2018

# This script requires
#      - a folder containing the HELP DMU 17 HELP SEIP maps.
#      - a folder containing the HELP DMU 16 allwise
#      - the MIPS_PSF_Stack git repository https://github.com/H-E-L-P/MIPS_PSF_STACK
#      - an IDL installation and license
#
# Key folder locations

set GIT_DIR=~/GitHub/MIPS_PSF_STACK/
set SEIP_DIR=~/GitHub/dmu_products/dmu17/dmu17_HELP_SEIP_maps/
set WISE_DIR=~/GitHub/dmu_products/dmu16/dmu16_allwise/data/

# preamble to get environment right

# IDL environment
source  $GIT_DIR/HermesAstroSetup.csh


foreach field (AKARI-NEP AKARI-SEP Bootes CDFS-SWIRE COSMOS EGS ELAIS-N1 ELAIS-N2 ELAIS-S1 GAMA-09 GAMA-12 GAMA-15 HDF-N Herschel-Stripe-82 Lockman-SWIRE NGP SA13 SGP SPIRE-NEP SSDF XMM-13hr XMM-LSS xFLS)


    cd $SEIP_DIR/$field/data/ 


     set wise=$WISE_DIR/Allwise_PSF_stack_GAIA_$field.fits
     echo $wise

      

# running the stacking code


    foreach i (*.help.fits)
	echo Processing $i ....
	idl  $GIT_DIR/batch_psf.pro  -args $i $wise
    end

# moving files to their final destinations


mkdir output_data
mv psf*.ps output_data
mv psf*.txt output_data
mv psf*.astrom output_data
mv psf*.fits output_data

end
