;+
; CREATE_ITERMAP_FROM_CONF, conffile, SAVETODS=savetods, $
;                           TODS=tods, MAPPARAM=mapparam, DATE=date, $
;                           GETDATA=getdata
;
; PURPOSE: Driver function for CREATE_ITERMAP, reading options from configure
; file. See template.conf for list declarations.
;
; INPUTS: 
;  conffile = [string] path to configuration file to use.  Path 
;                    is referenced to root idl directory ie is does not 
;                    assume a particular location for conf files. 
; OPTIONAL INPUTS:
;   savemapdir: Directory to save outputs to (default: !SMAP_MAPS) 
; KEYWORDS:
;   savetods: set to save tods
;   tods:     pass in tods instead of calling SMAP_READ_AND_FILTER
;             if tods is empty, read tods but do not destroy
;             it is an error to pass tods if do_oneband set
;   getdata:  simply read in data and pass back through tods.
;             does not make map
;
; CREATED BY gmarsden@phas.ubc.ca (2011-02-14)
;
; CHANGELOG
;  20110408 (GM) add TODS keywords
;  20110415 (MZ) add speedcut
;  20110418 (MZ) add badobsid
;  20110421 (GM) add fixedparams structure
;  20120322 (GM) add badbolos
;  20120328 (GM) add GETDATA keyword
;  20120418 (GM) add no_medfilt
;  20120625 (GM) add store_pixinfo
;  20120723 (GM) add TODMASKPOLY and TODMASKCIRC
;  20120724 (GM) combine above into TODMASK
;-

