PRO hermes_fix_astrom, im_file, cat_file, file_out, resamp=resamp, stack_size=stack_size, reset=reset, pacs=pacs, cov_file=cov_file, params=params, smap=smap, resid=resid, nomod=nomod, zero1=zero1, zero2=zero2, zero3=zero3, err_file=err_file, flux_min=flux_min, flux_max=flux_max,nowritefits=nowritefits,simple=simple,mips=mips,unimap=unimap
;+
; NAME:
;   hermes_fix_astrom
;
;
; PURPOSE:
;   uses a refeence catalogue and stacking to fix up the astrometry in a fits image
;
;
; CATEGORY:
;   Hermes SCAT
;
;
; CALLING SEQUENCE:
;   hermes_fix_astrom, im_file, cat_file, [file_out, pixby2=pixby2]
;
;
; INPUTS:
;   im_file: name of fits image  needs an extension with name 'image'
;   cat_file: name of fits reference catalogue needs fields 'RA' and 'dec;
;
; OPTIONAL INPUTS:
;  file_out: file stem for .ps, .txt and .fits file showing the stack and fitted parameters
;
;
; KEYWORD PARAMETERS:
;
;   stack_size approximate size of stack image in arc sec.
;   resamp: default resampling of original image e.g. 1=no resampling 2: resampling to half pixel sizes etc. default to 1=no resampling
;   reset: if set then resets to original astrometry defined in CRVAL1_0 and CRVAL2_0 keywords if defined
;          pacs: if set then assumes simple fits files with image rather than multi-extension
;    cov_file: if pacs then this is name of simple fits coverage file
;    params: output parameters from Gaussian fit
;    smap: smap file format
;    resid: XID residual file format
;    pacs: pacs file format
;    nomod: if set then fits files are not modifed
;    zero1: if set then the map is set to have a mean of zero (over regions where the coverage of the map is more than half the median coverage) before stacking
;    zero2: if set then the map is set to have a mean of zero (over regions where the coverage of the map is more than zero) before stacking
;
; OUTPUTS:
;   im_file: image header extension is modified with new crvals
;
;
; OPTIONAL OUTPUTS:
;
;
;
; COMMON BLOCKS:
;
;
;
; SIDE EFFECTS:
; im_file: image header extension is modified with new crvals
; generates files in cwd
;
; RESTRICTIONS:
;  not tested resampling routine
;  not 
; 
;
; PROCEDURE:
;
;
;
; EXAMPLE:
;
;
;
; MODIFICATION HISTORY:
; Seb Oliver 31 August 2010
;-




; on Seb's laptop make sure this routine is compiled!
;.r ~/idl/swire/stack70/stack_image


   on_error, 0

   IF n_params() LT 2 THEN message, 'CALLING SEQUENCE: hermes_fix_astrom, im_file, cat_file, [file_out, pixby2=pixby2]'



;----------------------------------------------------------------------
; setting up various parameters
;----------------------------------------------------------------------

   usr_info = get_login_info()

;---------------------------------
; parameters defining the files 
;---------------------------------



   IF NOT keyword_set(file_out) THEN file_out = 'demo' ; stem used to define .ps, .fits and .txt files giving output
   fwhm = 18. ; estimate FWHM of beam only used to decide approx size of stack (4XFWHM)^2
   IF NOT keyword_set(resamp) THEN resamp = 1 ; re-sampling of pixels e.g. 1 = no re-sampling, 3 = resampling to pixels 1/3 of the size
   IF NOT keyword_set(stack_size) THEN stack_size = 78.



;----------------------------------------------------------------------
; parameters defining the source catalogues
;----------------------------------------------------------------------


;----------------------------------------------------------------------
; looping around each band and each target catalogue
;----------------------------------------------------------------------





;----------------------------------------------------------------------
; reading in the files
;----------------------------------------------------------------------

