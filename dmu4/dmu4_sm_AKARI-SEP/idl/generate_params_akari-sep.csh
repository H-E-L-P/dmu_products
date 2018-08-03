######################################################################
#
#
# this script should be runnable by just doing
#
#  source SebsScripts....
#
# However, some things are hardwired, I've grouped the hard-wiring to one 
# section of the code
#
#  Seb Oliver 29th April 2016
#  Redone 28th April 2017 to work with dmu xmm-lss master list and gaia catalogue
# updated 21-25 October 2017 to work with dmu1_ml_Lockman-SWIRE and made more general 
# and with better comments
#
# Raphael Shirley 26 March 2018
# Running code on GAMA-15
# 
######################################################################


######################################################################
#
# PREAMBLE
#
# load required modeules for apollo at Sussex
######################################################################
module load mps/software
module load idl
module load stilts



source ~/.login
source ~/.cshrc
which idl
stilts -version

######################################################################
# HARDWIRING SECTION
######################################################################

# this is the input master list

set field=akari-sep

set master=../../../dmu1/dmu1_ml_AKARI-SEP/data/master_catalogue_akari-sep_20180221.fits

# this bit is slow and requires internt connectivity so don't run if you've already generated the file
# i.e. while debugging.


# curl -u help:hedam http://hedam.lam.fr/HELP/dataproducts/dmu1/dmu1_ml_ELAIS-S1/data/master_catalogue_elais-s1_20171207.fits -o master_catalogue_elais-s1_20171207.fits


# this is the gaia catalogue retrieved from HeDAM when script run and thus name is arbitrary or
# extracted from the master list (also free choice of name)

set star=../../../dmu0/dmu0_GAIA/data/GAIA_AKARI-SEP.fits
set master_star=master_gaia.fits



######################################################################
# extracting gaia catalogue from this field (field "hardwired")
# stilts tapquery tapurl='https://herschel-vos.phys.sussex.ac.uk/__system__/tap/run/tap' adql="SELECT * FROM gaia.main WHERE field='ELAIS-S1'" maxrec=9999999 out=$star


######################################################################

# extracting meta information from master list into a text file (not required for any other parts of the script
stilts tcat in=$master omode=meta > ! meta.txt
# and looking for the apperture mag labels
grep m_ap meta.txt >! meta_ap.txt

# from examining this file we can decide what are the relevant columns
set columns="irac_i1"


######################################################################
# END OF HARDWIRED SECTION
######################################################################



######################################################################
# BEGINING OF GENERAL SECTION
######################################################################

# generating text file of column names for IDL code
rm columns.txt
foreach code ($columns) 
echo $code >>! columns.txt
end

#echo multi  >>! columns.txt

#goto wrapup

######################################################################
# constructing a "gaia" catalogue from the master list, i.e. all objects
# in the master list that have been flaged as detected by Gaia

stilts tcat in=$master icmd='select "flag_gaia!=0"' out=$master_star



#  
######################################################################

#Cross-matching the real gaia catalogue with the gaia master list (pretty silly as
#this could have been done by the master list generation but heh...

stilts -Xmx2048M -disk tmatch2 in1=$star in2=$master_star \
 out='./gaia_x_gaia_master.fits' \
 matcher=sky params=2 values1='ra dec' values2='ra dec' join=all1 find=best 

#####################################################################


# This strips down the masked catalogue and keeps only the relevant columns and creates a new single band detection column

#stilts tcat in=$master  \
# out=multi.fits \
#    ocmd='colmeta -name irac1mag m_ap_irac1' \
#    ocmd='keepcols "RA DEC irac1mag"'

######################################################################

# basic input files are rband.fits (the master list limited to x-band detections)
# and the gaia-dr1-xmm_lss.fits (gaia catalogue, restricted to xmm-lss field)

# This strips down the masked catalogue to just the band detections and keeps only the relevant columns

foreach code ($columns)

echo select \"\!NULL_m_ap_$code\" >! select.cmd
echo keepcols \"RA DEC m_ap_$code\" >! keepcols.cmd

stilts tcat in=$master  \
 out=$code.fits \
    icmd=@select.cmd \
    ocmd=@keepcols.cmd

end

######################################################################
# cross-correlating with master list with gaia catalogue using 
# various radii to avoid creating huge files
# adding in the deltra ra, delta dec and theta offsets as well as the separation
######################################################################


foreach code ($columns)

set master=$code.fits


######################################################################


######################################################################

# bit inelleigent but the files are too big to do the cross-matching all in one go, so sub-divided in magnitude bins, could probably do this as a loop but then you end up in the hell of scripting character escapes

######################################################################
# R-band version
######################################################################

stilts -Xmx2048M -disk tmatch2 in1=$star in2=$master \
icmd1='select "phot_g_mean_mag<9"' \
out='./gaia_x_'$code'_480_0009.fits' \
matcher=sky params=480 values1='ra dec' values2='ra dec' join=all1 find=all 

stilts -Xmx2048M -disk tmatch2 in1=$star in2=$master \
icmd1='select "phot_g_mean_mag>=9"; select "phot_g_mean_mag<12"' \
out='./gaia_x_'$code'_120_0912.fits' \
matcher=sky params=120 values1='ra dec' values2='ra dec' join=all1 find=all 

stilts -Xmx2048M -disk tmatch2 in1=$star in2=$master \
icmd1='select "phot_g_mean_mag>=12"; select "phot_g_mean_mag<15"' \
out='./gaia_x_'$code'_060_1215.fits' \
matcher=sky params=60 values1='ra dec' values2='ra dec' join=all1 find=all 

stilts -Xmx2048M -disk tmatch2 in1=$star in2=$master \
icmd1='select "phot_g_mean_mag>=15"; select "phot_g_mean_mag<19"' \
out='./gaia_x_'$code'_060_1519.fits' \
matcher=sky params=60 values1='ra dec' values2='ra dec' join=all1 find=all 

end

######################################################################
# Merge these together into one file
######################################################################
wrapup:

foreach code ($columns)

stilts tcatn nin=4 \
in1='gaia_x_'$code'_480_0009.fits' \
in2='gaia_x_'$code'_120_0912.fits' \
in3='gaia_x_'$code'_060_1215.fits' \
in4='gaia_x_'$code'_060_1519.fits' \
out='gaia_x_'$code'.fits' 

end


######################################################################
# filtering out the possible failures and adding in the extra columns we need for IDL code
######################################################################

foreach code ($columns)

stilts tcat in='gaia_x_'$code'.fits'  \
icmd='select \!NULL_separation' \
ocmd='addcol dra   (RA_1-RA_2)*cosDeg(Dec_1)*3600.' \
ocmd='addcol ddec   (DEC_1-DEC_2)*3600.' \
ocmd='addcol theta atan2Deg(dra,ddec)' \
out='gaia_x_'$code'.fits' 
end

######################################################################
# I actually then run an IDL code RadialDepence.pro to analyse the correlation functions
# and suitable cut-off and then model that  
######################################################################


idl do_radial_dependence.pro


