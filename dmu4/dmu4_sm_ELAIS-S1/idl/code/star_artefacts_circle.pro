
pro star_artefacts_circle, starcat, nstars,title, fit_params, limit, zero, hole_zerox, hole_edge, $
                           x_min=x_min,x_max=x_max,x_ymin=x_ymin,x_ymax=x_ymax,sigma=sigma,$
                           hole_80=hole_80,hole_50=hole_50,gmag=gmag

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

reliability=0.8    ; reliabilty target for objects at boundaries of star mask (this is a key parameter which ultimately defines how far down the radial density profile we go

; these next parameters are used to define the bin widths using in
; density estimation and are thus not critical

frac=0.1           ; first guess of fraction of maximum radius used as anulus with for background determination
snr=3.            ; SNR threshold for determining that boundary (only required for range definition)
back_accuracy=0.03 ; target accuracy for background accuracy (only required for range definition)

;----------------------------------------------------------------------
; BACKGROUND estimation
;----------------------------------------------------------------------

; maximum radius of separation star-object
rmax=max(starcat.separation)

; hardwire in first guess a annulus width as a fraction of the rmax
for i=0,1 do begin 

   dr=frac*rmax
   rmin=(1.-frac)*rmax 
  
; area of this annulus
   omega0=!pi*(rmax^2-rmin^2)
   
   
; background calculation 
   back_region=where(starcat.separation ge rmin, back_count)
   back0=float(back_count)/float(nstars)/omega0 ; density in sources per star per sq arc^2
   
; what we really want is an omega such that back0*omega is high enough
; to be measured to better than (say) 3% accuracy, i.e. about 200
; objects

   omega_new=back_accuracy^(-2)/(back0*nstars)
   frac_new=omega_new/omega0*frac

;   print,frac,frac_new,back0*omega0,back0*omega0*nstars,nstars
   frac=frac_new
   if frac lt 0.0001 or frac gt 0.5 then message,'May be a problem'
endfor


;----------------------------------------------------------------------
; PART -1 calculating the impact of the star itself
;----------------------------------------------------------------------
prior_r_max=1.

good=where(starcat.separation le prior_r_max, ngood)

; estimate the sigma of the Gaussian direct from all the pairs
; (i.e. not from the histogram).  Really this should be corrected for
; the truncation, but this fitting is hugely important for the whole
; artefact masking question.

if ngood gt 0 then sigma=sqrt(mean(starcat[good].separation^2)) else sigma=0.5

if sigma gt 1 then message,'Large sigma value'

;----------------------------------------------------------------------
; PART 0 calculating the binnned density profile
;-------------------------------------------------------------------------------

; calculating minium area of annulus
; This us used to defined the binning for density histogram
; 
; now the area that we need to measure this threshold such that excess
; density is measured above SNR given error from total counts (assumes
; Poisson error bars
 
omega_min=snr^2*reliability^2/(1-reliability)/(back0*nstars)

; and we can scale this into a derivitive in r^2 i.e. omega =
; d(pi*r^2) 

dr2=omega_min/!pi 

;-------------------------------------------------------------------------------
; counting sources in bins of r^2
;----------------------------------------------------------------------

h=histogram(starcat.separation^2,bin=dr2,min=0.,location=x)
; x is the radius of the bin
x=sqrt(x+dr2/2.)
; area of the annulus
omega=!pi*dr2

; y is counts scaled to sensible units
y=h/float(nstars)/omega ; counts per star per square arc sec

;-------------------------------------------------------------------------------
; identifying the minimum and maximum
;-------------------------------------------------------------------------------

min_range=where(x gt 3*sigma and x lt 30)
ymin=min(y[min_range],i_ymin)
x_ymin=x[min_range[i_ymin]]

if x_ymin lt 1 and i_ymin eq 0 then message,'Low Hole min',/inf

max_range=where(x gt x_ymin and x lt 40)
ymax=max(y[max_range],i_ymax)
x_ymax=x[max_range[i_ymax]]

;stop
;-------------------------------------------------------------------------------
; simplify this to linear bins of r^2
;----------------------------------------------------------------------

;dr=2
;h=histogram(starcat.separation,bin=dr,min=0.,location=x)
;x=x+dr/2
;omega=2*!pi*x*dr
;y=h/float(nstars)/omega ; counts per star per square arc sec


;-------------------------------------------------------------------------------
; Part 1b using a fitting an interception to determine the threshold
; of the hole
;-------------------------------------------------------------------------------
hole_guess=10.^(2.6-0.11*gmag)

hole_zerox_min=x_ymin;  2.5
hole_zerox_min=(hole_guess/2)> (sigma*2)

hole_zerox_max=x_ymax; 15.
hole_zerox_max= (hole_guess*2) < rmax
;stop

hole_range=where(x ge hole_zerox_min and x le hole_zerox_max, hole_nrange)
if hole_nrange gt 3 then begin 

;-------------------------------------------------------------------------------



;-------------------------------------------------------------------------------
; fitting this range of data with an exponential plus constant background
;-------------------------------------------------------------------------------
   hole_result = COMFIT(X[hole_range], Y[hole_range], [2*back0,exp(-0.036),back0], yfit=hole_yfit, /expon,itmax=100)
;   hole_result = COMFIT(X[hole_range], Y[hole_range], [hole_result[0],hole_result[1],1.,hole_result[2]], yfit=hole_yfit, /gompertz,itmax=100)
 ;  hole_yfit = SPLINE( X[hole_range], Y[hole_range], x[hole_range],1.)
   hole_yfit = smooth(Y[hole_range], 3)
   hole_fit_params=hole_result


; using this mode fit to estimate the required threshold denisty
   hole_zerox=interpol(X[hole_range],hole_yfit,back0)
   hole_80=interpol(X[hole_range],hole_yfit,back0*0.8)
   hole_50=interpol(X[hole_range],hole_yfit,back0*0.5)

;   hole_zerox= star_artefacts_threshold(hole_fit_params, back0)
;   hole_80= star_artefacts_threshold(hole_fit_params, back0*0.8)
   if !debug eq 1 then stop
endif else  begin
;   stop
   hole_zerox=0.
   hole_80=0.
   hole_50=0.
endelse


;stop

;-------------------------------------------------------------------------------
;
; PART 1
;
; using an edge detection filter to determine the threshold of the
; hole
;-------------------------------------------------------------------------------


edge=convol(y,[-1,0,+1])   
peak=max(edge,peak_index)
peak_x=x[peak_index]

edge_status=0

; hardwiring in a radius in which the star itself might be found
zero=x_ymin ;3

; some inelegent code to make sure we have enough bins for fitting

peak_range=where(x ge zero and x le 2*peak_x-zero,npeak_range)
peak_range=where(x ge x_ymin and x le x_ymax,npeak_range)

if npeak_range le 3 then begin 
   edge_status=1
   peak_range=where(x ge 0 and x le 2*peak_x,npeak_range)
   if npeak_range le 3 then begin 
      edge_status=2
      peak_range=indgen(5)
   endif
endif 


; then fitting this with Gaussian
Result_hole = GAUSSFIT(x[peak_range], edge[peak_range], hole_params, NTERMS=3)
hole_edge=hole_params[1]
if hole_edge le 0 then begin 
   message,'error, negative hole radius',/inf
   hole_edge=0
endif



;----------------------------------------------------------------------
; 
; PART 2
;
; model fitting to the radial decline in density of artefacts
;----------------------------------------------------------------------


;----------------------------------------------------------------------
; Fitting range, hardwired for now
;----------------------------------------------------------------------

x_min=10.
x_max=rmax

range=where(x ge x_min and x le x_max, nrange)
if nrange gt 0 then begin 

;-------------------------------------------------------------------------------



;-------------------------------------------------------------------------------
; fitting this range of data with an exponential plus constant background
;-------------------------------------------------------------------------------
result = COMFIT(X[range], Y[range], [2*back0,exp(-0.036),back0], yfit=yfit, /expon,itmax=100)
fit_params=result


; using this mode fit to estimate the required threshold denisty

limit= star_artefacts_threshold(fit_params, reliability=reliability)


;----------------------------------------------------------------------
; grouping together all the plotting at the end
;----------------------------------------------------------------------

plot,x,y,xtitle='!17Separation !7[!17arc sec!7]!17',$
     ytitle='!17Master density !7[!17(arc sec)!u-2!n!7]!17',$
     title=title,psym=10,yrange=[0,back0*3]


; overplotting a flat background level

threshold_density_e_b = fit_params[2]/reliability  ; reliability is the fraction of sources that are real (the background) 
                                           ; compared to all objects

oplot,!x.crange,back0*[1,1],color=3

oplot,x[range],yfit,color=4

oplot,!x.crange,fit_params[2]*[1,1],color=4,lines=1
plotsym,0,2,/fill
oplot,[limit],[threshold_density_e_b],psym=8,colo=4

if hole_nrange gt 3 then begin 
   oplot,x[hole_range],hole_yfit,color=2,thick=5
   oplot,hole_edge*[1,1],!y.crange,color=7
endif

oplot,hole_zerox*[1,1],!y.crange,color=3
oplot,hole_edge*[1,1],!y.crange,color=5
oplot,x_ymin*[1,1],!y.crange,color=2
oplot,sigma*[1,1],!y.crange,color=6
oplot,hole_50*[1,1],!y.crange,color=8
;xyouts,[x_ymin],[mean(!y.crange)],['Hole min'],charsize=0.7,orientation=90
oplot,x_ymax*[1,1],!y.crange,color=7

legend,['Artefact Limit','Hole Zero-x','Hole Edge','Hole min','Star sigma','Artefact Max','Hole 50'],$
       lines=replicate(0,7),colors=[4,3,5,2,6,7,8],/top,/right,box=0,charsize=1.3

plot,x,edge,psym=10

oplot,hole_zerox*[1,1],!y.crange,color=5
oplot,zero*[1,1],!y.crange,color=6
oplot,hole_edge*[1,1],!y.crange,color=7
oplot,x_ymin*[1,1],!y.crange,color=7
xyouts,[x_ymin],[mean(!y.crange)],['Hole min'],charsize=0.7,orientation=90
oplot,x_ymax*[1,1],!y.crange,color=7


endif


return
end
