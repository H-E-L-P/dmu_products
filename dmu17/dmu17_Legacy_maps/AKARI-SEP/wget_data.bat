#!/bin/sh
#
# To run as an executable on a unix platform, do the following:
# chmod 775 wget_data.bat
# ./wget_data.bat
#
wget -x "https://irsa.ipac.caltech.edu//data/SPITZER/SEP/images/SEP_MIPS24_mosaic_cov_v1.fits"
wget -x "https://irsa.ipac.caltech.edu//data/SPITZER/SEP/images/SEP_MIPS24_mosaic_map_v1.fits"
wget -x "https://irsa.ipac.caltech.edu//data/SPITZER/SEP/images/SEP_MIPS24_mosaic_unc_v1.fits"