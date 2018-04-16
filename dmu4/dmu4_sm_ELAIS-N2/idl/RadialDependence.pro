;----------------------------------------------------------------------
; The HELP Star mask generation IDL code
;----------------------------------------------------------------------

; updated for GAIA by Seb 5th May 2017

defsysv,'!DEBUG',0

;----------------------------------------------------------------------
; key parameters 
;----------------------------------------------------------------------

field_string='lockman-swire'
band_strings=['ch1_swire','k_video','multi','r_cwide']

band_strings=['wfc_r', 'cfht_megacam_r','suprime_r', 'gpc1_r', 'ukidss_k', 'irac1','multi']
band_strings=['ps1_r', 'combo_r', 'atlas_r','video_k','vhs_k','irac1']

readcol,'columns.txt',band_strings,format='(a)'

for iband=0,n_elements(band_strings)-1 do begin 
;for iband=5,5 do begin 
   band_string=band_strings[iband]
   prefix=field_string+'_'+band_string
   case iband of  
      0: theta_spike=[-170.0,-20,+110,160]
      1: theta_spike=[-90.0,0,+90,180]
      2: theta_spike=[-135.0,-90.0,-45,0,+45,+90,135,180]
      3: theta_spike=[-135.0,-90.0,-45,0,+45,+90,135,180]
      4: theta_spike=[-135.0,-90.0,-45,0,+45,+90,135,180]
      5: theta_spike=[-135.0,-90.0,-45,0,+45,+90,135,180]
      6: theta_spike=[-135.0,-90.0,-45,0,+45,+90,135,180]
      else: message,'theta_spike not set'
   endcase
   
; change input file for GAIA 

starcat=mrdfits('./gaia_x_'+band_string+'.fits',1)
;starcat=mrdfits('./xmm_lss_star_match_k_video_120_1012.fits',1)
;starcat=mrdfits('./xmm_lss_star_match_multi_120_1012.fits',1)
main_sample=where(starcat.phot_g_mean_mag le 12 and starcat.separation le 120)


; error trapping
bad=where(finite(starcat.theta) eq 0,com=good, nbad)
if nbad gt 0 then starcat=starcat[good]

;----------------------------------------------------------------------
; things that we are expecting to find in starcat structure
; 
;  starcat is a cross match between a reference star catalogue
;  e.g. Gaia and a catalogue of objects which includes artefacts that
;  we are trying to mask out
;
;  star_id: an identifier for the reference star should be 1-N where N
;  is number of stars in this cross-match
;
;  separation: separation in arc sec between reference star and
;  catalogue object
;  theta: separation in angle (-180<degrees<180) between ref star and
;  catalogue object
;  dra: separation in arc sec on the sky in RA direction between ref
;  star and catalogue object
;  ddec: as dra but for Dec.
; 
;----------------------------------------------------------------------

;----------------------------------------------------------------------
; some generic plotting
;----------------------------------------------------------------------

;----------------------------------------------------------------------
; basic statistics and checks on input catalogue
;----------------------------------------------------------------------

; maximum radius of separation star-object
rmax=max(starcat.separation)

; check star ids are as they should be 

; 5-may-2017 changed this from ".star_id" to ".source_id" for GAIA

star_id=starcat.source_id
uid=star_id(uniq(star_id,sort(star_id)))
if min(star_id) ne min(uid) then message,'Problem with star ids'
if max(star_id) ne max(uid) then message,'Problem with star ids'
nstars=max(star_id)



;----------------------------------------------------------------------
; Basic diagnostic plots
;----------------------------------------------------------------------
set_plot_ps,prefix+'_star_analysis_general.ps'
colours

;----------------------------------------------------------------------
; 2D histogram of the radial and transverse components plotted in
; image  (contours didn't work very well, might be better
; things you could do with kenerl density estimators, but this is not
; used in masking)
;----------------------------------------------------------------------

h2d = HIST_2D(starcat.separation^2,starcat.theta, bin1=200, bin2=4,min1=0,max1=120^2,min2=-180,max2=180)
icplot,h2d

;----------------------------------------------------------------------
; Normal  Delta RA, Delta Dec plot  
;----------------------------------------------------------------------


h2d = HIST_2D(starcat.dra,starcat.ddec, bin1=2, bin2=2,min1=-120,max1=120,min2=-120,max2=120)
icplot,h2d
contour,h2d,levels=[10,20,30,40,50]
contour,alog10(h2d)

endps

;----------------------------------------------------------------------
; this part does an angular projection which is where I (by hand)
; define the angles I want to work with 
;----------------------------------------------------------------------
set_plot_ps,prefix+'_star_spike_theta_all.ps'

h=histogram(starcat[main_sample].theta,location=x)

plot,x,h,/ys,xtitle='!7h',ytitle='!17Counts'
oplot,!x.crange,median(h)*[1,1]
moms=moment(h)
oplot,!x.crange,moms[0]*[1,1]
oplot,!x.crange,(moms[0]+2*sqrt(moms[1]))*[1,1]


