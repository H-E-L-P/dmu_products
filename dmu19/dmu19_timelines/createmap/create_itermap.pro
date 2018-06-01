;+
; CREATE_ITERMAP, datadirbase, dataname, dataversion, $
;                 SAVETODS=savetods, TODS=tods, MAPPARAM=mapparam, $
;                 EXNAME=exname, EXAPP=exapp, DO_PTRS=do_ptrs, $
;                 DO_TDC=do_tdc, NO_MEDFILT=no_medfilt, DO_ONEBAND=do_oneband,$
;                 ASTROMNAME=astromname, NOASTROM=noastrom, TODMEAN=todmean,$
;                 JKLIST=jklist, DO_JKBOLO=do_jkbolo, DO_AORMAPS=do_aormaps, $
;                 DO_MATCHED=do_matched, DO_REDSOURCE=do_redsource,$
;                 INSTNOISE=instnoise, BADBOLOS=badbolos, $
;                 EXCLUDEMASK=excludemask,EXCLUDEWEIGHTMASK=excludeweightmask,$
;                 ITERPARAMS=iterparams, NITER=niter, FIRST_OFFS=first_offs, $
;                 FIRST_GAIN=first_gain, FIRST_WT=first_wt, $
;                 FIRST_CLIP=first_clip, FIXED_NT=fixed_nt, NTERMS=nterms, $
;                 NT_SCALE=nt_scale, MIN_EXPOSURE=min_exposure, $
;                 ITERDIAG=iterdiag, PIXSIZE=pixsize, SHORTNAME=shortname, $
;                 NO250=no250, NO350=no350, NO500=no500, $
;                 NXPIX=nxpix, NYPIX=nypix, CRVALX=crvalx, CRVALY=crvaly, $
;                 CRPIXX=crpixx, CRPIXY=crpixy, SPEEDCUT=speedcut, $
;                 BADOBSID=badobsid, ALLOWED_OBSIDS=allowed_obsids,$
;                 LINEARCORR=linearcorr, GETDATA=getdata, $
;                 STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype, $
;                 TODMASK=todmask
;
; Generic wrapper script for creating itermaps. Can be called by
; CREATE_ITERMAP_FROM_CONF to use with a config file.
;
; REQUIRED INPUTS:
;   datadirbase:  location of level 1 field data directories 
;                 (i.e., ".../reprocessed/")
;   dataname:     name of data field directory (e.g. "COSMOS") 
;                 is ptr to array of of names (to allow for multiple sets)
;   dataversion:  version tag (e.g. "L1e"). Can be a comma seperated
;                  list of values, which are then paired with dataname
; OPTIONAL (KEYWORD) INPUTS: (see smap_make_maps, smap_read_and_filter)
;   jklist:       list of jackknives to perform
;                 is array of {name:"",index:ptr_new()} structures,
;                 where ptr is to array of tod indices
;   do_jkbolo:    perform focal plane jackknife maps
;   do_aormaps:   do individual sub maps for each aor
;   savetods:     pass in tods instead of calling SMAP_READ_AND_FILTER
;                 if tods is empty, read tods but do not destroy
;                 it is an error to set SAVETODS and DO_ONEBAND
;   getdata:      only read data, don't make maps
;   .....
;
; CREATED BY gmarsden@phas.ubc.ca (2011-02-14)
;
; CHANGELOG
;   2011-02-28 GM: multiple datanames
;   2011-03-04 GM: change name of createmap_defparams.pro
;   2011-04-01 GM: add do_oneband (and add helper function CI_MAKE_ONE_MAP)
;                  add astrometry keywords
;   2011-04-08 GM: add TODS keyword
;   2012-07-20 GM: add PROJTYPE keyword
;   2012-07-23 GM: add TODMASKCIRC and TODMASKPOLY for time stream masking
;                  based on sky position
;   2012-07-24 GM: combine TODMASKCIRC and TODMASKPOLY into TODMASK
;-

PRO CI_MAKE_ONE_MAP, mapparam, map250, map350, map500, $
                     DATADIR=datadir, TODS=tods, TOD_INDEX=todindex, $
                     DOPTRS=doptrs, DO_MEDFILT=do_medfilt, $
                     DO_TDC=do_tdc, DO_ONEBAND=do_oneband, $
                     ITER_PARAMS=iterparams, ITER_FIXED=iterfixed, $
                     ITER_FIX_DIR=iterfixdir, FIXEDDEGLITCH=fixeddeglitch, $
                     DEGLITCH250=deglitch250, DEGLITCH350=deglitch350, $
                     DEGLITCH500=deglitch500, PIXSCALE=pixsize, $
                     CRVALX=crvalx, CRVALY=crvaly, CRPIXX=crpixx, $
                     CRPIXY=crpixy, NXPIX=nxpix, NYPIX=nypix, $
                     ASTROMOFFSETS=offsets_info, SHORTNAME=shortname, $
                     EXNAME=exname, ITER_DIAG=iterdiag, TODMEAN=todmean,$
                     BADBOLOS=badbolos,EXCLUDEMASK=excludemask,$
                     EXCLUDEWEIGHTMASK=excludeweightmask,$
                     NO250=no250, NO350=no350, NO500=no500, $
                     DO_MATCHED=do_matched, DO_REDSOURCE=do_redsource,$
                     RED_BRUTE=red_brute, INSTNOISE=instnoise, $
                     INST_USED=inst_used, CONF_USED=conf_used, $
                     LEVEL1FN=level1fn, VERBOSE=verbose, SUCCESS=success,$
                     ERRMSG=errmsg, SPEEDCUT=speedcut, BADOBSID=badobsid, $
                     ALLOWED_OBSIDS=allowed_obsids, LINEARCORR=linearcorr,$
                     SAVEMAPDIR=savemapdir, NOLATLON=nolatlon, $
                     STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype, $
                     TODMASK=todmask

  COMPILE_OPT IDL2, HIDDEN

