;***********************************************************************

PRO ICXY2AD, X , Y, HD, A, D,disto=disto

;+
; NAME: 
;        ICXY2AD
;	
;
; PURPOSE:
;	Compute a Lat  and LONG position given a FITS header and (X,Y)
;       able to handle GSS astrometry
;
; CATEGORY:
;	
;
; CALLING SEQUENCE:
;	ICXY2AD, x, y, HD, a, d
;
; INPUTS:
;       X:  Row position (IDL convention)
;       Y:  Col position (IDL convention)
;      HD:  Fits header
;
; OPTIONAL INPUTS:
;	
;	
; KEYWORD PARAMETERS:
;	
;
; OUTPUTS:
;	A:  Longitude in degrees (scalar or vector)
;       D:  Latitude in degrees  (scalar or vector)
;
; OPTIONAL OUTPUTS:
;	
;
; COMMON BLOCKS:
;	
;
; SIDE EFFECTS:
;	
;
; RESTRICTIONS:
;	
;
; PROCEDURE:
;	
;
; EXAMPLE:
;	
;
; MODIFICATION HISTORY:
; 	Written by:	Seb Oliver July 1 1996
;	July, 1994	Any additional mods get described here.
;       6 aug 1998 Seb Oliver modifed to allow field distortion option
;-

 on_error,2



 if N_params() lT 5 then begin
        print,'Syntax -- ICXY2AD, a, d, hd, x, y
        return
 endif


 ; get astronometric header info
 extast,hd,astr

 if(astr.ctype(0) eq 'RA---GSS')then begin

;    GSSSextast,hd,astr
    gsssxyad,astr,x,y,a,d

 endif else begin

     if not keyword_set(disto) then begin
         xy2ad,x,y,astr,a,d
     endif else begin         
        xy2ad,x,y,astr,a,d,disto=disto
    endelse
 endelse


END