width_spike=replicate(1.8,n_elements(theta_spike)) ; width is 3*sigma of a Gaussian fit to spike profile.

scale_spike=fltarr(n_elements(theta_spike))

for i=0,n_elements(theta_spike)-1 do  oplot,[1,1]*theta_spike[i],!y.crange,lines=1,colo=2


endps

;stop
;----------------------------------------------------------------------
; setting up output file to capture results
;----------------------------------------------------------------------

get_lun,unit
openw,unit,prefix+'_analysis_data.txt'


;----------------------------------------------------------------------
;----------------------------------------------------------------------
; now looping around magnitude bins
;----------------------------------------------------------------------
;----------------------------------------------------------------------


; setting up the magnitude limits and a string to be used in plot titles
mag_min=[10,6,8,9,10,11,12,13,14,15,16,17,18]
mag_max=[12,8,9,10,11,12,13,14,15,16,17,18,19]



; setting up some arrays to store values calculated in subroutine calls

limits_circle=fltarr(n_elements(mag_min))
hole_mins=fltarr(n_elements(mag_min))
hole_zeroxs=fltarr(n_elements(mag_min))
hole_edges=fltarr(n_elements(mag_min))
hole_80s=fltarr(n_elements(mag_min))
hole_50s=fltarr(n_elements(mag_min))
artefact_maxs=fltarr(n_elements(mag_min))
star_sigmas=fltarr(n_elements(mag_min))

limits_spike=fltarr(n_elements(theta_spike),n_elements(mag_min))
nstars_arr=fltarr(n_elements(mag_min))

for i=0,n_elements(mag_min)-1 do begin 

;----------------------------------------------------------------------
; reading in files (different for different magnitude ranges as we
; used a larger search radius for brighter stars)
;
; NO LONGER REQUIRED AS WE ONLY HAVE A SINGLE INPUY CATALOGUE NOW
;----------------------------------------------------------------------


;----------------------------------------------------------------------
; creating a string to use for plots
;----------------------------------------------------------------------

   title='!17'+band_string+' '+string(mag_min[i],format='(i2)')+'!7<!17g!7<!17'+string(mag_max[i],format='(i2)')

;----------------------------------------------------------------------
; constructing the relevant sub-sample and (since this is a
; cross-matched catalogue of star-object pairs) re-constructing the
; list of unique stars
;----------------------------------------------------------------------

; 5-may-2017 changed to phot_g_mean_mag (from rmag) for gaia
   samp=where(starcat.phot_g_mean_mag le mag_max[i] and starcat.phot_g_mean_mag ge mag_min[i] )

; tycho IDS ---> GAMA IDs 9-May-2017

gam=starcat[samp].source_id
; unique list of tycho ids
uni=uniq(gam,sort(gam))
; then count number of stars used
nstars=n_elements(uni)
nstars_arr[i]=nstars

;----------------------------------------------------------------------
; This routine defines the central hole and artefact model for each
; magnitude bin
;----------------------------------------------------------------------

set_plot_ps,prefix+'_star_analysis_circle'+string(mag_min[i],format='(i2.2)')+'-'+string(mag_max[i],format='(i2.2)')+'.ps'
if nstars gt 30 then begin 

if (i eq 0 and iband eq 3) then !debug=0 else !debug=0
star_artefacts_circle, starcat[samp],nstars,title, circle_fit_params,limit,zero,hole_zerox,$
                       hole_edge,$
                       x_min=x_min,x_max=x_max,x_ymin=x_ymin,x_ymax=x_ymax,sigma=sigma,$
                       hole_80=hole_80,hole_50=hole_50,gmag=(mag_min[i]+mag_max[i])/2.


printf,unit,'circle_fit_params',circle_fit_params                          


; storing the output
limits_circle[i]=limit
hole_mins[i]=x_ymin
hole_zeroxs[i]=hole_zerox
hole_80s[i]=hole_80
hole_50s[i]=hole_50
hole_edges[i]=hole_edge
star_sigmas[i]=sigma
artefact_maxs[i]=x_ymax
endif

endps

;stop
star_artefacts_star, starcat[samp],nstars,title, star_fit_params, prior_r_max=10

;----------------------------------------------------------------------
; doing the azimuthal modelling of the spike positions, widths and
; profiles we only do this with a relatively large bin in magnitudes
; which give enough signal-to-noise ratio to do this. All we are
; looking for is the position and width of the spike and the peak
; hight of the spike relative to the level of artefacts not in the
; spike. Hopefully this applies reasonably well at all mags.
;
; it might make more logical sense to have this outside the loop but
; as it relies on the radial profile calculated above it would
; generate lots of extra code to move it outside
;----------------------------------------------------------------------

if i eq 0 then begin 

   set_plot_ps,prefix+'_star_analaysis_spike_azimuthal.ps'+string(mag_min[i],format='(i2.2)')+'-'+string(mag_max[i],format='(i2.2)')+'.ps'

   for j=0,n_elements(theta_spike) -1 do begin 

; setting up the initial parameters
      width=width_spike[j]
      theta=theta_spike[j]
      ang_fit_params=[1,theta,width/3.,0,0]

