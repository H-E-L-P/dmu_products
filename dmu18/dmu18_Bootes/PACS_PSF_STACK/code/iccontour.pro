;***********************************************************************

PRO ICCONTOUR, im, head, TYPE=type, PUTINFO=putinfo, RDGRID=rdgrid, $
               XTITLE=xtitle, YTITLE=ytitle, SUBTITLE=subtitle, NOANNOT=noannot, $
               ANONYMOUS_=dummy_, _EXTRA=extra, full=full, border=border

;+
; NAME:
;	ICCONTOUR
;
; PURPOSE:
;	Contour plot labeled with astronomical coordinates.  The type
;	of coordinate display is controlled by the keyword TYPE.
;	Set TYPE=0 (default) to measure distances from the center of the image
;	(ICCONTOUR will decide whether the plotting units will be in
;	arc seconds, arc minutes, or degrees depending on image size.)
;	Set /TYPE for standard RA and Dec labeling
;
; CALLING SEQUENCE:
;	ICCONTOUR, im, head,[ /TYPE, /PUTINFO, /RDGRID, _EXTRA = ]
;
; INPUTS:
;	im: 2-dimensional image array
;	head: FITS header associated with IM, string array, must include
;		astrometry keywords.   ICCONTOUR will also look for the
;		OBJECT and IMAGE keywords, and print these if found and the 
;		PUTINFO keyword is set.
;
; KEYWORD PARAMETERS:
;	TYPE: the type of astronomical labeling to be displayed.   Either set
;		TYPE = 0 (default), distance to center of the image is
;		marked in units of Arc seconds, arc minutes, or degrees
;
;		TYPE = 1 astronomical labeling with Right ascension and 
;		declination.
;
;	PUTINFO: If set then ICCONTOUR will add information about the image
;		to the right of the contour plot.  Information includes image
;		name, object, image center, image center, contour levels, and
;		date plot was made
;
;	RDGRID: If set then ICCONTOUR will overlay the plot with an RA and
;		Dec grid.
;
;	NOANNOT: If set then ICCONTOUR not display any axes or titles.
;
;       FULL:  if set then image will fill the window
;
;       border: if set then contour outer-edge is outer edge of pixels 
;               rather than half way through outer pixel which is the
;               default for IDL contour routine.
;	Any keyword accepted by CONTOUR may also be passed through ICCONTOUR
;	since ICCONTOUR uses the _EXTRA facility.     ICCONTOUR uses its own
;	defaults for the XTITLE, YTITLE, XMINOR, YMINOR, and SUBTITLE keywords
;	but these may be overridden.
;
; OUTPUTS:
;	Describe any outputs here.
;
; OPTIONAL OUTPUTS:
;	Describe optional outputs here.
;
; COMMON BLOCKS:
;	BLOCK1:	Describe any common blocks here.
;
; SIDE EFFECTS:
;	On its own ICCONTOUR does not plot multiple pictures correctly.
;	It has not been fixed because it would affect the way ICPLOT works.
;	To get the correct sequence of multiple plots it is necessary to
;	set the value of !p.multi(0) by hand before calling ICCONTOUR.
;	IDL> !p.multi(0)=1           ; Plot in second sub-window
;	IDL> iccontour,im2,h2
;
; RESTRICTIONS:
;	(1) The contour plot will have the same dimensional ratio as the input
;		image array
;	(2) To contour a subimage, use HEXTRACT before calling ICCONTOUR
;
; EXAMPLE:
;	Overlay the contour of an image, im2, with FITS header, h2, on top
;	of the display of a different image, im1.   Use RA, Dec labeling, and
;	seven equally spaced contour levels.    Follow the method in Section
;	15-7 of the IDL manual to scale the image to fit the plot display.
;
;	IDL> iccontour,im2,h2      ;Do it once just to get the plot size
;	IDL> py = !y.window*!D.y_vsize
;	IDL> sx = px(1)-px(0)+1 & sy = py(1)-py(0)+1
;	IDL> erase
;	IDL> tv,congrid(im2,sx,sy),px(0),py(0)
;	IDL> iccontour,im2,h2,nlevels=7,/Noerase,/TYPE    ;Now do it for real
;
; MODIFICATION HISTORY:
;	Written   W. Landsman   STX                    May, 1989
;	Fixed RA,Dec labeling  W. Landsman             November, 1991
;	Fix plottting keywords  W.Landsman             July, 1992
;	Recognize GSSS headers  W. Landsman            July, 1994
;	Removed Channel keyword for V4.0 compatibility June, 1995
;	Add _EXTRA CONTOUR plotting keywords  W. Landsman  August, 1995
;       Renamed ICCONTOUR from IMCONTOUR  N. Eaton  10 June 1996
;       Add support for !p.multi plots    N. Eaton  10 June 1996
;       Report error if RA is not CTYPE1  N. Eaton  12 June 1996
;       Add support for RDGRID keyword    N. Eaton  13 June 1996
;       Equinox added to title  S. Oliver  14 August 1996
;       Add support for NOANNOT keyword    N. Eaton  1 November 1996
;       Full keyword added S. Oliver c. end 1997.
;       boder keyword added and fix for few tickmarks bug
;                S. Oliver 8th Dec 1999
;             
;-