;; make a single map
;; tods are either passed in through TODS or they are read in and destroyed
;; if DO_ONEBAND set, then they are done one band at a time

  IF KEYWORD_SET( do_matched ) THEN BEGIN
     conf_used = DBLARR(3)
     inst_used = DBLARR(3)
  ENDIF

  IF KEYWORD_SET(do_oneband) THEN BEGIN
     ;; do one band at a time (for memory considerations)

     ;; array of flags for each band
     skipband = [KEYWORD_SET(no250), $
                 KEYWORD_SET(no350), $
                 KEYWORD_SET(no500)]

     ;; loop over bands
     nbands = N_ELEMENTS(skipband)

     FOR b=0,nbands-1 DO BEGIN

        ;; skip if band omitted
        IF skipband[b] THEN CONTINUE

        ;; array of [no250, no350, n500]
        ;; 0 for band i, 1 for others
        nobands = REPLICATE(1B, nbands)
        nobands[b] = 0B

        ;; 1-based band index
        bandind = 1 + b

        ;; read tods for this band channels only
        tods = SMAP_READ_AND_FILTER(datadir, mapparam, $
                                    PTRS=doptrs, ONEBAND=bandind, $
                                    ASTROMOFFSETS=offsets_info, $
                                    BADOBSID=badobsid, TODMASK=todmask, $
                                    SPEEDCUT=speedcut, $
                                    SUCCESS=success, ERRMSG=errmsg, $
                                    MEDFILT=do_medfilt, LINEARCORR=linearcorr,$
                                    ALLOWED_OBSIDS=allowed_obsids,/VERB)
        IF success EQ 0 THEN MESSAGE,"Error on initial read/filter: "+errmsg
        
         ;; save level1 filename if needed for header
        IF ARG_PRESENT(level1fn) THEN BEGIN
           IF SIZE(tods[0],/TNAME) EQ 'POINTER' THEN $
              level1fn = (*tods[0]).progenitorfile $
           ELSE $
              level1fn=tods[0].progenitorfile
        ENDIF

        ;; do tdc?
        IF KEYWORD_SET(do_tdc) THEN BEGIN
           SMAP_TCDRIFT_CORRECT,tods,EXCLUDEMASK=excludemask,$
                                TODMEAN=todmean,/VERBOSE,SUCCESS=stc_success,$
                                NO250=nobands[0], NO350=nobands[1], $
                                NO500=nobands[2], $
                                ERRMSG=stc_errmsg
           IF stc_success EQ 0 THEN $
              MESSAGE,"Error in tc drift correction: "+stc_errmsg
        ENDIF

        ;; use shortname?
        IF N_ELEMENTS(shortname) EQ 0 THEN mapname = mapparam.obsids_short $
        ELSE mapname = shortname

        IF KEYWORD_SET(exname) THEN thisexname=mapname+exname ELSE $
           thisexname = ""

        SMAP_MAKE_MAPS, tods, mapparam, tmap250, tmap350, tmap500, $
                        SUCCESS=success, ERRMSG=errmsg, /VERB, /ITERMAP, $
                        CRVALX=crvalx, CRVALY=crvaly, CRPIXX=crpixx, $
                        CRPIXY=crpixy, NXPIX=nxpix, NYPIX=nypix, $
                        PIXSCALE=pixsize, ITER_PARAMS=iterparams, $
                        ITER_DIAG=iterdiag, BADBOLOS=badbolos,$
                        EXCLUDEMASK=excludemask, NOLATLON=nolatlon,$
                        EXCLUDEWEIGHTMASK=excludeweightmask,$
                        EXNAME=thisexname, FIXEDDEGLITCH=fixeddeglitch,$
                        DEGLITCH250=deglitch250, DEGLITCH350=deglitch350, $
                        DEGLITCH500=deglitch500, TOD_INDEX=todindex,$
                        NO250=nobands[0], NO350=nobands[1], NO500=nobands[2], $
                        ITER_FIXED=iterfixed, ITER_FIX_DIR=iterfixdir,$
                        FILTER=KEYWORD_SET(do_matched), SAVEMAPDIR=savemapdir,$
                        STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype
        
        IF success EQ 0 THEN MESSAGE,"Error on map build: "+errmsg

        ;; do matched filter?
        IF KEYWORD_SET(do_matched) THEN BEGIN
           IF N_ELEMENTS(instnoise) NE 0 THEN BEGIN
              IF N_ELEMENTS(instnoise) GE 3 THEN BEGIN
                 cinstnoise = instnoise[b]
              ENDIF ELSE cinstnoise = instnoise[0]
           ENDIF ELSE BEGIN
              ;; measure inst noise from map
              CASE b OF
                 0: cinstnoise = FIND_INSTNOISE(tmap250.error)
                 1: cinstnoise = FIND_INSTNOISE(tmap350.error)
                 2: cinstnoise = FIND_INSTNOISE(tmap500.error)
              ENDCASE
           ENDELSE
           
           CASE b OF
              0: tmap250 = SMAP_MATCHED_FILTER(tmap250,INST=cinstnoise,$
                                               CONF_OUT=cused, $
                                               WHITE_OUT=iused)
              1: tmap350 = SMAP_MATCHED_FILTER(tmap350,INST=cinstnoise,$
                                               CONF_OUT=cused, $
                                               WHITE_OUT=iused)
              2: tmap500 = SMAP_MATCHED_FILTER(tmap500,INST=cinstnoise,$
                                               CONF_OUT=cused, $
                                               WHITE_OUT=iused)
           ENDCASE
           conf_used[b] = cused
           inst_used[b] = iused
        ENDIF

        ;; Do redmap smoothing?
        IF KEYWORD_SET( do_redsource ) THEN BEGIN
           CASE b OF
              0 : SMAP_REDSOURCE_SMOOTH, tmap250, BRUTE=red_brute
              1 : SMAP_REDSOURCE_SMOOTH, tmap350, BRUTE=red_brute
              2 : SMAP_REDSOURCE_SMOOTH, tmap500, BRUTE=red_brute
           ENDCASE
        ENDIF

        ;; save map
        CASE b OF
           0: map250 = tmap250
           1: map350 = tmap350
           2: map500 = tmap500
        ENDCASE

        IF SIZE(tods, /TNAME) EQ "POINTER" THEN PTR_FREE, tods

     ENDFOR ;; end loop over bands
     
  ENDIF ELSE BEGIN
     ;; all bands at once

     ;; read tods if not passed in
     IF N_ELEMENTS(tods) EQ 0 THEN readtods = 1B ELSE readtods = 0B

     IF readtods THEN BEGIN
        tods = SMAP_READ_AND_FILTER(datadir, mapparam, PTRS=doptrs, $
                                    ASTROMOFFSETS=offsets_info, $
                                    BADOBSID=badobsid, TODMASK=todmask, $
                                    SPEEDCUT=speedcut, $
                                    SUCCESS=success, ERRMSG=errmsg, $
                                    MEDFILT=do_medfilt, LINEARCORR=linearcorr, $
                                    ALLOWED_OBSIDS=allowed_obsids,/VERB)
        IF success EQ 0 THEN MESSAGE,"Error on initial read/filter: "+errmsg
        
        ;; do tdc?
        IF KEYWORD_SET(do_tdc) THEN BEGIN
           SMAP_TCDRIFT_CORRECT,tods,EXCLUDEMASK=excludemask,TODMEAN=todmean,$
                                /VERBOSE,SUCCESS=stc_success,ERRMSG=stc_errmsg
           IF stc_success EQ 0 THEN $
              MESSAGE,"Error doing tc drift correction: "+stc_errmsg
        ENDIF
     ENDIF

     ;; use shortname?
     IF N_ELEMENTS(shortname) EQ 0 THEN mapname = mapparam.obsids_short $
     ELSE mapname = shortname

     IF KEYWORD_SET(exname) THEN thisexname=mapname+exname ELSE $
        thisexname = ""

     
     ;; make a regular map
     SMAP_MAKE_MAPS, tods, mapparam, map250, map350, map500, SUCCESS=success,$
                     ERRMSG=errmsg,/VERB,/ITERMAP,PIXSCALE=pixsize, $
                     CRVALX=crvalx, CRVALY=crvaly, CRPIXX=crpixx, $
                     CRPIXY=crpixy, NXPIX=nxpix, NYPIX=nypix, $
                     ITER_PARAMS=iterparams, ITER_DIAG=iterdiag, $
                     BADBOLOS=badbolos, EXCLUDEMASK=excludemask,$
                     EXCLUDEWEIGHTMASK=excludeweightmask,$
                     EXNAME=thisexname, FIXEDDEGLITCH=fixeddeglitch,$
                     DEGLITCH250=deglitch250, DEGLITCH350=deglitch350, $
                     DEGLITCH500=deglitch500, ITER_FIXED=iterfixed, $
                     ITER_FIX_DIR=iterfixdir, TOD_INDEX=todindex, $
                     NO250=no250, NO350=no350, NO500=no500, NOLATLON=nolatlon,$
                     FILTER=KEYWORD_SET(do_matched), SAVEMAPDIR=savemapdir, $
                     STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype
     IF success EQ 0 THEN MESSAGE,"Error on map build: "+errmsg

     ;; matched filter?
     IF KEYWORD_SET(do_matched) THEN BEGIN
        IF N_ELEMENTS(instnoise) NE 0 THEN BEGIN
           IF N_ELEMENTS(instnoise) GE 3 THEN BEGIN
              cinstnoise = instnoise
           ENDIF ELSE cinstnoise = REPLICATE(instnoise[0],3)
        ENDIF ELSE BEGIN
           cinstnoise = FLTARR(3)
           IF ~ KEYWORD_SET(no250) THEN $
              cinstnoise[0] = FIND_INSTNOISE(map250.error)
           IF ~ KEYWORD_SET(no350) THEN $
              cinstnoise[1] = FIND_INSTNOISE(map350.error)
           IF ~ KEYWORD_SET(no500) THEN $
              cinstnoise[2] = FIND_INSTNOISE(map500.error)
        ENDELSE

        IF ~ KEYWORD_SET(no250) THEN $ 
           map250 = SMAP_MATCHED_FILTER(map250,INST=cinstnoise[0],$
                                        CONF_OUT=cused0, WHITE_OUT=iused0 )
        IF ~ KEYWORD_SET(no350) THEN $ 
           map350 = SMAP_MATCHED_FILTER(map350,INST=cinstnoise[1],$
                                        CONF_OUT=cused1, WHITE_OUT=iused1 )
        IF ~ KEYWORD_SET(no500) THEN $ 
           map500 = SMAP_MATCHED_FILTER(map500,INST=cinstnoise[2],$
                                        CONF_OUT=cused2, WHITE_OUT=iused2 )
        
        IF ~ KEYWORD_SET(no250) THEN conf_used[0] = cused0
        IF ~ KEYWORD_SET(no250) THEN inst_used[0] = iused0
        IF ~ KEYWORD_SET(no350) THEN conf_used[1] = cused1
        IF ~ KEYWORD_SET(no350) THEN inst_used[1] = iused1
        IF ~ KEYWORD_SET(no500) THEN conf_used[2] = cused2
        IF ~ KEYWORD_SET(no500) THEN inst_used[2] = iused2
     ENDIF

     IF KEYWORD_SET( do_redsource ) THEN BEGIN
        IF ~ KEYWORD_SET(no250) THEN $ 
           SMAP_REDSOURCE_SMOOTH, map250, BRUTE=red_brute
        IF ~ KEYWORD_SET(no350) THEN $ 
           SMAP_REDSOURCE_SMOOTH, map350, BRUTE=red_brute
        IF ~ KEYWORD_SET(no500) THEN $ 
           SMAP_REDSOURCE_SMOOTH, map500, BRUTE=red_brute
     ENDIF

     IF KEYWORD_SET(addopthdr) THEN BEGIN
        IF SIZE(tods[0],/TNAME) EQ 'POINTER' THEN $
           level1fn = (*tods[0]).progenitorfile $
        ELSE $
           level1fn=tods[0].progenitorfile
     ENDIF

     ;; free data if read here
     IF readtods && SIZE(tods, /TNAME) EQ "POINTER" THEN $
        PTR_FREE, tods

  ENDELSE