; this is the important subroutine (note that we are using the
; circular fit to the artefacts to define the background level)

      star_artefacts_spike_azimuthal, starcat[samp], nstars,title,ang_fit_params,$
                            back=circle_fit_params[2],status=status,scale
 
; storing the returned values in arrays 
      scale_spike[j]=scale
      theta_spike[j]=ang_fit_params[1]
      width_spike[j]=ang_fit_params[2]*3.

 
   endfor
   endps

printf,unit,'---------------------'
printf,unit,'data about spikes'
printf,unit,'---------------------'
printf,unit,theta_spike,format='(8f6.1)'
printf,unit,width_spike,format='(8f6.1)'
printf,unit,scale_spike,format='(8f6.1)'

;----------------------------------------------------------------------

; closing the check on whether we are using the big bright bin
endif

;----------------------------------------------------------------------
; using the scaling of the spike amplitudes and the radial profile of
; all pairs to build a model of the radial profile of each spike and
; hence a threshold radius
;----------------------------------------------------------------------

for j=0,n_elements(theta_spike) -1 do begin 

; creating a model for the spike radial profile based on the circular model
; but scaled up by a the hight of the spike relative to artefacts
      spike_fit_params=circle_fit_params
      spike_fit_params[0]=spike_fit_params[0]*scale_spike[j]
      limits_spike[j,i]= star_artefacts_threshold(spike_fit_params, reliability=reliability)

endfor

endfor


;----------------------------------------------------------------------
; linear fitting of magnitude trends
;----------------------------------------------------------------------

mag=(mag_min+mag_max)/2.

good=where (mag gt 8. and finite(alog10(limits_circle)))
param_limits=linfit(mag[good],alog10(limits_circle[good]))

good=where (mag gt 8. and finite(alog10(hole_zeroxs)))
param_zerox=linfit(mag[good],alog10(hole_zeroxs[good]))

good=where (mag gt 8. and finite(alog10(hole_edges)))
param_edges=linfit(mag[good],alog10(hole_edges[good]))

good=where (mag gt 8. and finite(alog10(hole_50s)))
param_50=linfit(mag[good],alog10(hole_50s[good]))

printf,unit,'artefact linear params',param_limits
printf,unit,'zerox linear params',param_zerox
printf,unit,'edges linear params',param_edges
printf,unit,'50% cross linear params',param_50

;if iband eq 3 then stop
;----------------------------------------------------------------------
; closing the text file
;----------------------------------------------------------------------

close,unit
free_lun,unit

;----------------------------------------------------------------------
; summary plots
;----------------------------------------------------------------------

set_plot_ps,prefix+'_star_analysis_summary.ps'

;----------------------------------------------------------------------
; plotting the circular radius vs magnitude
;----------------------------------------------------------------------

plotsym,0,/fill

plot,mag,alog10(hole_zeroxs),psym=8,xtitle='!17 g-mag',title=band_string,$
     ytitle='!17log!d10!n(r!dcircle!n/!7[!17arc sec!7]!17)',ys=16,yrange=[-1,4]

good=where (finite(limits_circle) eq 1, ngood)
if ngood gt 0 then oplot,mag,alog10(limits_circle),psym=8,color=4

oplot,mag,alog10(hole_zeroxs),psym=8,color=3
oplot,mag,alog10(hole_edges),psym=8,color=5
oplot,mag,alog10(hole_mins),psym=8,color=2
oplot,mag,alog10(star_sigmas),psym=8,color=6
oplot,mag,alog10(artefact_maxs),psym=8,color=7
;oplot,mag,alog10(hole_80s),psym=8,color=8
oplot,mag,alog10(hole_50s),psym=8,color=8



oplot,!x.crange,!x.crange*param_limits[1]+param_limits[0]
oplot,!x.crange,!x.crange*param_zerox[1]+param_zerox[0],color=3
oplot,!x.crange,!x.crange*param_50[1]+param_50[0],color=8



legend,['Artefact Limit','Hole Zero-x','Hole Edge','Hole min','Star sigma','Artefact Max','Hole 50'],psym=[8,8,8,8,8,8,8],colors=[4,3,5,2,6,7,8],/top,/right,box=0,charsize=1.3

;----------------------------------------------------------------------
; plotting the constraints on spike radii
;----------------------------------------------------------------------

good=where (finite(limits_spike[0,*]) eq 1 and finite(limits_circle) eq 1, ngood)
if ngood gt 2 then begin 
   plot,mag[good],(limits_spike[0,good])/(limits_circle[good]),psym=8,xtitle='!17 Rmag',$
        ytitle='!17!n(r!dspike!n/r!dcircle!n)',/ys ;a,yrange=[-3,3]

   for i=0,n_elements(theta_spike)-1 do  oplot,(mag_min[good]+mag_max[good])/2.,(limits_spike[i,good])/(limits_circle[good]),psym=8,color=3+i


legend,string(round(theta_spike)),colors=findgen(n_elements(theta_spike))+3,psym=8,charsize=1,/bottom,/right,box=0
endif

endps
endfor

end
