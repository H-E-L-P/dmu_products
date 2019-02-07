imfile='ELAIS-N2-100um-img_wgls.fits'
err_file='ELAIS-N2-100um-img_noise.fits'
catfile='stack_in.fits'

    hermes_fix_astrom,  imfile, catfile ,err_file=err_file, $
          'psf_hires', resamp=3,/unim,$
          stack_size=200, /zero2 , /nomod

exit

;;     hermes_fix_astrom,  imfile, catfile , $
;;           'psf_hires', resamp=2,/mips,$
;;           stack_size=200, /zero2 , /nomod

;; exit

