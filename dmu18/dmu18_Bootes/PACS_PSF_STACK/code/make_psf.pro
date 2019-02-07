imfile='Bootes_PACS100_v0.9.fits'
catfile='stack_in.fits'

    hermes_fix_astrom,  imfile, catfile , $
          'psf_native', resamp=3,/pacs,$
          stack_size=200, /zero2 , /nomod

exit

;;     hermes_fix_astrom,  imfile, catfile , $
;;           'psf_hires', resamp=2,/mips,$
;;           stack_size=200, /zero2 , /nomod

;; exit