END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PRO CREATE_ITERMAP, datadirbase, dataname, dataversion, $
                    SAVETODS=savetods, TODS=tods, MAPPARAM=mapparam, $
                    EXNAME=exname, EXAPP=exapp, DO_PTRS=do_ptrs, $
                    DO_TDC=do_tdc, NO_MEDFILT=no_medfilt, $
                    TODMEAN=todmean, DO_ONEBAND=do_oneband, $
                    ASTROMNAME=astromname, NOASTROM=noastrom, $
                    JKLIST=jklist, DO_JKBOLO=do_jkbolo, $
                    DO_AORMAPS=do_aormaps, AOR_PIXSIZE=aor_pixsize,$
                    DO_MATCHED=do_matched, INSTNOISE=instnoise,$
                    DO_REDSOURCE=do_redsource, RED_BRUTE=red_brute,$
                    BADBOLOS=badbolos, EXCLUDEMASK=excludemask, $
                    EXCLUDEWEIGHTMASK=excludeweightmask,$
                    ITERPARAMS=iterparams, NITER=niter, FIRST_OFFS=first_offs,$
                    FIRST_GAIN=first_gain, FIRST_WT=first_wt, $
                    FIRST_CLIP=first_clip, FIXED_NT=fixed_nt, NTERMS=nterms, $
                    NT_SCALE=nt_scale, MIN_EXPOSURE=min_exposure, $
                    GROW_CLIP=grow_clip, CLIPSIGMA=clipsigma,$
                    ITERDIAG=iterdiag, PIXSIZE=pixsize, SHORTNAME=shortname, $
                    NO250=no250, NO350=no350, NO500=no500, NOLATLON=nolatlon,$
                    NXPIX=nxpix, NYPIX=nypix, CRVALX=crvalx, CRVALY=crvaly, $
                    CRPIXX=crpixx, CRPIXY=crpixy, SPEEDCUT=speedcut, $
                    BADOBSID=badobsid, FIXEDPARAMS=fixedparams, $
                    LINEARCORR=linearcorr, ALLOWED_OBSIDS=allowed_obsids,$
                    SAVEMAPDIR=savemapdir,NOOBSTIME=noobstime, $
                    GETDATA=getdata, STORE_PIXINFO=store_pixinfo, $
                    PROJTYPE=projtype, TODMASK=todmask
  
  COMPILE_OPT IDL2

  CREATEMAP_DEFPARAMS, badbolos_def, excludemask_def, exname_def,$
                       excludeweightmask_def