format = 'scat'
IF keyword_set(mips) THEN format = 'mips'
IF keyword_set(pacs) THEN format = 'pacs'
IF keyword_set(smap) THEN format = 'smap'
IF keyword_set(resid) THEN format = 'resi'
IF keyword_set(simple) THEN format = 'simp'
IF keyword_set(unimap) THEN format = 'unim'

;IF NOT keyword_set(flux_min) THEN flux_min = 400
;IF NOT keyword_set(flux_max) THEN flux_max = 500
message,'Taken out default 24 micron flux limit setting',/inf

CASE format OF  
   'mips':  BEGIN 
      dum=mrdfits(im_file, 0, primary_hd, /silent)
      im = mrdfits(im_file, 1, master_hd, /silent)
      hd = master_hd
      cov = im*0.+1.
      cov_hd=hd
   ENDCASE
   'resi':  BEGIN 
      dum=mrdfits(im_file, 0, primary_hd, /silent)
      im = mrdfits(im_file, 1, master_hd, /silent)
      hd = master_hd
      cov = im*0.+1.

   ENDCASE
   'pacs':  BEGIN 
      dum = readfits(im_file, primary_hd)
      master_hd=primary_hd
      hd = master_hd
;      IF keyword_set(cov_file) THEN cov = readfits(cov_file,cov_hd)
;            IF keyword_set(err_file) THEN err = readfits(err_file,err_hd)

       im=mrdfits(im_file,'image',hd, /silent)
       cov=mrdfits(im_file,'coverage', error_action=1, cov_hd, /silent)
       err=mrdfits(im_file,'error', error_action=1, err_hd, /silent)

   ENDCASE
   'unim':  BEGIN 
      dum = readfits(im_file, primary_hd)
      master_hd=primary_hd
      hd = master_hd
      
      ;cov = readfits(cov_file,cov_hd)
      err = readfits(err_file,err_hd)
      im=readfits(im_file,hd, /silent)
      cov = im*0.+1.
      cov_hd=hd
;       cov=mrdfits(im_file,'coverage', error_action=1, cov_hd, /silent)
;       err=mrdfits(im_file,'error', error_action=1, err_hd, /silent)
;stop

   ENDCASE

   'scat':  begin 
      dum = mrdfits(im_file, 0, primary_hd, /silent)
      master_hd=primary_hd
       im=mrdfits(im_file,'image',hd, /silent)
       
;         rms=mrdfits(dir+im_file,'error')
       cov=mrdfits(im_file,'cov', error_action=1, /silent)
       hd_cov=hd 
;       stop
    ENDCASE
    'smap':  BEGIN
;stop
      dum=mrdfits(im_file, 0, primary_hd, /silent)

       im=mrdfits(im_file,'image',master_hd, /silent)
      hd = master_hd
      cov = mrdfits(im_file,'exposure', cov_hd, /silent)
       flag = mrdfits(im_file,'flag', /silent)
       bad = where(flag GT 0, nbad)
       IF nbad GT 0 THEN cov[bad] = 0
;       stop
    ENDCASE
    'simp': begin
       im = readfits(im_file, master_hd)
       hd = master_hd
       cov = im*0.+1.

    endcase

    ELSE: Message, 'shouldn"t be here'
 ENDCASE



   IF n_elements(cov) EQ 1 THEN cov = fix(im*0)+100B
;         stop


   crval1 = sxpar(hd, 'crval1')
   crval2 = sxpar(hd, 'crval2')
   naxis1 = sxpar(hd, 'naxis1')
   naxis2 = sxpar(hd, 'naxis2')

   obsid = sxpar(master_hd, 'obs_id')
;   stop


