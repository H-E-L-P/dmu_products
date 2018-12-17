pro stack_image,im0,hd,ra,dec,mean,var, stack, stack2, med=med,$
                weight=weight,nsamp=nsamp, nofilt=nofilt,$
                mask=mask,b1=b1,sig1=sig1,size=size, src_boost=src_boost,$
                stack_hd=stack_hd, fast=fast, err=err, var_propagated=var_propagated
                
;+
; Name:
;
;
;
; PURPOSE:
;
;
;
; CATEGORY:
;
;
;
; CALLING SEQUENCE:
;
; IDL> stack_image,im0,hd,ra,dec,mean,var, [stack, stack2, med=med,$
;                  weight=weight,nsamp=nsamp, nofilt=nofilt,$
;                  mask=mask,b1=b1,sig1=sig1,size=size, src_boost=src_boost]
;
;
; INPUTS:
;
; im0:           (2D array, naxis1 x naxis2) large image from which stack is to be extracted
; hd:            header for above
; ra (Vector) :  coordinates of target sources whose flux is to be stacked
; dec (vector) : coordinates of target sources whose flux is to be stacked
;
; OPTIONAL INPUTS:
;
; weight:        (2D array, naxis1 x naxis2) large image of weights (n.B. modfied if mask set)
; nofilt:        if set then weights are not used to set bad pixels to zero
;                (assumed that this has already been done - time saver)
; mask:          if set then on return the weight array is set to zero where
;                stacks have been cut-out
; size:          number of pixels on each side of stack image (default 25)
; src_boost:     boost to be given to each source (if not set then
;                default is a boost of 1 of all sources, otherwise
;                must be a vector the same length as ra,dec.  This boost
;                can be used to normalise flux to same effective redshift
;
;
; KEYWORD PARAMETERS:
;
;
;
; OUTPUTS:
;
; mean: (2D array, size x size) mean intensity map around targets
; var: (2D array, size x size) variance of above (i.e, variance between pixels for different
;      targets - error in mean would be smaller than this by root(nsamp))
;
; OPTIONAL OUTPUTS:
;
; stack: (2D array, size x size) sum of intensities around targets
; stack2: (2D array, size x size) sum of squares of intensities around
;         targets
; med:  (2D array, size x size) median stack of intesnities
; b1:   estimate of background from pixels not used in stack
; sig1: estimate of variance in background from pixels not used in stack
; nsamp: (2D array, size x size) number of samples in each pixel
;
;
;
; COMMON BLOCKS:
;
;
;
; SIDE EFFECTS:
;
;
;
; RESTRICTIONS:
;
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
;
;-

;on_error, 0

im=im0


if not keyword_set(size) then size=25
ngals=n_elements(ra)
naxis1=sxpar(hd,'naxis1')
naxis2=sxpar(hd,'naxis2')
IF naxis1 GE 32768 THEN message, 'Image too large for short integer indexing'
IF naxis2 GE 32768 THEN message, 'Image too large for short integer indexing'
naxis1 = fix(naxis1)
naxis2 = fix(naxis2)

if not keyword_set(weight) then weight=reform(replicate(1b,long(naxis1)*naxis2),$
                                              naxis1,naxis2)

IF NOT keyword_set(err) THEN err = reform(replicate(1,long(naxis1)*naxis2),$
                                              naxis1,naxis2)

if not keyword_set(nofilt) then begin
    bad =where(weight eq 0,nbad)
    if nbad gt 0 then im[bad]=0.
endif



; is any of this used?
if not keyword_set(core_rad) then core_rad=30./3.6
if not keyword_set(air1_rad) then air1_rad=[-4.,+4]*87./3.6
if not keyword_set(air2_rad) then air2_rad=[-4.,+4]*2*87./3.6



;----------------------------------------------------------------------
; converting ra, dec of target sources to pixel coordinates
;----------------------------------------------------------------------

;icad2xy,ra,dec,hd,x,y
extast,hd,ast
ad2xy,ra,dec,ast,x,y

; finding sources that lie off the map and putting those well off the map 
; this line was changed 12 Dec 2014
; from this  
; 
; bad = where(x LE -1 OR x GE naxis1 OR y LE -1 OR y GE naxis2, nbad, comp=good, ncomp=ngood)
; to this
; updated on 30th March 2015 to set 2 to a real number rather than an integer to trap a source right at the limit
bad = where(x LE size/2. OR x GE naxis1-(size/2.) OR y LE size/2. OR y GE naxis2-(naxis2/2.), nbad, comp=good_src, ncomp=ngood_src)
IF nbad GT 0 THEN BEGIN
 x[bad] = -size/2
 y[bad] = -size/2
ENDIF


; setting x and y coordinates to short integers

i0=fix(round(x))
j0=fix(round(y))

;print,i0,j0


;----------------------------------------------------------------------
; most of the following code is quite complicated and is only necessary 
; for the median, which we don't often use, so here's a simple, fast, 
; low memory version
;----------------------------------------------------------------------

IF keyword_set(fast) THEN BEGIN 
   IF  keyword_set( median) THEN message, 'You can only go fast if you are not doing a median stack'
; initialisation
   stack = fltarr(size, size)
   stack2 = fltarr(size, size)
   nsamp = fltarr(size, size)
   nsamp2  =fltarr(size, size)
   var_propagated = fltarr(size, size)
   FOR icount=0, ngood_src-1 DO BEGIN

; not quite sure if the "good" list above is good enough, it would include sources that overlap with the edges, so this may fall over;
; but then the previous code would have been wrong too so I'm going to stick with it for the time-being to check that I get the same
; results
      isource = good_src[icount]
      w_tmp = weight[(i0[isource]-size/2):(i0[isource]+size/2), (j0[isource]-size/2):(j0[isource]+size/2)]
      im_tmp = im0[(i0[isource]-size/2):(i0[isource]+size/2), (j0[isource]-size/2):(j0[isource]+size/2)]
      err_tmp = err[(i0[isource]-size/2):(i0[isource]+size/2), (j0[isource]-size/2):(j0[isource]+size/2)]
      good_stamp = where(w_tmp GT 0 AND finite(im_tmp) EQ 1 AND finite(err_tmp) GT 0, ngood_stamp, ncomp=nbad)
      IF ngood_stamp GT 0 THEN BEGIN 
         stack[good_stamp] += w_tmp[good_stamp]*im_tmp[good_stamp]
         stack2[good_stamp] += w_tmp[good_stamp]*im_tmp[good_stamp]^2
         nsamp[good_stamp] += w_tmp[good_stamp]
         nsamp2[good_stamp] += w_tmp[good_stamp]^2
         var_propagated[good_stamp] += w_tmp[good_stamp]^2*err_tmp[good_stamp]^2
      endif
   ENDFOR
;stop
   
ENDIF ELSE BEGIN 
;----------------------------------------------------------------------
; setting up 3D array to define the i and j coordinates (in the
; orginal image) of the pixels in the stack cube
;----------------------------------------------------------------------

; 1D coordinate offsets

di=indgen(size)-size/2
dj=di

; 2D coordinates offsets
make_2d,di,dj,dii,djj
;print,di,dj

; 3D coordinates offsets

i=reform(fix(reform(dii,size^2)#replicate(1,ngals)),size,size,ngals)
j=reform(fix(reform(djj,size^2)#replicate(1,ngals)),size,size,ngals)

;----------------------------------------------------------------------
; offseting from source positions


i = reform(fix(replicate(1,size^2)#i0)+temporary(i),size,size,ngals)
j = reform(fix(replicate(1,size^2)#j0)+temporary(j),size,size,ngals)

;----------------------------------------------------------------------
; ensuring within boundaries N.B. weights at boundaries should
; have been set to zero
;----------------------------------------------------------------------

i = temporary(i) > 0 & i = temporary(i) < (fix(naxis1)-1)
j = temporary(j) > 0 & j = temporary(j) < (fix(naxis2)-1)

;window,4
;icplot,im[i,j]

;----------------------------------------------------------------------
; setting-up weight and stack cubes
;----------------------------------------------------------------------

StackCube = im [i,j]      ;*weight[i,j]
WeightCube=weight[i,j]

; ensuring still 3D

StackCube = reform(StackCube, size, size, ngals)
WeightCube = reform(WeightCube, size, size, ngals)


;----------------------------------------------------------------------
; calculating statistics for all pixels outside the cut-outs
;----------------------------------------------------------------------


weight[i,j] = 0
good=where(weight gt 0,ngood)
back=moment(im[good])
b1=back[0]
sig1=sqrt(back[1])

; if mask has been set then we can leave these weights at zero -
; otherwise we should change them back to what they were
if NOT keyword_set(mask) then weight[i,j] = WeightCube

;----------------------------------------------------------------------
; folding in source boost
;----------------------------------------------------------------------
IF NOT keyword_set(src_boost) THEN BEGIN
   src_boost = replicate(1, n_elements(ra))
ENDIF ELSE BEGIN
   IF N_ELEMENTS(src_boost) NE n_elements(ra) THEN message, 'elements in src_boost does not match ra'


; reformating to 2D


StackCube = reform(StackCube, size* size, ngals)

; matrix multiplcation to scale by src weight
src_boost_cube = replicate(1, size*size)#src_boost

StackCube = StackCube*src_boost_cube

; & back to 3D


StackCube = reform(StackCube, size, size, ngals)

ENDELSE



;----------------------------------------------------------------------
; calculating stats for all pixels in cut-out (N.B. reformating matrix
; dimensions is necessary because sometimes you only have 1 galaxy and
; then the dimensions can drop to 2D arrays instead of 3D
;----------------------------------------------------------------------

sw = StackCube*WeightCube
Stack=total(reform(sw, size, size, ngals),3)
Stack2=total(reform(sw^2, size, size, ngals),3)
nsamp=total(WeightCube,3)
nsamp2 = total(reform(WeightCube^2, size, size, ngals),3)
;stop


;----------------------------------------------------------------------
; This is the end of the slow breakout for the median stacking
;----------------------------------------------------------------------
ENDELSE


Mean=Stack/nsamp

; old version were weights are assumed 1 or 0
; Var=Stack2/nsamp-mean^2

; weighted sum variance estimator see
; e.g. http://en.wikipedia.org/wiki/Weighted_mean so it will work even
; if the weights are not 1/0 - though we still expect them to be 1/0
; as of Oct. 2007
Var = (Stack2*nsamp-Stack^2)/(nsamp^2-nsamp2) 
;stop
Var_propagated = var_propagated/nsamp^2
;stop
; trap for poorly determined variances
bad = where(nsamp LE 1, nbad, comp=good, ncomp=ngood)
IF nbad GT 0 THEN BEGIN
   IF ngood GT 0 THEN BEGIN
      badvar = max(var[good])*2.
   ENDIF ELSE BEGIN
      badvar = 1
   ENDELSE 
   var[bad] = badvar
   var_propagated[bad] = max(var_propagated[good])*2
ENDIF



;----------------------------------------------------------------------

if keyword_set(med) then begin
    med=fltarr(size,size)
    for i=0, size-1 do begin
        for j=0, size-1 do begin
        good=where(WeightCube[i,j,*] ne 0,ngood)
        if ngood gt 0 then med[i,j]=median(StackCube[i,j,good])
    endfor
    endfor
endif


 
; header for stack
;stop
hextract,im0, hd,dum,stack_hd,naxis1/2,naxis1/2+size-1,naxis2/2,naxis2/2+size-1
extast,stack_hd,ast
ast.crval=[0,0]
putast,stack_hd,ast

return

end
