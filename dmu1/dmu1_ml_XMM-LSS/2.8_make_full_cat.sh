######################################################################
# -- The shell used to interpret this script
#$ -S /bin/bash
# -- Execute this job from the current working directory.
#$ -cwd
# -- Job output to stderr will be merged into standard out. Remove this line if
# -- you want to have separate stderr and stdout log files
#$ -j y
# #$ -o output/
# -- Send email when the job exits, is aborted or suspended
#$ -m eas
#$ -M raphael.shirley@sussex.ac.uk

ls ./data/tiles/sub_catalogue_xmm-lss_20190328*.fits > ./data/tiles/fits_list_20190328.lis

stilts tcat in=@./data/tiles/fits_list_20190328.lis out=./data/master_catalogue_xmm-lss_20190328.fits

