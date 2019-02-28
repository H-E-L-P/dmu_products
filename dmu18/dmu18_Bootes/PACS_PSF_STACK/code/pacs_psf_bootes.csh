# script written for PSF stacking by Seb Oliver original July 2017, last updated August 2017

# preamble to get environment right

#source ~/.login
#source ~/.cshrc
$ stevenv IDL_PATH '.'


# getting the WISE reference catalogue from HEDAM
module load mps/software
module load idl
module load stilts


# filtering the WISE catalogue

stilts tcat in=ALLWISE_20190116_Bootes.fits \
icmd='select "chi2w4_pm<4"' \
out=stack_in.fits \
ocmd='colmeta -name ra raj2000' \
ocmd='colmeta -name dec dej2000' \
ocmd='keepcols "RA DEC w4mag"'


# running the stacking code

idl  < make_psf.pro

# moving files to their final destinations

mkdir input_data
mkdir output_data

mv AllWISE*.fits input_data
mv stack_in.fits input_data
mv *help.fits input_data

mv psf*.ps output_data
mv psf*.txt output_data
mv psf*.astrom output_data
mv psf*.fits output_data