PRO CREATE_ITERMAP_FROM_CONF, conffile, SAVETODS=savetods, $
                              TODS=tods, MAPPARAM=mapparam, DATE=date,$
                              SAVEMAPDIR=savemapdir, GETDATA=getdata

  COMPILE_OPT IDL2
  info = CREATEMAP_READ_CONF(conffile)

  MESSAGE,STRING(info.shortname,FORMAT='("Creating map: ",A0)'),/INF

  IF KEYWORD_SET(date) THEN exname = date

  ;; required parameters
  datadirbase = info.datadirbase
  dataname    = info.dataname
  dataversion = info.dataversion

  ;; optional parameters
  IF info.do_ptrs      GE 0  THEN do_ptrs      = info.do_ptrs
  IF info.do_oneband   GE 0  THEN do_oneband   = info.do_oneband
  IF info.no_medfilt   GE 0  THEN no_medfilt   = info.no_medfilt
  IF info.do_tdc       GE 0  THEN do_tdc       = info.do_tdc
  IF info.astromname   NE "" THEN astromname   = info.astromname
  IF info.noastrom     GE 0  THEN noastrom     = info.noastrom
  IF info.todmean      GE 0  THEN todmean      = info.todmean
  IF info.do_jkbolo    GE 0  THEN do_jkbolo    = info.do_jkbolo
  IF info.do_aormaps   GE 0  THEN do_aormaps   = info.do_aormaps
  IF info.do_matched   GE 0  THEN do_matched   = info.do_matched
  IF info.do_redsource GE 0  THEN do_redsource = info.do_redsource
  IF info.red_brute    GE 0  THEN red_brute    = info.red_brute
  IF info.niter        GE 0  THEN niter        = info.niter
  IF info.first_offs   GE 0  THEN first_offs   = info.first_offs
  IF info.first_gain   GE 0  THEN first_gain   = info.first_gain
  IF info.first_wt     GE 0  THEN first_wt     = info.first_wt
  IF info.first_clip   GE 0  THEN first_clip   = info.first_clip
  IF info.grow_clip    GE 0  THEN grow_clip    = info.grow_clip
  IF info.clipsigma    GE 0  THEN clipsigma    = info.clipsigma
  IF info.fixed_nt     GE 0  THEN fixed_nt     = info.fixed_nt
  IF info.nterms       GE 0  THEN nterms       = info.nterms
  IF info.nt_scale     GE 0  THEN nt_scale     = info.nt_scale
  IF info.min_exposure GE 0  THEN min_exposure = info.min_exposure
  IF info.shortname    NE "" THEN shortname    = info.shortname
  IF info.exname       NE "" THEN exname       = info.exname
  IF info.exapp        NE "" THEN exapp        = info.exapp
  IF info.iterdiag     GE 0  THEN iterdiag     = info.iterdiag
  IF info.no250        GE 0  THEN no250        = info.no250
  IF info.no350        GE 0  THEN no350        = info.no350
  IF info.no500        GE 0  THEN no500        = info.no500
  IF info.speedcut     GE 0  THEN speedcut     = info.speedcut
  IF info.badobsid NE PTR_NEW() THEN badobsid  = *info.badobsid
  IF info.badbolos NE PTR_NEW() THEN badbolos  = *info.badbolos
  IF info.jklist NE PTR_NEW() THEN jklist      = *info.jklist
  IF info.pixsize[0]   GE 0 THEN pixsize       = info.pixsize
  IF info.aor_pixsize[0]   GE 0 THEN aor_pixsize = info.aor_pixsize
  IF info.instnoise[0] GE 0 THEN instnoise     = info.instnoise
  IF info.nxpix[0] GT 0      THEN tnxpix       = info.nxpix
  IF info.nypix[0] GT 0      THEN tnypix       = info.nypix
  IF FINITE(info.crvalx[0])  THEN tcrvalx      = info.crvalx
  IF FINITE(info.crvaly[0])  THEN tcrvaly      = info.crvaly
  IF FINITE(info.crpixx[0])  THEN tcrpixx      = info.crpixx
  IF FINITE(info.crpixy[0])  THEN tcrpixy      = info.crpixy
  IF info.projtype     NE "" THEN projtype     = info.projtype
  IF info.nolatlon     GE 0  THEN nolatlon     = info.nolatlon
  IF info.store_pixinfo GE 0 THEN store_pixinfo = info.store_pixinfo

  IF STRLEN( info.allowedobsids ) NE 0 THEN $
     allowed_obsids = ULONG( STRSPLIT( info.allowedobsids, ",", /EXTRACT ) )

  ;;linear astrometry correction
  IF FINITE( info.lin_ra_slope ) || FINITE( info.lin_dec_slope ) || $
     FINITE( info.lin_basetime ) THEN BEGIN
     ;;Rely on later code to complain if they are not all set
     linearcorr = { basetime: info.lin_basetime, $
                    ra_slope: info.lin_ra_slope, $
                    dec_slope: info.lin_dec_slope }
  ENDIF

  ;; fixed params structure
  fixedparams = {dofp:0B, fpdir:"", fpname:"", fpdate:"",$
                 deglitch: 0b}
  IF info.fixeddir NE "" THEN BEGIN
     fixedparams.dofp = 1B
     fixedparams.fpdir = info.fixeddir
  ENDIF
  IF info.fixedname NE "" THEN BEGIN
     fixedparams.dofp = 1B
     fixedparams.fpname = info.fixedname
  ENDIF
  IF info.fixeddate NE "" THEN BEGIN
     fixedparams.dofp = 1B
     fixedparams.fpdate = info.fixeddate
  ENDIF
  IF info.do_fixeddeglitch GE 1 THEN BEGIN
     IF ~ fixedparams.dofp THEN $
        MESSAGE,"Must set fixedparams if doing fixed deglitching"
     fixedparams.deglitch = 1B
     ;;turn off additional deglitching
     first_clip = 0
  ENDIF

  ;;Masks, bolometers
  CREATEMAP_DEFPARAMS, badbolos, excludemask, exname_def
  nmask = N_ELEMENTS( excludemask )
  IF nmask NE 0 && PTR_VALID( info.nomask ) THEN BEGIN
     skipmasks = *info.nomask
     keepmask = BYTARR( nmask, /NOZERO )
     keepmask[*] = 1b
     FOR i=0, N_ELEMENTS(skipmasks) - 1 DO BEGIN
        wexcl = WHERE(STRMATCH(excludemask,skipmasks[i],/FOLD_CASE),nexcl )
        IF nexcl NE 0 THEN keepmask[wexcl] = 0b
     ENDFOR
     wkeep = WHERE( keepmask,nkeep )
     IF nkeep EQ 0 THEN excludemask = [''] ELSE $
        excludemask = excludemask[wkeep]
  END

  ; bad bolos (replaces default)
  IF PTR_VALID(info.badbolos) THEN badbolos = *info.badbolos

  ; todmask
  IF PTR_VALID(info.todmask) THEN BEGIN
      ntodmask = N_ELEMENTS(*info.todmask)
      todmask = REPLICATE({obsid:"", $
                           type:"", $
                           params:PTR_NEW()}, $
                          ntodmask)
      FOR i=0,ntodmask-1 DO BEGIN
         nwords = N_ELEMENTS(*(*info.todmask)[i])
         IF nwords LT 3 THEN $
            MESSAGE, "todmask must have at least 3 parameters"

         todmask[i].obsid  = (*(*info.todmask)[i])[1]
         todmask[i].type   = (*(*info.todmask)[i])[0]
         todmask[i].params = PTR_NEW(DOUBLE((*(*info.todmask)[i])[2:*]))

         ; check formatting
         CASE todmask[i].type OF
            "circ": IF nwords NE 5 THEN $ ; 3 params
               MESSAGE, "bad formatting: todmask=circ obsid rac decc rad"
            "poly": IF nwords MOD 2 NE 0 THEN $ ; even number of params
               MESSAGE, "bad formatting: todmask=poly obsid ra1 dec1 ... ran decn"
            ELSE: MESSAGE, "Undefined todmask type '"+todmask[i].type+"'"
         ENDCASE
      ENDFOR
  ENDIF

  CREATE_ITERMAP, datadirbase, dataname, dataversion, $
                  SAVETODS=savetods, TODS=tods, MAPPARAM=mapparam, $
                  EXNAME=exname, EXAPP=exapp, $
                  DO_PTRS=do_ptrs, DO_ONEBAND=do_oneband, DO_TDC=do_tdc, $
                  NO_MEDFILT=no_medfilt, TODMEAN=todmean,$
                  ASTROMNAME=astromname, NOASTROM=noastrom, $
                  JKLIST=jklist, DO_JKBOLO=do_jkbolo, $
                  DO_AORMAPS=do_aormaps, AOR_PIXSIZE=aor_pixsize,$
                  DO_MATCHED=do_matched, INSTNOISE=instnoise,$
                  DO_REDSOURCE=do_redsource, RED_BRUTE=red_brute, $
                  BADBOLOS=badbolos, EXCLUDEMASK=excludemask, $
                  ITERPARAMS=iterparams, NITER=niter, $
                  FIRST_OFFS=first_offs, FIRST_GAIN=first_gain, $
                  FIRST_WT=first_wt, FIRST_CLIP=first_clip, FIXED_NT=fixed_nt, $
                  NTERMS=nterms, NT_SCALE=nt_scale, MIN_EXPOSURE=min_exposure, $
                  GROW_CLIP=grow_clip, CLIPSIGMA=clipsigma,$
                  ITERDIAG=iterdiag, PIXSIZE=pixsize, SHORTNAME=shortname, $
                  NO250=no250, NO350=no350, NO500=no500, $
                  NXPIX=tnxpix, NYPIX=tnypix, CRVALX=tcrvalx, CRVALY=tcrvaly, $
                  CRPIXX=tcrpixx, CRPIXY=tcrpixy, SPEEDCUT=speedcut, $
                  BADOBSID=badobsid, FIXEDPARAMS=fixedparams,$
                  LINEARCORR=linearcorr, ALLOWED_OBSIDS=allowed_obsids,$
                  SAVEMAPDIR=savemapdir, GETDATA=getdata, NOLATLON=nolatlon, $
                  STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype, $
                  TODMASK=todmask


  CREATEMAP_FREE_CONF, info

END
