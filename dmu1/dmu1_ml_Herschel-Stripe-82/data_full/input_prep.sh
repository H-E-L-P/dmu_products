# Prepare input file for LF or clustering analysis
stilts="java -jar /Users/loveday/sw/topcat/topcat-full.jar -stilts"
. $HEADAS/headas-init.sh

zref=00
magtype=auto
kcorr_file='kcorr_dmu/v5/kcorr_'$magtype'_z'$zref'_vecv05.fits'
out_file='kcorr_'$magtype'_z'$zref'.fits'
$stilts tmatchn nin=3 in1=TilingCatv46.fits in2=$kcorr_file in3=StellarMassesv18.fits out=$out_file ofmt=fits-basic matcher=exact values1="CATAID" values2="CATAID" values3="CATAID" suffix1='' icmd3='keepcols "CATAID fluxscale logmstar zmax_19p8"' ocmd='delcols "*_2 *_3"'
python misc.add_colour($out_file, $out_file)
cphead $kcorr_file'+1' $out_file'+1'

# Add kcorrect info to stellar masses for k-correction comparison
# stilts tmatch2 in1=StellarMassesv15.fits in2=kcorrect/kcorr_z00_vecv03.fits out=StellarMassesv15kc00.fits ofmt=fits-basic matcher=exact values1="CATAID" values2="CATAID" join=all1 suffix1='' ocmd='delcols "*_2"'

# Add BPT/line lum info created with misc.bpt_gama
zref=01
out_file='kcorr_'$magtype'_z'$zref'.fits'
stilts tmatch2 in1=$out_file in2=SpecLineSFR/line_lums.fits out=temp.fits ofmt=fits-basic matcher=exact values1="CATAID" values2="CATAID_2" join=all1 suffix1='' icmd2='keepcols "CATAID_2 bpt_type ha_lum oiii_lum sfr"' ocmd='delcols "*_2"'
cphead $out_file'+1' temp.fits
mv temp.fits $out_file