; Return to caller for error conditions
   on_error, 2

; Check that there are sufficient input parameters
   if ( n_params() lt 2 ) then begin
      print,'Usage: iccontour, im, head [,/TYPE ,/PUTINFO]'
      print,'       Any CONTOUR keyword is also accepted by ICCONTOUR'  
      return
   endif

; Make sure header appropriate to image
   check_fits, im, head, dimen, /NOTYPE
   if ( !ERR eq -1 ) then return

; Set defaults if keywords not set
   if not keyword_set( TYPE ) then type = 0
   
   if not keyword_set(XMINOR) then $
    if !X.MINOR EQ 0 then xminor = 5 else xminor = !X.MINOR

   if not keyword_set(YMINOR) then $
    if !Y.MINOR EQ 0 then yminor = 5 else yminor = !Y.MINOR

; Extract astrometry from header
   extast, head, astr, noparams      

; Does astrometry exist?
   if ( noparams lt 0 ) then message,'FITS header does not contain astrometry'
   if ( strmid( astr.ctype(0), 5, 3 ) eq 'GSS' ) then begin
      head1 = head
      gsss_STDAST, head1
      extast, head1, astr, noparams
   endif


; Get the equinox from the header
   equ=get_equinox( head, code )
   if ( code eq -1 ) then begin
      print,'Warning: Equinox not defined in header'
      eqs = ''
   endif else begin
      case equ of
         2000:  eqs = 'J2000'
         1950:  eqs = 'B1950'
         else:  eqs = string( equ )
      endcase
   endelse

; Set the plot area to be a set fraction of the window allowing for
; multiple plots
   p1 = max( [ 1.0, float( !p.multi( 1 ) ) ] )
   p2 = max( [ 1.0, float( !p.multi( 2 ) ) ] )

   xp = 0.15 / p1
   yp = 0.15 / p2
   xl = 0.8 / p1
   yl = 0.8 / p2

   if keyword_set(full) then begin
      xp = 0. / p1
      yp = 0. / p2
      xl = 1. / p1
      yl = 1. / p2
   endif

; For multiple plots set the plot origin to the sub-window origin
   np = !p.multi( 1 ) * !p.multi( 2 )
   if ( np gt 0 ) then begin
      ny = !p.multi( 0 ) / !p.multi( 1 )
      x0 = float( !p.multi( 0 ) - ny * !p.multi( 1 ) ) / p1
      y0 = float( !p.multi( 2 ) - 1 - ny ) / p2

; For single plots set the plot origin to the window origin
   endif else begin
      x0 = 0.0
      y0 = 0.0
   endelse

; Adjust plotting window so that contour plot will have same dimensional 
; ratio as the image
   xlength = !D.X_VSIZE / p1
   ylength = !D.Y_VSIZE / p2
   xsize = fix( dimen(0) )  &   ysize = fix( dimen(1) )

; the -1 is for the default behavious of iccontour
; where half pixels at border are not plotted

IF keyword_set(border) THEN BEGIN 
   xsize1 = xsize & ysize1 = ysize
ENDIF ELSE BEGIN  
   xsize1 = xsize-1 & ysize1 = ysize-1 
ENDELSE


   xratio = xsize / float(ysize)
   yratio = ysize / float(xsize)

   if ( ylength*xratio LT xlength ) then begin

      xmax = x0 + xp + xl*ylength*xratio/xlength
      pos = [ x0 + xp, y0 + yp, xmax, y0 + yp + yl ]

   endif else begin

      xmax = x0 + xp + xl
      pos = [ x0 + xp, y0 + yp, xmax, y0 + yp + yl*xlength*yratio/ylength ]

   endelse

   if !X.TICKS GT 0 then xtics = abs(!X.TICKS) else xtics = 8
   if !Y.TICKS GT 0 then ytics = abs(!Y.TICKS) else ytics = 8

