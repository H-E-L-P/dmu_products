# script written for PSF stacking by Seb Oliver original July 2017, last updated August 2017

# preamble to get environment right

#source ~/.login
#source ~/.cshrc
export IDL_PATH=$IDL_PATH:+'./code/'

# getting the map from HEDAM
#which curl
curl --user help\:hedam\#\$  "http://hedam.lam.fr/HELP/data/P1/WP4/XMM-LSS/wp4_xmm-lss_mips24_map_v1.0.fits.gz" -o wp4_xmm-lss_mips24_map_v1.0.fits.gz

# getting the WISE reference catalogue from HEDAM
module load stilts/3.1
stilts tapquery tapurl='http://vohedamtest.lam.fr/__system__/tap/run/tap' adql="SELECT * FROM allwise.main WHERE field='XMM-LSS'" maxrec=9999999 out=allwise_XMM-LSS.fits

# filtering the WISE catalogue

stilts tcat in=allwise_XMM-LSS.fits \
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

mv allwise*.fits input_data
mv stack_in.fits input_data
mv wp4*.fits.gz input_data

mv psf*.ps output_data
mv psf*.txt output_data
mv psf*.astrom output_data
mv psf*.fits output_data
