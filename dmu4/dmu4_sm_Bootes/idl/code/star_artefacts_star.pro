
pro star_artefacts_star, starcat, nstars, title, fit_params, prior_r_max=prior_r_max

;----------------------------------------------------------------------
;----------------------------------------------------------------------
; star-source x-correlated catalogue structure
; title, string for labeling plot
; x_min, x_max - radial model fitting range (outputs)
; fit_params: parameters fitted to radial number density around stars
; limit - returned value estimating best limiting radius (derived from
;         fit_params and reliability thresholds)
;
;  TBD - needs to return some sort of quality metric on fit parameters
;
;----------------------------------------------------------------------
;----------------------------------------------------------------------
; in this routine we are just modelling the detection of the star
; itself it should be close to a Gaussian with witdth determined by
; the errors in the star positions.  We asume this is on a zero
; background as we are in the whole. 
;----------------------------------------------------------------------

;----------------------------------------------------------------------
; PART 0 calculating the binnned density profile
;-------------------------------------------------------------------------------

; We are not going to do anything fancy here as the counts are
; expected to be high in region of interst


;-------------------------------------------------------------------------------
; counting sources in bins of r^2
;----------------------------------------------------------------------
set_plot_ps,'star.ps'

dr=0.05
h=histogram(starcat.separation,bin=dr,min=0.,location=x)
; x is the radius of the bin
x=x+dr/2

omega=2*!pi*x*dr

; y is counts scaled to sensible units
y=h/float(nstars)/omega ; counts per star per square arc sec

good=where(starcat.separation le prior_r_max)

; estimate the sigma of the Gaussian direct from all the pairs
; (i.e. not from the histogram).  Really this should be corrected for
; the truncation, but this fitting is hugely important for the whole
; artefact masking question.

sigma=sqrt(mean(starcat[good].separation^2))

; set a range for the histogram
peak_range=where(x le prior_r_max)

; estimate the profile from the scaling required of a Gaussian with
; given sigma (should only be required for plotting)

profile=exp(-(x/sigma)^2)
amp=mean(y[peak_range]/profile[peak_range])

fit_params=[amp,sigma]

; then fitting this with Gaussian

; then fitting this with Gaussian
;Result_hole = GAUSSFIT(x[peak_range], y[peak_range], hole_params, NTERMS=3)
;hole_x=hole_params[1]
;if hole_x le 0 then begin 
;   message,'error, negative hole radius',/inf
;   hole_x=0
;endif


;----------------------------------------------------------------------
; grouping together all the plotting at the end
;----------------------------------------------------------------------

plot,x[peak_range],y[peak_range],xtitle='!17Separation !7[!17arc sec!7]!17',$
     ytitle='!17Master density !7[!17(arc sec)!u-2!n!7]!17',$
     title=title,psym=10;,yrange=[0,back0*3]

oplot,x[peak_range],amp*profile[peak_range],colo=2

;stop

endps


return
end