; error if tods passed and do_oneband set
  IF KEYWORD_SET(savetods) AND KEYWORD_SET(do_oneband) THEN $
     MESSAGE, "Cannot pass TODS when DO_ONEBAND set"

; error if pass in tods but not mapparam
  IF KEYWORD_SET(tods) AND ~KEYWORD_SET(getdata) AND $
     ~KEYWORD_SET(mapparam) THEN $
     MESSAGE, "Must pass in both TODS and MAPPARAM"

; error if getdata set and tods not set
  IF KEYWORD_SET(getdata) AND ~ARG_PRESENT(tods) THEN $
     MESSAGE, "If GETDATA set, must also pass in TODS"

; path to main data directory
  dversion = STRTRIM(STRSPLIT(dataversion, ",", /EXTRACT),2)
  IF N_ELEMENTS(dversion) GT 1 AND $
     N_ELEMENTS(dversion) NE N_ELEMENTS(*dataname) THEN $
        MESSAGE, "Don't understand how to match dataversion to datanames"
  IF N_ELEMENTS(*dataname) GT 1 THEN BEGIN
     IF N_ELEMENTS(dversion) EQ 1 THEN BEGIN
        dversion = REPLICATE(dversion, N_ELEMENTS(*dataname))
     ENDIF ELSE BEGIN
        IF N_ELEMENTS(dversion) LT N_ELEMENTS(*dataname) THEN $
           MESSAGE,"Don't know how to match data version to data names, as"+$
                   " number of elements don't match"
     ENDELSE
  ENDIF
  datadir = ADDSLASH(datadirbase[0]) + *dataname + "_" + dversion

; test directory
  FOR i=0,N_ELEMENTS(datadir)-1 DO $
     IF ~ FILE_TEST(datadir[i], /DIRECTORY) THEN $
        MESSAGE, "Data directory '" + datadir[i] + "' not found"

  IF N_ELEMENTS(exname)            EQ 0 THEN exname      = exname_def
  IF N_ELEMENTS(savemapdir)        EQ 0 THEN savemapdir  = !SMAP_MAPS
  IF N_ELEMENTS(noobstime)         EQ 0 THEN noobstime   = 0
  IF N_ELEMENTS(badbolos)          EQ 0 THEN badbolos    = badbolos_def
  IF N_ELEMENTS(excludemask)       EQ 0 THEN excludemask = excludemask_def
  IF N_ELEMENTS(excludeweightmask) EQ 0 THEN $
     excludeweightmask = excludeweightmask_def

  IF KEYWORD_SET(exapp) THEN exname += exapp

  IF N_ELEMENTS(iterparams) EQ 0 THEN $
     iterparams =  {niter:20, first_offs:1, first_gain:0, first_wt:10, $
                    first_clip:0, fixed_nt:0, nterms:2, nt_scale:0, $
                    min_exposure: 0.1, clipsigma: 10.0, grow_clip: 3}


; override individual itermap params
  IF N_ELEMENTS(niter)        GT 0 THEN iterparams.niter        = FIX(niter)
  IF N_ELEMENTS(first_offs)   GT 0 THEN iterparams.first_offs   = first_offs
  IF N_ELEMENTS(first_gain)   GT 0 THEN iterparams.first_gain   = first_gain
  IF N_ELEMENTS(first_wt)     GT 0 THEN iterparams.first_wt     = first_wt
  IF N_ELEMENTS(first_clip)   GT 0 THEN iterparams.first_clip   = FIX(first_clip)
  IF N_ELEMENTS(fixed_nt)     GT 0 THEN iterparams.fixed_nt     = FIX(fixed_nt)
  IF N_ELEMENTS(nterms)       GT 0 THEN iterparams.nterms       = FIX(nterms)
  IF N_ELEMENTS(nt_scale)     GT 0 THEN iterparams.nt_scale     = FLOAT(nt_scale)
  IF N_ELEMENTS(min_exposure) GT 0 THEN iterparams.min_exposure = FIX(min_exposure)
  IF N_ELEMENTS(grow_clip)    GT 0 THEN iterparams.grow_clip    = FIX(grow_clip)
  IF N_ELEMENTS(clipsigma)    GT 0 THEN iterparams.clipsigma    = FLOAT(clipsigma)

  ;; any jackknifing?
  do_jackknife = 0b
  IF N_ELEMENTS(jklist) GT 0 OR KEYWORD_SET(do_jkbolo) THEN do_jackknife = 1b

  ;; itermap diagnostics
  ;; off by default
  ;; set params bit to true if do_jackknifes or do_aors set
  IF N_ELEMENTS(iterdiag) EQ 0 THEN iterdiag = 0
  IF do_jackknife OR KEYWORD_SET(do_aormaps) THEN $
     iterdiag = (iterdiag OR 2) ; bitwise OR -- turns on bit 2

  ;; read full data set into memory? Default is yes
  this_doptrs = 1
  IF N_ELEMENTS(do_ptrs) NE 0 THEN this_doptrs = KEYWORD_SET(do_ptrs)

  ;; add "_" to exname if not already there (_ or -)
  ;; copy to local variable so that we don't overwrite input
  this_exname = exname
  char = STRMID(this_exname, 0, 1)
  IF char NE "_" AND char NE "-" THEN this_exname = "_" + this_exname

  ;; find astrometry file, unless noastrom set
  doastrom = 0B
  IF ~KEYWORD_SET(noastrom) THEN BEGIN
     ;; if astromname not set, use default based on data name
     IF ~KEYWORD_SET(astromname) THEN $
        astromname = *dataname + "_" + dversion

     temp_info = $
        SMAP_GET_ASTROMOFFSETS(astromname, VERBOSE=verbose, ERROR=asterror)

     IF ~asterror THEN BEGIN
        doastrom = 1B
        offsets_info = temp_info
     ENDIF
  ENDIF 
  IF ~doastrom THEN MESSAGE, "No astrometry correction applied for: "+$
	STRJOIN(*dataname,'+'), /INF

