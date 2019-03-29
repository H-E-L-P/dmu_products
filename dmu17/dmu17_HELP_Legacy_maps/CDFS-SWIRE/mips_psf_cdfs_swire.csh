
curl --user help:hedam#$ http://hedam.lam.fr/HELP/data/P1/WP4/ELAIS-N1/wp4_elais-n1_mips24_map_v1.0.fits.gz > ! wp4_elais-n1_mips24_map_v1.0.fits.gz

stilts tapquery tapurl='https://herschel-vos.phys.sussex.ac.uk/__system__/tap/run/tap' adql="SELECT * FROM allwise.main WHERE field='CDFS-SWIRE'" maxrec=9999999 out=allwise_CDFS-SWIRE.fits

stilts tcat in=allwise_CDFS-SWIRE.fits \
icmd='select "chi2w4_pm<4"' \
out=stack_in.fits \
ocmd='colmeta -name ra raj2000' \
ocmd='colmeta -name dec dej2000' \
ocmd='keepcols "RA DEC w4mag"'

