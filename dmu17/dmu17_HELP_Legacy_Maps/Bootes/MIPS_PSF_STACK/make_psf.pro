
imfile='wp4_bootes_mips24_map_v1.0.fits.gz'
catfile='stack_in.fits'


     hermes_fix_astrom,  imfile, catfile , $
           'psf_hires', resamp=2,/mips,$
           stack_size=200, /zero2 , /nomod

 exit
