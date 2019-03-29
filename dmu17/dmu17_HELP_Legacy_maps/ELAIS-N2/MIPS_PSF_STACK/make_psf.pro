
imfile='swire_EN2_M1_v4_help.fits'
catfile='stack_in.fits'


     hermes_fix_astrom,  imfile, catfile , $
           'psf_hires', resamp=2,/mips,$
           stack_size=200, /zero2 , /nomod

 exit
