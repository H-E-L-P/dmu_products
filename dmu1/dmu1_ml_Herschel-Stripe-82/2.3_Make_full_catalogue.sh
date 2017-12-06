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

ls ./data/sub_catalogue_herschel-stripe-82_20171206_*.fits > fits_list.lis

stilts tcat in=@fits_list.lis out=./data/master_catalogue_herschel-stripe-82_20171206.fits