;----------------------------------------------------------------------         
; checking if any astrometry corrections have been done before
; if not then put original crvals into keywords 

   crval1_orig = sxpar(hd, 'CRVAL1_0', count=orig_count)
   crval2_orig = sxpar(hd, 'CRVAL2_0', count=orig_count)
   
   IF orig_count EQ 0 THEN BEGIN 
                                ; this must be original copy current values to "original parameters"

      crval1_orig = crval1
      crval2_orig = crval2

      sxaddpar, hd, 'CRVAL1_0', crval1_orig,  'CRVAL1 at '+systime()+ $
       'By: '+usr_info.user_name 
      sxaddpar, hd, 'CRVAL2_0', crval2_orig,  'CRVAL2 at '+systime()+ $
       'By: '+usr_info.user_name

      history = ['Original Astrometry preserved  with HERMES_FIX_ASTROM', $
              systime(), $
              'By: '+usr_info.user_name]

      sxaddhist, history, hd

   ENDIF


;----------------------------------------------------------------------         
; check if we want to reset back to the original values
; and reset crvals to original vals if so
;----------------------------------------------------------------------         

   IF keyword_set(reset) THEN BEGIN 
      IF orig_count GT 0 THEN BEGIN 
         crval1 = crval1_orig
         crval2 = crval2_orig
         sxaddpar, hd, 'crval1', crval1
         sxaddpar, hd, 'crval2', crval2
         message, 'resetting', /inf
         history = ['Reset to Original Astrometry with HERMES_FIX_ASTROM', $
              systime(), $
              'By: '+usr_info.user_name]
         sxaddhist, history, hd
      ENDIF ELSE BEGIN 
         message, 'No original crvals found, assume this is first astrometry fix', /inf
      ENDELSE

   ENDIF

   

; preserve header for updating later
   hd_old = hd





   
;----------------------------------------------------------------------
; resampling the images
;----------------------------------------------------------------------

   IF resamp NE 1 THEN BEGIN 
;stop
      hcongrid,im,hd,out=[naxis1*resamp,naxis2*resamp]
      hcongrid,cov,cov_hd,out=[naxis1*resamp,naxis2*resamp]
      IF KEYWORD_SET(ERR) THEN hcongrid,err,err_hd,out=[naxis1*resamp,naxis2*resamp]
   ENDIF
   IF n_elements(im) EQ 1 THEN stop

;----------------------------------------------------------------------
; flagging up the bad pixels
;----------------------------------------------------------------------

   bad=where(finite(im) eq 0,nbad)
   bad2=where(cov eq 0,nbad2) 
; I've checked and these are the same as you'd hope

   IF nbad GT 0 THEN BEGIN 
      im[bad]=0
      cov[bad] = 0
   ENDIF

;----------------------------------------------------------------------
; reading in the different types of target catalogues
;----------------------------------------------------------------------


; read file

GET_LUN, UNIT_snr_psf
openw, unit_snr_psf, file_out+'snr_vs_prior_flux.txt'
         cat0=mrdfits(cat_file,1, /silent)

;   FOR FLUX_MIN=100, 500, 100 DO BEGIN 
;      FOR FLUX_MAX=FLUX_MIN+100, 1400, 200 DO BEGIN 
         cat = cat0
;         flux_min = 200
;         flux_max = 1000
      
   IF keyword_set(flux_min) THEN begin
      if flux_min ge 0 then cat=cat[where(cat.flux_24 GE flux_min AND cat.flux_24 LE flux_max)]
   endif

   ngals=n_elements(cat)
   
;----------------------------------------------------------------------
; doing the stacking
;----------------------------------------------------------------------
                                ; first decide the size of the stack image
   pix_scale,hd,pix             ;pixel scale in deg
   pix_size = stack_size/(pix*3600.) ; approximate size in pixels
   i_pix_size = round(pix_size/2)*2+1 ; nearst odd number

;stop
IF keyword_set(zero1) THEN BEGIN 
    g1=where(cov gt 0.)
    m1 = median(cov[g1])
    g2 = where(cov GT m1/2, low)
    mu = mean(im[g2])
    im = im-mu
    cov[low] = 0.
ENDIF

IF keyword_set(zero2) THEN BEGIN 
    g1=where(cov gt 0., low)
    mu = mean(im[g1])
    im = im-mu
    cov[low] = 0.
ENDIF


