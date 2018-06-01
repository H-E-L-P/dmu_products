;+
; info = CREATEMAP_READ_CONF(conffile, INFO=info)
;
; Called by CREATE_ITERMAP_FROM_CONF to read configuration options
; from file. See template.conf for list declarations.
;
; Optional input INFO is for recursive calls to function, for the
; "include" declaration.
;
; Since info structure contains pointers, the routine
; CREATEMAP_FREE_CONF is provided for releasing pointers.
;
; CREATED BY gmarsden@phas.ubc.ca (2011-02-14)
;
; CHANGELOG:
;   2011-02-28 gmarsden: add multiple datanames
;   2011-03-28 gmarsden: add matched filter (do_matched)
;   2011-04-01 gmarsden: add do_oneband (read 1 band into memory at a time)
;   2011-04-06 gmarsden: add nxpix/crpixx/crvalx etc
;   2011-04-15 mzemcov:  add speedcut
;   2011-04-18 mzemcov:  add badobsid
;   2011-04-21 gmarsden: add iterfixed params
;   2012-03-22 gmarsden: add badbolos
;   2012-04-18 gmarsden: add no_medfilt
;   2012-06-25 gmarsden: add store_pixinfo
;   2012-07-20 gmarsden: add projtype
;   2012-07-23 gmarsden: add todmaskpoly and todmaskcirc
;   2012-07-24 gmarsden: combine todmasks
;-

PRO CREATEMAP_FREE_CONF, info

  COMPILE_OPT IDL2, HIDDEN
; free all dynamically-allocated data in info structure

; free jklist pointer
  IF PTR_VALID(info.jklist) THEN BEGIN
     ptr = info.jklist
     CREATEMAP_CONFJK_FREE, ptr
     info.jklist = ptr
  ENDIF

  IF PTR_VALID(info.dataname) THEN BEGIN
     PTR_FREE, info.dataname
     info.dataname = PTR_NEW()
  ENDIF

  IF PTR_VALID(info.badobsid) THEN BEGIN
     PTR_FREE, info.badobsid
     info.badobsid = PTR_NEW()
  ENDIF

  IF PTR_VALID(info.badbolos) THEN BEGIN
     PTR_FREE, info.badbolos
     info.badbolos = PTR_NEW()
  ENDIF

  IF PTR_VALID(info.nomask) THEN BEGIN
     PTR_FREE, info.nomask
     info.nomask = PTR_NEW()
  ENDIF

END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

FUNCTION CREATEMAP_READ_CONF, conffile, INFO=info

  COMPILE_OPT IDL2
; initialize info structure unless passed in (for recursion)
  IF N_ELEMENTS(info) EQ 0 THEN $
     info = {datadirbase:  "", $
             dataname:     PTR_NEW(), $
             dataversion:  "", $
             do_ptrs:      -1, $
             do_oneband:   -1, $
             do_tdc:       -1, $
             no_medfilt:   -1, $
             todmean:      -1, $
             astromname:   "", $
             noastrom:     -1, $
             lin_ra_slope:  !VALUES.F_NAN, $
             lin_dec_slope: !VALUES.F_NAN, $
             lin_basetime:  !VALUES.F_NAN, $
             jklist:       PTR_NEW(), $
             do_jkbolo:    -1, $
             do_aormaps:   -1, $
             do_matched:   -1, $
             do_redsource: -1, $
             red_brute:    -1, $
             niter:        -1, $
             first_offs:   -1, $
             first_gain:   -1, $
             first_wt:     -1, $
             first_clip:   -1, $
             fixed_nt:     -1, $
             grow_clip:    -1, $
             clipsigma:    -1.0, $
             nterms:       -1, $
             nt_scale:     -1.0, $
             min_exposure: -1.0, $
             shortname:    "", $
             exname:       "", $
             exapp:        "", $
             iterdiag:     -1, $
             pixsize:      REPLICATE(-1.0, 3), $
             aor_pixsize:  -1.0, $
             instnoise:    REPLICATE(-1.0, 3), $
             no250:        -1, $
             no350:        -1, $
             no500:        -1, $
             speedcut:     -1.0, $
             nxpix:        REPLICATE(-1, 3), $
             nypix:        REPLICATE(-1, 3), $
             crvalx:       REPLICATE(!VALUES.F_NAN, 3), $
             crvaly:       REPLICATE(!VALUES.F_NAN, 3), $
             crpixx:       REPLICATE(!VALUES.F_NAN, 3), $
             crpixy:       REPLICATE(!VALUES.F_NAN, 3), $
             projtype:     "", $
             badobsid:     PTR_NEW(), $
             badbolos:     PTR_NEW(), $
             nomask:       PTR_NEW(), $
             allowedobsids: "",$
             fixeddir:     "", $
             fixedname:    "", $
             fixeddate:    "", $
             do_fixeddeglitch: -1,$
             nolatlon:     -1, $
             store_pixinfo: -1, $
             todmask:  PTR_NEW() $
            }

  IF ~ FILE_TEST(conffile, /READ) THEN $
     MESSAGE, "Could not read conf file '"+conffile