; turn off median filter if do_tdc
  do_medfilt = 1B
  IF KEYWORD_SET(do_tdc) OR KEYWORD_SET(no_medfilt) THEN do_medfilt = 0B

  IF KEYWORD_SET(shortname) THEN mapname = shortname

  IF ~KEYWORD_SET(do_oneband) THEN BEGIN
     IF N_ELEMENTS(tods) EQ 0 || ~PTR_VALID(tods[0]) THEN BEGIN

        ;; read data
        tods = SMAP_READ_AND_FILTER(datadir, mapparam, PTRS=this_doptrs, $
                                    ASTROMOFFSETS=offsets_info, $
                                    BADOBSID=badobsid, TODMASK=todmask, $
                                    SPEEDCUT=speedcut, $
                                    SUCCESS=success, ERRMSG=errmsg, $
                                    MEDFILT=do_medfilt, /VERB,$
                                    ALLOWED_OBSIDS=allowed_obsids,$
                                    LINEARCORR=linearcorr)

        IF success EQ 0 THEN MESSAGE,"Error on initial read/filter: "+errmsg

        IF KEYWORD_SET(do_tdc) THEN BEGIN
           SMAP_TCDRIFT_CORRECT,tods,EXCLUDEMASK=excludemask,$
                                /VERBOSE,SUCCESS=stc_success,$
                                ERRMSG=stc_errmsg, NO250=no250,$
                                NO350=NO350, NO500=no500, TODMEAN=todmean
           IF stc_success EQ 0 THEN $
              MESSAGE,"Error performing tc drift correction: "+stc_errmsg
        ENDIF
     ENDIF

                                ; use shortname?
     IF ~KEYWORD_SET(shortname) THEN mapname = mapparam.obsids_short
  ENDIF

  ;; done if getdata set
  IF KEYWORD_SET(getdata) THEN RETURN

  ;; used gains/offsets from previous itermap run?
  fixeddeglitch = 0b
  IF fixedparams.dofp THEN BEGIN
     MESSAGE,"Using previous map gains/offsets",/INF
     ;; name
     IF fixedparams.fpname NE "" THEN $
        fpname = fixedparams.fpname $
     ELSE $
        fpname = mapname

     ;; extension
     IF fixedparams.fpdate NE "" THEN $
        fpext = '_'+fixedparams.fpdate $
     ELSE $
        fpext = this_exname

     ;; dir
     IF fixedparams.fpdir NE "" THEN BEGIN
        iterfixdir = fixedparams.fpdir 
     ENDIF ELSE BEGIN
        iterfixdir = ""
     ENDELSE

     iterfixed = fpname + fpext

     ;; deglitching
     IF fixedparams.deglitch THEN BEGIN
        MESSAGE,"Using previous glitches",/INF
        iterdeglitch = fpname+'_itermap'+fpext+'_2ndlevel_deglitch.sav'
        iterfile = addslash(iterfixdir) + iterdeglitch
        IF ~ FILE_TEST( iterfile, /READ ) THEN $
           MESSAGE,"Unable to read iter deglitch save file: "+iterfile
        RESTORE, iterfile
        IF ~ KEYWORD_SET( no250 ) && N_ELEMENTS( deglitch250 ) EQ 0 THEN $
           MESSAGE,"Error restoring deglitch250 from: "+iterfile
        IF ~ KEYWORD_SET( no350 ) && N_ELEMENTS( deglitch350 ) EQ 0 THEN $
           MESSAGE,"Error restoring deglitch350 from: "+iterfile
        IF ~ KEYWORD_SET( no500 ) && N_ELEMENTS( deglitch500 ) EQ 0 THEN $
           MESSAGE,"Error restoring deglitch500 from: "+iterfile
        fixeddeglitch = 1b
     ENDIF 
  ENDIF 