IF keyword_set(zero3) THEN BEGIN 
    g1=where(cov gt 0.)
    percentile,cov[g1],thresh,perc=0.1
    g2 = where(cov GT thresh, low)
    mu = mean(im[g2])
    im = im-mu
    cov[low] = 0.
ENDIF
;stop
    stack_image,im,hd,cat.ra,cat.dec,$
    mu_stack,var,stack,stack2,weight=cov,$
    nsamp=nsamp,/nofilt,stack_hd=stack_hd,size=i_pix_size, /fast,  err=err, var_propagated=var_propagated
;   stop
;----------------------------------------------------------------------
; fitting PRF
;----------------------------------------------------------------------
;stop
   result = GAUSS2DFIT( mu_stack, params,/tilt)
   residual=mu_stack-result
   rms_fit=sqrt(mean(residual^2))

   naxis1=sxpar(stack_hd,'naxis1')
   naxis2=sxpar(stack_hd,'naxis2')
   cdelt1=sxpar(stack_hd,'cdelt1')
   cdelt2=sxpar(stack_hd,'cdelt2')
   

   if (long(naxis1)*resamp ge 32768L or long(naxis2)*resamp ge 32768L) then message,'Resampled image will be too big'

;stop
;----------------------------------------------------------------------
;   IF keyword_set(write_var) THEN BEGIN 
;----------------------------------------------------------------------

var_pop_max=min((var-var_propagated)/mu_stack^2)

tmp = linfit(mu_stack^2, var-var_propagated)

; tmp[0] is what my note describes as sigma_noise^2
; tmp[1] is " "  (sigma_f/f)^2

;

var_psf = var-mu_stack^2 *tmp[1]
dist_circle, dist, [naxis1, naxis2]
dist = dist*pix*3600.
ord = sort(dist)

;set_plot_ps, file_out+'_psf_var.ps'
;colours
;plot, dist, var, psym=3, xtitle='[arc sec]', xrange=[0, 20]

;oplot, dist[ord], var_psf[ord], col=2
;oplot, dist[ord], mu_stack[ord]^2*tmp[1]+tmp[0]+var_propagated,col=4

;oplot, dist[ord], var_propagated[ord], psym=3, col=3
;oplot, dist[ord], var_propagated[ord]+tmp[0], psym=3, col=3, lines=2
;plotsym, 0,1, /fill
;oplot, !x.crange, [1, 1]*tmp[0], col=5, lines=1
;legend, psym=8, col=[0, 2, 3, 4, 5, 3], ['Total', 'PSF', 'Inst', 'fit', 'Extra', 'Inst+Extra'], /right, charsize=1.0
;plot, dist[ord], mu_stack[ord]/sqrt(var_psf[ord]/ngals), xtitle='[arc sec]', ytitle='SNR in PSF', xrange=[0, 20]
;plot, dist[ord], mu_stack[ord]/sqrt(var[ord]/ngals), xtitle='[arc sec]', ytitle='SNR in Stack',xrange=[0, 20]
;endps
;;stop



var_psf = var_psf/ngals
   IF keyword_set(flux_min) THEN begin

printf, unit_snr_psf, flux_min, flux_max, ngals, flux_min, flux_max, max(mu_stack[ord]/sqrt(var_psf[ord]))
endif


;dum = 0
;stop
;stop
if not keyword_set(nowritefits) then begin 
   
   mwrfits, dum, file_out+'.fits',  primary_hd, /create
   sxaddpar, stack_hd, 'EXTNAME', 'IMAGE'
   mwrfits, mu_stack, file_out+'.fits', stack_hd
;sxaddpar, stack_hd, 'EXTNAME', 'Variance'
;mwrfits, var_psf, file_out+'.fits', stack_hd
   sxaddpar, stack_hd, 'EXTNAME', 'error'
   mwrfits, sqrt(var_psf), file_out+'.fits', stack_hd
;stop
endif 