; open conf file
  OPENR, lun, conffile, /GET_LUN, ERR=err
  IF err NE 0 THEN $
     MESSAGE,"ERROR attempting to open "+conffile+": "+$
             !ERROR_STATE.MSG

; loop over lines
  line = ""
  linenum = 1
  WHILE ~ EOF(lun) DO BEGIN
                                ; read line
     READF, lun, line

                                ; strip leading and trailing whitespace
     line = STRTRIM(line, 2)

     ; strip trailing comment
     commpos = STRPOS(line, "#")
     IF commpos NE -1 THEN line = STRMID(line, 0, commpos)

                                ; skip if blank or starts with #
     IF line EQ "" || STRMID(line, 0, 1) EQ "#" THEN CONTINUE

                                ; parse on equals sign into words
     words = STRSPLIT(line, '=', /EXTRACT)

     CASE N_ELEMENTS(words) OF
        1: BEGIN                ; keyword option
           key = STRTRIM(words[0], 2)
           val = 1
        END
        2: BEGIN                ; keyword with value
           key = STRTRIM(words[0], 2)
           val = STRTRIM(words[1], 2)
        END
        3: BEGIN
           MESSAGE, "Line " + STRTRIM(linenum, 2) + " in conf file '" + $
                    conffile + "' contains more than 1 '=' sign"
        END
     ENDCASE

     CASE key OF
        "include": BEGIN
           ;; recursively include new config file
           ;; if path is relative, add on path to current conf file
           IF STRMID(val, 0, 1) EQ '/' THEN $
              newconf = val $
           ELSE $
              newconf = ADDSLASH(FILE_DIRNAME(conffile)) + val

           ;;Test for importing current file, since this causes
           ;; a recursive loop
           IF newconf EQ conffile THEN $
              MESSAGE,"ERROR -- adding same include file to current file"

           info = CREATEMAP_READ_CONF(newconf, INFO=info)
        END
        "dataname": BEGIN
           IF info.dataname EQ PTR_NEW() THEN BEGIN
                                ; initialize list
              info.dataname = PTR_NEW([val])
           ENDIF ELSE BEGIN
                                ; append to list
              temp = *info.dataname
              PTR_FREE, info.dataname
              info.dataname = PTR_NEW([temp, val])
           ENDELSE
        END
        "jackknife": BEGIN
           ;; pointer to an array of structures, {name:"", list:ptr_new()}
           words = STRSPLIT(val, " ", /EXT)
           name = words[0]
           params = FIX(words[1:*])

           ;; make copy of ptr so that function call is pass-by-ref
           ptr = info.jklist
           CREATEMAP_CONFJK, ptr, name, params
           info.jklist = ptr            
        END
        "pixsize": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.pixsize = FLOAT(words[0]) / 3600.0
              3: info.pixsize = FLOAT(words) / 3600.0
              ELSE: MESSAGE, "'pixsize' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "aor_pixsize": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.aor_pixsize = FLOAT(words[0]) / 3600.0
              3: info.aor_pixsize = FLOAT(words[0]) / 3600.0
              ELSE: MESSAGE, "'aor_pixsize' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "instnoise" : BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.instnoise = FLOAT(words[0])
              3: info.instnoise = FLOAT(words)
              ELSE: MESSAGE, "'instnoise' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "nxpix": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.nxpix = FIX(words[0])
              3: info.nxpix = FIX(words)
              ELSE: MESSAGE, "'nxpix' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "nypix": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.nypix = FIX(words[0])
              3: info.nypix = FIX(words)
              ELSE: MESSAGE, "'nypix' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "crvalx": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.crvalx = FLOAT(words[0])
              3: info.crvalx = FLOAT(words)
              ELSE: MESSAGE, "'crvalx' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "crvaly": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.crvaly = FLOAT(words[0])
              3: info.crvaly = FLOAT(words)
              ELSE: MESSAGE, "'crvaly' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "crpixx": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.crpixx = FLOAT(words[0])
              3: info.crpixx = FLOAT(words)
              ELSE: MESSAGE, "'crpixx' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "crpixy": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           CASE N_ELEMENTS(words) OF
              1: info.crpixy = FLOAT(words[0])
              3: info.crpixy = FLOAT(words)
              ELSE: MESSAGE, "'crpixy' on line " + STRTRIM(linenum, 2) + $
                             " in conf file '" + conffile + $
                             "' must have 1 or 3 elements"
           ENDCASE
        END
        "badscan": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           IF N_ELEMENTS( words ) LT 3 THEN $
              MESSAGE,"Couldn't parse badscan info: "+ line
           IF ~ PTR_VALID(info.badobsid) THEN BEGIN
              ;; initialize list
              info.badobsid = PTR_NEW([PTR_NEW(words)])
           ENDIF ELSE BEGIN
              ;; append to list
              temp = *info.badobsid
              PTR_FREE, info.badobsid
              info.badobsid = PTR_NEW([temp, PTR_NEW(words)])
           ENDELSE
        END
        "badbolos": BEGIN
           IF ~ PTR_VALID(info.badbolos) THEN BEGIN
              ;; initialize list
              words = STRSPLIT(val, " ", /EXT)
              info.badbolos = PTR_NEW([words])
           ENDIF ELSE BEGIN
              ;; append to list
              temp = *info.badbolos
              PTR_FREE, info.badbolos
              words = STRSPLIT(val, " ", /EXT)
              info.badbolos = PTR_NEW([temp, words])
           ENDELSE
        END
        "nomask": BEGIN
           IF ~ PTR_VALID(info.nomask) THEN BEGIN
              ;; initialize list
              info.nomask = PTR_NEW([val])
           ENDIF ELSE BEGIN
              ;; append to list
              temp = *info.nomask
              PTR_FREE, info.nomask
              info.nomask = PTR_NEW([[temp], [val]])
           ENDELSE
        END
        "todmask": BEGIN
           words = STRSPLIT(val, " ", /EXT)
           IF ~ PTR_VALID(info.todmask) THEN BEGIN
              ;; initialize list
              info.todmask = PTR_NEW([PTR_NEW(words)])
            ENDIF ELSE BEGIN
              ;; append to list
               temp = *info.todmask
               PTR_FREE, info.todmask
               info.todmask = PTR_NEW([temp, PTR_NEW(words)])
           ENDELSE
        END
        "datadirbase":  info.datadirbase  = val
        "dataname":     info.dataname     = val
        "dataversion":  info.dataversion  = val
        "do_ptrs":      info.do_ptrs      = FIX(val)
        "do_oneband":   info.do_oneband   = FIX(val)
        "do_tdc":       info.do_tdc       = FIX(val)
        "no_medfilt":   info.no_medfilt   = FIX(val)
        "todmean" :     info.todmean      = FIX(val)
        "astromname":   info.astromname   = val
        "noastrom":     info.noastrom     = FIX(val)
        "lin_basetime": info.lin_basetime = val
        "lin_ra_slope": info.lin_ra_slope = val
        "lin_dec_slope":info.lin_dec_slope= val
        "do_jkbolo":    info.do_jkbolo    = FIX(val)
        "do_aormaps":   info.do_aormaps   = FIX(val)
        "do_matched":   info.do_matched   = FIX(val)
        "do_redsource": info.do_redsource = FIX(val)
        "red_brute":    info.red_brute = FIX(val)
        "niter":        info.niter        = FIX(val)
        "first_offs":   info.first_offs   = FIX(val)
        "first_gain":   info.first_gain   = FIX(val)
        "first_wt":     info.first_wt     = FIX(val)
        "first_clip":   info.first_clip   = FIX(val)
        "grow_clip" :   info.grow_clip    = FIX(val)
        "clipsigma" :   info.clipsigma    = FLOAT(val)
        "fixed_nt":     info.fixed_nt     = FIX(val)
        "nterms":       info.nterms       = FIX(val)
        "nt_scale":     info.nt_scale     = FLOAT(val)
        "min_exposure": info.min_exposure = FIX(val)
        "shortname":    info.shortname    = val
        "exname":       info.exname       = val
        "exapp":        info.exapp        = val
        "iterdiag":     info.iterdiag     = FIX(val)
        "no250":        info.no250        = FIX(val)
        "no350":        info.no350        = FIX(val)
        "no500":        info.no500        = FIX(val)
        "nolatlon":     info.nolatlon     = FIX(val)
        "speedcut":     info.speedcut     = FLOAT(val)
        "fixeddir":     info.fixeddir     = val
        "fixedname":    info.fixedname    = val
        "fixeddate":    info.fixeddate    = val
        "do_fixeddeglitch": info.do_fixeddeglitch = FIX(val)
        "allowedobsids": info.allowedobsids= val
        "store_pixinfo": info.store_pixinfo = val
        "projtype":     info.projtype     = val
        ELSE: BEGIN
           MESSAGE, "Unknown keyword '" + key + "' on line " + $
                    STRTRIM(linenum, 2) + " in conf file '" + $
                    conffile
        END
     ENDCASE

     linenum++
  ENDWHILE

; close file
  FREE_LUN, lun

  RETURN, info

END