; Number of X and Y pixels between tic marks
   pixx = round(xsize/xtics) > 2
   pixy = round(ysize/ytics) > 2

; Get the rotation and plate scale
   getrot,head,rot,cdelt

   xmid = xsize1/2.
   ymid = ysize1/2.

   IF keyword_set(border) THEN BEGIN 
      xmid = xmid-0.5
      ymid = ymid-0.5
   ENDIF


; Get Ra and Dec of image center and make into a string
   xyad,head,xmid,ymid,ra_cen,dec_cen
   ra_dec = adstring(ra_cen,dec_cen,1)

; Determine tic positions and labels for the different type of contour plots


; RA and Dec labeling
   if type NE 0 then begin

; X and Y pixel values of the four corners
      xedge = [ 0, xsize1, 0]
      yedge = [ 0, 0, ysize1]

; should prehaps run along edge of image and check for extremes of
; ra/dec?
;   xedge = [indgen(xsize1),ysize1+intarr(ysize1),$
;            reverse(indgen(xsize1)),intarr(ysize1)]
;   yedge = [intarr(xsize1),indgen(ysize1)+xsize1,$
;            intarr(xsize1),reverse(indgen(ysize1))]

      xy2ad, xedge, yedge, astr, a, d

; Number of X and Y pixels between tic marks
      pixx = xsize/xtics
      pixy = ysize/ytics

; If the first axis is RA
      case STRMID( astr.ctype( 0 ), 0, 2 ) of
         'RA': begin

; Find an even increment for RA and Dec
            tics, a(0), a(1), xsize, pixx, raincr,/ RA
            tics, d(0), d(2), ysize, pixy, decincr

; Position of first RA and Dec tic
            tic_one, a(0), pixx, raincr, botmin, xtic1, /RA
            tic_one, d(0), pixy, decincr,leftmin,ytic1

; Number of X adn Y tic marks
            nx = fix( (xsize1-xtic1-1)/pixx )             
            ny = fix( (ysize1-ytic1-1)/pixy )

            ra_grid = (botmin + findgen(nx+1)*raincr/4.)
            dec_grid = (leftmin + findgen(ny+1)*decincr/60.)

            ticlabels, botmin, nx+1, raincr, xlab, /RA, DELTA=1
            ticlabels, leftmin, ny+1, decincr, ylab, DELTA=1

; Line of constant RA and Dec
            xpos = cons_ra( ra_grid,0,astr )
            ypos = cons_dec( dec_grid,0,astr)
            xunits = 'RIGHT ASCENSION'
            yunits = 'DECLINATION'
         end

; No other type can be handled
         else: message, string( 'CTYPE1 = ', ctype1, ' cannot be handled' )
      endcase

; Label with distance from center
   ENDIF else BEGIN


      ticpos, xsize1*cdelt(0), xsize, pixx, incrx, xunits     
      numx = fix(xsize/(2.*pixx))  
      WHILE numx LE 0 do BEGIN 
        pixx = pixx/2.
        incrx = incrx/2.
        numx = fix(xsize/(2.*pixx))  
      ENDWHILE 
;      stop
      ticpos, ysize1*cdelt(1), ysize, pixy, incry, yunits
      numy = fix(ysize/(2.*pixy))
      WHILE numy LE 0 do BEGIN 
         pixy = pixy/2.
         incry = incry/2.
         numy = fix(ysize/(2.*pixy))  
      ENDWHILE 
      nx = 2*numx & ny = 2*numy
      xpos = xmid + (findgen(nx+1)-numx)*pixx
      ypos = ymid + (findgen(ny+1)-numy)*pixy
      IF incrx/fix(incrx) EQ 1. THEN $
      xlab = string(indgen(nx+1)*incrx - incrx*numx,'(I4)')$
         ELSE $
      xlab = string(findgen(nx+1)*incrx - incrx*numx, '(f6.2)')
      IF incry/fix(incry) EQ 1. THEN $
      ylab = string(indgen(ny+1)*incry - incry*numy,'(I4)') $
               ELSE $
      ylab = string(findgen(ny+1)*incry - incry*numy,'(f6.2)')

   endelse

; Get default values of XTITLE, YTITLE, TITLE and SUBTITLE

   if not keyword_set(PUTINFO) then putinfo = 0

   if N_elements(xtitle) EQ 0 then $
    if !X.TITLE eq '' then xtitle = xunits else xtitle = !X.TITLE

   if N_elements(ytitle) EQ 0 then $
    if !Y.TITLE eq '' then ytitle = yunits else ytitle = !Y.TITLE

   if (not keyword_set( SUBTITLE) ) and (putinfo LT 1) then $
    subtitle = 'CENTER:  R.A. '+ strmid(ra_dec,1,13)+'  DEC ' + $
    strmid(ra_dec,13,13) + '   ' + eqs
   if (not keyword_set( SUBTITLE) ) then subtitle = !P.SUBTITLE