;; FULL DATA SET
  CI_MAKE_ONE_MAP, mapparam, map250, map350, map500, $
                   TODS=tods, DOPTRS=this_doptrs, DATADIR=datadir, $
                   DO_ONEBAND=do_oneband, DO_TDC=do_tdc, $
                   ASTROMOFFSETS=offsets_info, SUCCESS=success, ERRMSG=errmsg,$
                   /VERB,PIXSCALE=pixsize, ITER_PARAMS=iterparams, $
                   ITER_DIAG=iterdiag, BADBOLOS=badbolos,$
                   EXCLUDEMASK=excludemask,$
                   EXCLUDEWEIGHTMASK=excludeweightmask,$
                   SHORTNAME=mapname, EXNAME=this_exname, LEVEL1FN=level1fn, $
                   NO250=no250, NO350=no350, NO500=no500, $
                   DO_MATCHED=do_matched, INSTNOISE=instnoise,$
                   DO_REDSOURCE=do_redsource, RED_BRUTE=red_brute,$
                   NXPIX=nxpix, NYPIX=nypix, CRVALX=crvalx, CRVALY=crvaly, $
                   CRPIXX=crpixx, CRPIXY=crpixy, SPEEDCUT=speedcut, $
                   BADOBSID=badobsid, ITER_FIXED=iterfixed, $
                   ITER_FIX_DIR=iterfixdir, FIXEDDEGLITCH=fixeddeglitch, $
                   DEGLITCH250=deglitch250, DEGLITCH350=deglitch350, $
                   DEGLITCH500=deglitch500, CONF_USED=conf_used, $
                   INST_USED=inst_used, LINEARCORR=linearcorr, $
                   ALLOWED_OBSIDS=allowed_obsids, SAVEMAPDIR=savemapdir,$
                   NOLATLON=nolatlon, TODMEAN=todmean, $
                   STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype, $
                   TODMASK=todmask

  IF success EQ 0 THEN MESSAGE,"Error on map build"

  IF KEYWORD_SET(do_oneband) && ~KEYWORD_SET(shortname) THEN $
     mapname = mapparam.obsids_short

  ;;Set up some optional header information
  SXADDPAR,opthdr,'MAPMAKER','iterative','Type of SMAP map maker'
  SXADDPAR,opthdr,'NITER',iterparams.niter,'Number of map maker iterations'
  SXADDPAR,opthdr,'FRSTOFFS',iterparams.first_offs,'First offset iteration'
  SXADDPAR,opthdr,'FRSTGAIN',iterparams.first_gain,'First gain iteration'
  SXADDPAR,opthdr,'FRSTWT',iterparams.first_wt,'First weight iteration'
  SXADDPAR,opthdr,'FRSTCLIP',iterparams.first_clip,'First clipping iteration'
  SXADDPAR,opthdr,'FIXEDNT',iterparams.fixed_nt,'Fixed number of offset terms'
  SXADDPAR,opthdr,'ITNTERMS',iterparams.nterms,$
           'Number of poly terms in map maker'
  SXADDPAR,opthdr,'ITNTSCAL',iterparams.nt_scale,'Scale for poly order'
  SXADDPAR,opthdr,'ITMNHITS',iterparams.min_exposure,'Min exposure required'
  SXADDPAR,opthdr,'ITCLPSIG',iterparams.clipsigma,'Deglitching sigma clip'
  SXADDPAR,opthdr,'ITCLPGRW',iterparams.grow_clip,'Deglitching growing size'
  IF KEYWORD_SET( do_matched ) THEN BEGIN
     SXADDPAR,opthdr,'MATCHFLT','T','Do matched filter'
     IF ~ KEYWORD_SET(no250) THEN BEGIN
        SXADDPAR,opthdr,'PSWCONF',conf_used[0],'PSW filt confusion used'
        SXADDPAR,opthdr,'PSWINST',inst_used[0],'PSW filt inst used'
     ENDIF
     IF ~ KEYWORD_SET(no350) THEN BEGIN
        SXADDPAR,opthdr,'PMWCONF',conf_used[1],'PMW filt confusion used'
        SXADDPAR,opthdr,'PMWINST',inst_used[1],'PMW filt inst used'
     ENDIF
     IF ~ KEYWORD_SET(no500) THEN BEGIN
        SXADDPAR,opthdr,'PLWCONF',conf_used[2],'PLW filt confusion used'
        SXADDPAR,opthdr,'PLWINST',inst_used[2],'PLW filt inst used'
     ENDIF
  ENDIF ELSE SXADDPAR,opthdr,'MATCHFLT','F','Do matched filter'
  IF KEYWORD_SET( do_redsource ) THEN BEGIN
     SXADDPAR,opthdr,'REDSRC','T','Do red source smoothing'
     IF KEYWORD_SET( red_brute ) THEN $
        SXADDPAR,opthdr,'REDBRUTE','T','Brute force red source smoothing' ELSE $
           SXADDPAR,opthdr,'REDBRUTE','F','Brute force red source smoothing'
  ENDIF ELSE SXADDPAR,opthdr,'REDSRC','F','Do red source smoothing'

  ;;Add list of obsids to header in hex and decimal
  obsids = mapparam.file_obsids
  uobsids = obsids[UNIQ( obsids, SORT(obsids) )]
  nobsids = N_ELEMENTS(uobsids)
  ;;This doesn't seem likely to happen, but, sure, why not check
  IF nobsids GE 1000 THEN BEGIN
     MESSAGE,"Too many unique obsids to record in header",/INF
  ENDIF ELSE BEGIN
     FOR i=0,nobsids-1 DO BEGIN
        hditem = STRING(i,FORMAT='("OBSID",I03)')
        SXADDPAR,opthdr,hditem,uobsids[i],"OBSIDs in map"
     ENDFOR
     FOR i=0,nobsids-1 DO BEGIN
        hditem = STRING(i,FORMAT='("OBSHX",I03)')
        hdval  = '0x'+TO_HEX(uobsids[i])
        SXADDPAR,opthdr,hditem,hdval,"OBSIDs in map (Hex)"
     ENDFOR
  ENDELSE

  ;;Try to get some info from the first file
  IF ~KEYWORD_SET(do_oneband) THEN $
     IF SIZE(tods[0],/TNAME) EQ 'POINTER' THEN $
        flname = (*tods[0]).progenitorfile ELSE flname=tods[0].progenitorfile $
     ELSE flname=level1fn

  IF FILE_TEST(flname, /READ) THEN BEGIN
     hderrmsg = ''
     phd = HEADFITS(flname)
     val = SXPAR(phd,'RA_NOM',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'RA_NOM',val,com
     val = SXPAR(phd,'DEC_NOM',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'DEC_NOM',val,com
     val = SXPAR(phd,'POSANGLE',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'POSANGLE',val,com
     val = SXPAR(phd,'HCSS____',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'HCSS____',val,com
     val = SXPAR(phd,'CUSMODE',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'CUSMODE',val,com
     val = SXPAR(phd,'AOR',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'AOR',val,com
     val = SXPAR(phd,'INSTMODE',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'INSTMODE',val,com
     val = SXPAR(phd,'OBJECT',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'OBJECT',val,com
     val = SXPAR(phd,'OBSERVER',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'OBSERVER',val,com
     val = SXPAR(phd,'OBS_MODE',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'OBS_MODE',val,com
     val = SXPAR(phd,'POINTMOD',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'POINTMOD',val,com
     val = SXPAR(phd,'PROPOSAL',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'PROPOSAL',val,com
     val = SXPAR(phd,'SUBSYS',COMMENT=com,COUNT=nky)
     IF nky NE 0 THEN SXADDPAR,opthdr,'SUBSYS',val,com
  ENDIF ELSE $
     MESSAGE,"Unable to read first TOD file header, skipping added hdr info",/INF

  IF N_ELEMENTS(map250) NE 0 && MAX( map250.exposure ) EQ 0 THEN $
     MESSAGE,"WARNING: no hits in 250 micron map",/INF
  IF N_ELEMENTS(map350) NE 0 && MAX( map350.exposure ) EQ 0 THEN $
     MESSAGE,"WARNING: no hits in 350 micron map",/INF
  IF N_ELEMENTS(map500) NE 0 && MAX( map500.exposure ) EQ 0 THEN $
     MESSAGE,"WARNING: no hits in 500 micron map",/INF

  st=SMAP_WRITE3COLORS(mapname,map250,map350,map500,$
                       /SILENT,ERRMSG=swc_errmsg,EXNAME="_itermap"+this_exname,$
                       NO250=no250, NO350=no350, NO500=no500,$
                       OPTHDR=opthdr,DIR=savemapdir)

;;Write out deglitching info if present
;;We should do this even if we are using previous info
  have250 = N_ELEMENTS(deglitch250) NE 0
  have350 = N_ELEMENTS(deglitch350) NE 0
  have500 = N_ELEMENTS(deglitch500) NE 0
  IF have250 OR have350 OR have500 THEN BEGIN
     dir = addslash(savemapdir)
     outname = dir + mapname + '_itermap' + this_exname + $
               '_2ndlevel_deglitch.sav'

     ;;ugly hack...
     have250 = N_ELEMENTS(deglitch250) NE 0
     have350 = N_ELEMENTS(deglitch350) NE 0
     have500 = N_ELEMENTS(deglitch500) NE 0
     IF have250 THEN BEGIN
        IF have350 THEN BEGIN
           IF have500 THEN BEGIN
              SAVE,deglitch250,deglitch350,deglitch500,FILE=outname,$
                   /COMPRESS
           ENDIF ELSE SAVE,deglitch250,deglitch350,FILE=outname,/COMPRESS
        ENDIF ELSE BEGIN
           ;;250, no 350
           IF have500 THEN $
              SAVE,deglitch250,deglitch500,FILE=outname,/COMPRESS ELSE $
                 SAVE,deglitch250,FILE=outname,/COMPRESS
        ENDELSE
     ENDIF ELSE BEGIN
        ;;no250
        IF have350 THEN BEGIN
           IF have500 THEN BEGIN
              SAVE,deglitch350,deglitch500,FILE=outname,/COMPRESS
           ENDIF ELSE SAVE,deglitch350,FILE=outname,/COMPRESS
        ENDIF ELSE BEGIN
           ;;no350 either
           IF have500 THEN BEGIN
              SAVE,deglitch500,FILE=outname,/COMPRESS
           ENDIF ELSE BEGIN
              MESSAGE,"Logic error saving deglitch information"
           ENDELSE
        ENDELSE
     ENDELSE           
           
  ENDIF

  ;; Jackknifes; re-use astrometry
  IF do_jackknife THEN BEGIN

     ;; astrometry info
     crvalx = FLTARR(3)
     crvaly = crvalx
     crpixx = crvalx
     crpixy = crvalx
     nxpix  = INTARR(3)
     nypix  = nxpix

     IF ~ KEYWORD_SET(no250) THEN BEGIN
        crvalx[0] = map250.astrometry.crval[0]
        crvaly[0] = map250.astrometry.crval[1]
        crpixx[0] = map250.astrometry.crpix[0]
        crpixy[0] = map250.astrometry.crpix[1]
        nxpix[0]  = map250.xsize
        nypix[0]  = map250.ysize
     ENDIF

     IF ~ KEYWORD_SET(no350) THEN BEGIN
        crvalx[1] = map350.astrometry.crval[0]
        crvaly[1] = map350.astrometry.crval[1]
        crpixx[1] = map350.astrometry.crpix[0]
        crpixy[1] = map350.astrometry.crpix[1]
        nxpix[1]  = map350.xsize
        nypix[1]  = map350.ysize
     ENDIF

     IF ~ KEYWORD_SET(no500) THEN BEGIN
        crvalx[2] = map500.astrometry.crval[0]
        crvaly[2] = map500.astrometry.crval[1]
        crpixx[2] = map500.astrometry.crpix[0]
        crpixy[2] = map500.astrometry.crpix[1]
        nxpix[2]  = map500.xsize
        nypix[2]  = map500.ysize
     ENDIF

     ;; reuse iterfixed from above, if available!
     IF (iterdiag AND 2) NE 0 THEN BEGIN ;;bitwise and
        IF N_ELEMENTS(iterfixed) EQ 0 THEN BEGIN
           jk_iterfixed = mapname + this_exname
        ENDIF ELSE IF SIZE(iterfixed, /TNAME) EQ 'STRING' THEN BEGIN
              jk_iterfixed = iterfixed
           ENDIF ELSE jk_iterfixed = mapname + this_exname
     ENDIF

     ;; Resuse the glitch info from before for the jks/aors if available
     jkaor_fixeddeglitch = 0b
     IF N_ELEMENTS(deglitch250) NE 0 AND ~ KEYWORD_SET(no250) THEN $
        jkaor_fixeddeglitch=1b
     IF N_ELEMENTS(deglitch350) NE 0 AND ~ KEYWORD_SET(no350) THEN $
        jkaor_fixeddeglitch=1b
     IF N_ELEMENTS(deglitch500) NE 0 AND ~ KEYWORD_SET(no500) THEN $
        jkaor_fixeddeglitch=1b

     ;; list of jackknife maps
     IF N_ELEMENTS(jklist) GT 0 THEN BEGIN

        ;; loop over jackknife lists
        FOR i=0,N_ELEMENTS(jklist)-1 DO BEGIN

           jkexname = this_exname + "_jk_" + jklist[i].name
           todindex = *jklist[i].index

           str = STRING(i+1, N_ELEMENTS(jklist), jklist[i].name,$
                        FORMAT='("Doing JK map ",I0," of ",I0," with name: ",A0)')
           MESSAGE, str, /INF
           
           CI_MAKE_ONE_MAP, mapparam, map250, map350, map500, $
                            TODS=tods, DOPTRS=this_doptrs, DATADIR=datadir, $
                            DO_ONEBAND=do_oneband, DO_TDC=do_tdc, $
                            ASTROMOFFSETS=offsets_info,$
                            SUCCESS=success,ERRMSG=errmsg,$
                            CRVALX=crvalx, CRVALY=crvaly, CRPIXX=crpixx, $
                            CRPIXY=crpixy, NXPIX=nxpix, NYPIX=nypix, $
                            ITER_PARAMS=iterparams, PIXSCALE=pixsize, $
                            TOD_INDEX=todindex, BADBOLOS=badbolos, $
                            EXCLUDEMASK=excludemask,$
                            EXCLUDEWEIGHTMASK=excludeweightmask,$
                            ITER_FIXED=jk_iterfixed, ITER_FIX_DIR=iterfixdir, $
                            NO250=no250, NO350=no350, NO500=no500, $
                            DO_MATCHED=do_matched, INSTNOISE=instnoise,$
                            SPEEDCUT=speedcut, BADOBSID=badobsid,$
                            DO_REDSOURCE=do_redsource, RED_BRUTE=red_brute,$
                            LINEARCORR=linearcorr, SAVEMAPDIR=savemapdir,$
                            FIXEDDEGLITCH=jkaor_fixeddeglitch,$
                            DEGLITCH250=deglitch250, DEGLITCH350=deglitch350, $
                            DEGLITCH500=deglitch500, NOLATLON=nolatlon, $
                            STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype, $
                            TODMASK=todmask
           IF success EQ 0 THEN MESSAGE,"Error on map build"
           
           st=SMAP_WRITE3COLORS(mapname,map250,map350,map500,$
                                /SILENT,ERRMSG=swc_errmsg,$
                                EXNAME="_itermap"+jkexname,$
                                NO250=no250, NO350=no350, NO500=no500,$
                                OPTHDR=opthdr,DIR=savemapdir)

        ENDFOR

     ENDIF                      ; end jackknife list

     ;; focal plan jackknife
     IF KEYWORD_SET(do_jkbolo) THEN BEGIN

        SMAP_FOCALPLANE_JK, bololist, jkboloindex

        MESSAGE, "Doing focal plane jackknives", /INF
        
        ;; FIRST BOLO
        jkexname = this_exname+"_jk_bolo1"
        fpbadbolos = bololist[WHERE(jkboloindex NE 0)]

        CI_MAKE_ONE_MAP, mapparam, map250, map350, map500, $
                         TODS=tods, DOPTRS=this_doptrs, DATADIR=datadir, $
                         DO_ONEBAND=do_oneband, DO_TDC=do_tdc, $
                         ASTROMOFFSETS=offsets_info, $
                         SUCCESS=success,ERRMSG=errmsg,$
                         CRVALX=crvalx, CRVALY=crvaly, CRPIXX=crpixx, $
                         CRPIXY=crpixy, NXPIX=nxpix, NYPIX=nypix, $
                         PIXSCALE=pixsize, ITER_PARAMS=iterparams, $
                         BADBOLOS=fpbadbolos,EXCLUDEMASK=excludemask,$
                         EXCLUDEWEIGHTMASK=excludeweightmask,$
                         ITER_FIXED=jk_iterfixed, ITER_FIX_DIR=iterfixdir, $
                         NO250=no250, NO350=no350, NO500=no500, $
                         DO_MATCHED=do_matched, INSTNOISE=instnoise,$
                         SPEEDCUT=speedcut, BADOBSID=badobsid,$
                         DO_REDSOURCE=do_redsource, RED_BRUTE=red_brute,$
                         LINEARCORR=linearcorr, SAVEMAPDIR=savemapdir,$
                         FIXEDDEGLITCH=jkaor_fixeddeglitch,$
                         DEGLITCH250=deglitch250, DEGLITCH350=deglitch350, $
                         DEGLITCH500=deglitch500, NOLATLON=nolatlon, $
                         STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype, $
                         TODMASK=todmask
        IF success EQ 0 THEN MESSAGE,"Error on map build"
        
        st=SMAP_WRITE3COLORS(mapname,map250,map350,map500,$
                             /SILENT,ERRMSG=swc_errmsg,$
                             EXNAME="_itermap"+jkexname,$
                             NO250=no250, NO350=no350, NO500=no500,$
                             OPTHDR=opthdr,DIR=savemapdir)

        ;; SECOND BOLO
        jkexname = this_exname+"_jk_bolo2"
        fpbadbolos = bololist[WHERE(jkboloindex NE 1)]

        
        CI_MAKE_ONE_MAP, mapparam, map250, map350, map500, $
                         TODS=tods, DOPTRS=this_doptrs, DATADIR=datadir, $
                         DO_ONEBAND=do_oneband, DO_TDC=do_tdc, $
                         ASTROMOFFSETS=offsets_info, $
                         SUCCESS=success,ERRMSG=errmsg,$
                         CRVALX=crvalx, CRVALY=crvaly, CRPIXX=crpixx, $
                         CRPIXY=crpixy, NXPIX=nxpix, NYPIX=nypix, $
                         PIXSCALE=pixsize, ITER_PARAMS=iterparams, $
                         BADBOLOS=fpbadbolos,EXCLUDEMASK=excludemask,$
                         EXCLUDEWEIGHTMASK=excludeweightmask,$
                         ITER_FIXED=jk_iterfixed, ITER_FIX_DIR=iterfixdir, $
                         NO250=no250, NO350=no350, NO500=no500, $
                         DO_MATCHED=do_matched, INSTNOISE=instnoise,$
                         SPEEDCUT=speedcut, BADOBSID=badobsid,$
                         DO_REDSOURCE=do_redsource, RED_BRUTE=red_brute,$
                         LINEARCORR=linearcorr, SAVEMAPDIR=savemapdir,$
                         FIXEDDEGLITCH=jkaor_fixeddeglitch,$
                         DEGLITCH250=deglitch250, DEGLITCH350=deglitch350, $
                         DEGLITCH500=deglitch500, NOLATLON=nolatlon, $
                         STORE_PIXINFO=store_pixinfo, PROJTYPE=projtype, $
                         TODMASK=todmask
        IF success EQ 0 THEN MESSAGE,"Error on map build"

        st=SMAP_WRITE3COLORS(mapname,map250,map350,map500,$
                             /SILENT,ERRMSG=swc_errmsg,$
                             EXNAME="_itermap"+jkexname,$
                             NO250=no250, NO350=no350, NO500=no500,$
                             OPTHDR=opthdr,DIR=savemapdir)

     ENDIF                      ; end focal plane jackknife

  ENDIF ;; do aor or do jackknife

  ;; do aor sub-maps
  ;; these are different than the jks for four reasons:
  ;; 1) we don't care about the astrometry lining up exactly
  ;; 2) we make the astrometry maps with a different pixel size
  ;; 3) aor maps are always only done in PSW
  ;; 4) we never use any pre-computed astrometry offsets
  IF KEYWORD_SET(do_aormaps) THEN BEGIN
     
     IF N_ELEMENTS(datadir) NE 1 THEN $
        MESSAGE, "Multiple datadirs not allowed for AOR maps"

     IF KEYWORD_SET(no250) THEN $
        MESSAGE, "Can't set /NO250 and make AOR maps"

     ;; reuse iterfixed from above, if available!
     IF (iterdiag AND 2) NE 0 THEN BEGIN ;;bitwise and
        IF N_ELEMENTS(iterfixed) EQ 0 THEN BEGIN
           aor_iterfixed = mapname + this_exname
        ENDIF ELSE IF SIZE(iterfixed, /TNAME) EQ 'STRING' THEN BEGIN
           aor_iterfixed = iterfixed
        ENDIF ELSE aor_iterfixed = mapname + this_exname
     ENDIF

     ;; Also Glitch info
     aor_fixeddeglitch = 0b
     IF N_ELEMENTS(deglitch250) NE 0 THEN aor_fixeddeglitch=1b
     
     obsids = FILE_BASENAME(FILE_SEARCH(ADDSLASH(datadir)+"*", /TEST_DIR))
        
     FOR i=0, N_ELEMENTS(obsids)-1 DO BEGIN
        oid = obsids[i]
        aorexname = this_exname + "_" + oid
        todindex = WHERE(STRMATCH(mapparam.filenames, "*"+oid+"*"))

        IF N_ELEMENTS(aor_pixsize) EQ 0 THEN BEGIN
           aor_ps = pixsize[0]
        ENDIF ELSE IF aor_pixsize[0] EQ -1 THEN BEGIN
           aor_ps = pixsize[0]
        ENDIF ELSE aor_ps = aor_pixsize[0]

        fmt = '("Doing AOR map ",I0," of ",I0," with obsid: ",A0)'
        str = STRING(i+1, N_ELEMENTS(obsids), oid, FORMAT=fmt)
        MESSAGE, str, /INF
        
        CI_MAKE_ONE_MAP, mapparam, map250, map350, map500, $
                         TODS=tods, DOPTRS=this_doptrs, DATADIR=datadir, $
                         DO_ONEBAND=do_oneband, DO_TDC=do_tdc, $
                         SUCCESS=success, ERRMSG=errmsg,$
                         ITER_PARAMS=iterparams, PIXSCALE=aor_ps, $
                         TOD_INDEX=todindex, BADBOLOS=badbolos,$
                         EXCLUDEMASK=excludemask, $
                         EXCLUDEWEIGHTMASK=excludeweightmask,$
                         ITER_FIXED=aor_iterfixed, ITER_FIX_DIR=iterfixdir, $
                         /NO350, /NO500, SPEEDCUT=speedcut, BADOBSID=badobsid,$
                         SAVEMAPDIR=savemapdir, ALLOWED_OBSIDS=allowed_obsids,$
                         FIXEDDEGLITCH=aor_fixeddeglitch, $
                         DEGLITCH250=deglitch250,$
                         NOLATLON=nolatlon, STORE_PIXINFO=store_pixinfo, $
                         PROJTYPE=projtype, TODMASK=todmask
        IF success EQ 0 THEN MESSAGE,"Error on AOR map build"

        st=SMAP_WRITE3COLORS(mapname,map250,map350,map500,$
                             /SILENT,ERRMSG=swc_errmsg,$
                             EXNAME="_itermap"+aorexname,$
                             /NO350, /NO500,$
                             OPTHDR=opthdr,DIR=savemapdir)
        
     ENDFOR

  ENDIF ;; end aor maps
  
  ;; script for finding obstime info (for official fits header)
  IF ~noobstime THEN BEGIN
     GET_LEVEL1_OBSTIME, datadir, obsbeg, obsend, meanmjd
     FORPRINT, [obsbeg, obsend, STRING(meanmjd, '(F14.8)')], $
               TEXTOUT=addslash(savemapdir)+mapname+$
               this_exname+"_obstime.txt", /NOCOMM
  ENDIF

  IF ~KEYWORD_SET(do_oneband) AND ~KEYWORD_SET(savetods) && $
     SIZE(tods, /TNAME) EQ "POINTER" THEN PTR_FREE,tods

END