;----------------------------------------------------------------------
; plotting
;----------------------------------------------------------------------
;   set_plot_ps,file_out+'.ps'
;;   stop
  ; icplot,mu_stack,stack_hd, /nan
   ;icplot,mu_stack-result,stack_hd, /nan
   ;endps
   
;----------------------------------------------------------------------
; correcting original header
;----------------------------------------------------------------------

   dpix = [(params[4]-(naxis1/2.-0.5)), $
           (params[5]-(naxis2/2.-0.5))]/resamp
   hd = hd_old
   extast, hd, ast
; old values.
   crpix_old = ast.crpix
   old_crval = ast.crval
; crpix should actually be....
   crpix_new = crpix_old+dpix
; so create new astrometry using this
   ast_new = ast
   ast_new.crpix = crpix_new
; but we don't want to change crpix we want to change crval
   xy2ad, crpix_old[0]-1., crpix_old[1]-1., ast_new, crval1, crval2
   ast.crval = [crval1, crval2]
   ast.crpix = crpix_old
; putting revised astrometry 
   sxaddpar, hd, 'crval1',crval1, format='(g19.12)'
   sxaddpar, hd, 'crval2',crval2, format='(g19.12)'


   history = ['Astrometry updated with HERMES_FIX_ASTROM', $
              systime(), $
              'By: '+usr_info.user_name, $
              'Old CRVAL:'+string(old_crval, format='(2g19.12)'), $
              'New CRVAL:'+string(ast.crval, format='(2g19.12)')]
;stop
   sxaddhist, history, hd
   IF keyword_set(cov_hd) THEN BEGIN 
      sxaddpar, cov_hd, 'crval1',crval1, format='(g19.12)'
      sxaddpar, cov_hd, 'crval2',crval2, format='(g19.12)'
      sxaddhist, history, cov_hd
ENDIF


; modifing the input file
IF NOT keyword_set(nomod) THEN BEGIN 
   IF keyword_set(resid) THEN BEGIN 
      modfits, im_file, 0, hd  
      stop
      IF keyword_set(cov_file) THEN message, 'not set up to adjust astrometry in coverage file'
   ENDIF ELSE modfits, im_file, 0, hd, extname='IMAGE'
ENDIF





;----------------------------------------------------------------------
; writing out the full PRF fit results
;----------------------------------------------------------------------

   get_lun,unit
   openw,unit,file_out+'.txt'
   printf,unit,'Stack peak/Jy',max(mu_stack)*ngals
   printf,unit,'Number of sources in stack',ngals
;         printf,unit,'Total '+target+' flux in stack sources/Jy',total(flux)/1.e6
   printf,unit,'Baseline/Jy:',params[0]*ngals
   printf,unit,'Amplitude of Gaussian/Jy:',params[1]*ngals
   printf,unit,'Noise/Jy:',rms_fit*ngals
   printf,unit,'SNR (peak):',max(mu_stack)/rms_fit
   printf,unit,'Delta X/":', (params[4]-(naxis1/2.-0.5))*cdelt1*3600.
   printf,unit,'Delta Y/":', (params[5]-(naxis2/2.-0.5))*cdelt2*3600.
   printf,unit,'Major axis/":',(params[2]*pix*3600)*(2 * SQRT(2* ALOG(2)))
   printf,unit,'Minor axis/":',(params[3]*pix*3600)*(2 * SQRT(2* ALOG(2)))
   printf,unit,'PA/deg:',90.0-(params[6])/!dtor
   printf, unit, history, format='(a)'

   close,unit
   free_lun,unit


;----------------------------------------------------------------------
; writing out 1 line summary results
;----------------------------------------------------------------------
   get_lun, unit
   openw, unit, file_out+'.astrom'
   printf, unit, obsid, crval1_orig, crval2_orig, crval1, crval2, format='(i12,4(g19.12))'
   close, unit
   free_lun, unit

;ENDFOR

;ENDFOR

close, unit_snr_psf
free_lun, unit_snr_psf


END