; Plot the map with or without annotation

;stop


   IF keyword_set(border) THEN BEGIN 
; special option for images
      xrange = [-0.5, xsize-0.5]
      yrange = [-0.5, ysize-0.5]
   ENDIF ELSE BEGIN 
; default for contour explicitly set
      xrange = [0., xsize-1]
      yrange = [0., ysize-1]
   endelse
;   stop
   if keyword_set( NOANNOT ) then $
    contour,im, $
    POSITION=pos, XSTYLE=5, YSTYLE=5,$
    _EXTRA = extra, xrange=xrange, yrange=yrange $
;   contour,im, $
;   XTICKS = nx, YTICKS = ny, POSITION=pos, XSTYLE=5, YSTYLE=5,$
;   XTICKV = xpos, YTICKV = ypos, XMINOR = xminor, YMINOR = yminor, $
;   _EXTRA = extra $
   else $
    contour,im, $
    XTICKS = nx, YTICKS = ny, POSITION=pos, XSTYLE=1, YSTYLE=1,$
    XTICKV = xpos, YTICKV = ypos, XTITLE=xtitle, YTITLE=ytitle, $
    XTICKNAME = xlab, YTICKNAME = ylab, SUBTITLE = subtitle, $
    XMINOR = xminor, YMINOR = yminor, _EXTRA = extra, xrange=xrange, yrange=yrange

; Overlay the RA and Dec grid if requested
   if keyword_set( RDGRID ) then begin

      
; Use tic positions in xpos and ypos( 0 ) to define RA's
      s = size( xpos )
      xy2ad, xpos, replicate( ypos( 0 ), s( 1 ) ), astr, a, d

; Calculate lines of constant RA from bottom to top of image
      ypl = [ !y.crange( 0 ), ypos( * ), !y.crange( 1 ) ]
      for i = 0, s( 1 ) - 1 do begin
         xpl = cons_ra( a( i ), ypl, astr )
         oplot, xpl, ypl, linestyle=1
      end

; Use tic positions in xpos( 0 ) and ypos to define Dec's
      s = size( ypos )
      xy2ad, replicate( xpos( 0 ), s( 1 ) ), ypos, astr, a, d

; Calculate lines of constant Dec from left to right of image
      xpl = [ !x.crange( 0 ), xpos( * ), !x.crange( 1 ) ]
      for i = 0, s( 1 ) - 1 do begin
         ypl = cons_dec( d( i ), xpl, astr )
         oplot, xpl, ypl, linestyle = 1
      end
   endif

; Write info about the contour plot if desired

   if ( putinfo GE 1 ) then begin

      xmax = xmax + 0.01

      object = sxpar( head, 'OBJECT' )
      if !ERR ne -1 then xyouts, xmax, 0.95, object, /NORM

      name = sxpar( head, 'IMAGE' )
      if !ERR ne -1 then xyouts,xmax,0.90,name, /NORM

      xyouts, xmax, 0.85,'CENTER:',/NORM
      xyouts, xmax, 0.80, 'R.A. '+ strmid(ra_dec,1,13),/NORM
      xyouts, xmax, 0.75, 'DEC '+  strmid(ra_dec,13,13),/NORM
      xyouts, xmax, 0.70, 'IMAGE SIZE', /NORM
      xyouts, xmax, 0.65, 'X: ' + strtrim(xsize,2), /NORM
      xyouts, xmax, 0.60, 'Y: ' + strtrim(ysize,2), /NORM
      xyouts, xmax, 0.50, strmid(!STIME,0,17),/NORM
      xyouts, xmax, 0.40, 'CONTOUR LEVELS:',/NORM

      sv = !D.NAME
      set_plot,'null'
      contour,im, _EXTRA = extra, PATH_INFO = info
      set_plot,sv

      nlevels = N_elements(info)
      for i = 0,(nlevels < 7)-1 do $
       xyouts,xmax,0.35-0.05*i,string(i,'(i2)') + ':' + $
       string(info(i).value), /NORM

   endif
   
; Adjust the multiple plot index
   if ( np gt 0 ) then begin
      !p.multi( 0 ) = !p.multi( 0 ) + 1
      if ( !p.multi( 0 ) ge np ) then !p.multi( 0 ) = !p.multi( 0 ) - np
   endif

   return                                          

end                                         

