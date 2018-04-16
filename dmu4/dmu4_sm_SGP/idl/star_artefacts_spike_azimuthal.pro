pro star_artefacts_spike_azimuthal, starcat, nstars,title, ang_fit_params,back=back,status=status,scale

;----------------------------------------------------------------------
; working out an azimuthal profile of a difraction spike
;  At heart its quite simple using IDL routine GAUSSFIT with NTERMS=5
; 
;----------------------------------------------------------------------
; star-source x-correlated catalogue structure
; nstars: number of stars used in cross-correlation
; title, string for labeling plot
; ang_fit_params: Gaussian + background fit to the azimuthal profile
;   f(x) = a0 exp (-z^2/2) + a3 + a4 * x
;    x: being tangential linear distance from spike axis in arc sec
;    z: (x-a1)/a2
; of this diffraction spike
; theta : angle of difraction spike input from a1
; width : width of diffraction spike input as 5*a2
; back  : input estimate of the background level 

; parameters 
;----------------------------------------------------------------------

theta=ang_fit_params[1]
width=ang_fit_params[2]*5

reliability=0.8    ; reliabilty target for objects at boundaries of star mask (this is a key parameter which 


;----------------------------------------------------------------------
; BACKGROUND estimation (same as for circle code)
;----------------------------------------------------------------------

; maximum radius of separation star-object
rmax=max(starcat.separation)


;----------------------------------------------------------------------
; now the code changes for diffraction spikes 
;----------------------------------------------------------------------


;----------------------------------------------------------------------
; but first we have to localise the peak and measure the width
;----------------------------------------------------------------------


;plot,starcat.theta,starcat.separation,psym=3
; angular distance from spike (wrapped to be +- 180)
dtheta=(starcat.theta-theta)
cirrange,dtheta
dtheta=dtheta-180.

; *linear distance from spike centre r*dtheta/radians

dtheta_lin=dtheta*starcat.separation*!pi/180

; range used for fitting is objects that are within 15 widths from spike centre
in_spike=where(abs(dtheta_lin) lt 15*width,nspike)

; hard-wired bin width 
dtheta_bin=0.5
h=histogram(dtheta_lin[in_spike],bin=dtheta_bin,locat=x)

; area of strip and normalisation of counts
omega=dtheta_bin*sqrt(rmax^2-x^2)
y=h/omega/nstars



; fitting with Gaussian + linear slope
Result = GAUSSFIT( X, Y, A, NTERMS=5)



; error checking we have reasonably sensible values

if abs(a[1])/ang_fit_params[2] gt 3 or (abs(a[2]-ang_fit_params[2]) gt 3) then begin 
   message,'Error',/inf
;   print,ang_fit_params
;   print,a
endif else begin
   
   dtheta_lin=dtheta_lin-a[1]
   width=5*a[2]
   a[1]=a[1]+theta
   ang_fit_params=a

endelse


;----------------------------------------------------------------------
; getting the scale of the spike, relative to the general artefact
; high 
;----------------------------------------------------------------------


artefact=ang_fit_params[3]-back
scale= ang_fit_params[0]/artefact


;----------------------------------------------------------------------
; plotting
;----------------------------------------------------------------------

plot,x,y,psym=10,title='!17'+string(theta)
oplot,x,result,colo=2


return
end
