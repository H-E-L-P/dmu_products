;+
; CREATEMAP_RUN_AORMAPS, /ONE, /TWO, /THREE, /FOUR, /FIVE, $
;                        FIELDLIST=fieldlist
;
; Create aor maps for measuring astrometry. Uses conf files found in
; 
;    conffiles/
;
; Options ONE, TWO, THREE, FOUR are for divided up the fields into batches,
; for processing on multiple nodes. If none are set, all segments are run.
;
; Optional input FIELDLIST allows specifying 1 or more fields to process,
; instead of running on all fields. Fields passed as scalar string or list 
; of strings.  If set, all other options are ignored.
;
; CREATED BY gmarsden@phas.ubc.ca 2011-02-24
;
; CHANGELOG:
;
;   2012-03-15 (gm): add FIELDLIST keyword
;-

PRO CREATEMAP_RUN_AORMAPS, ONE=one, TWO=two, THREE=three, FOUR=four,$
                           FIVE=five, FIELDLIST=fieldlist
  COMPILE_OPT IDL2, STRICTARRSUBS

  nseg = 5

  confdir = "conffiles"         ; relative to createmap dir
  outdir = "/data/spire/aormaps" ; output directory

  ;; fields with segment in which to process
  ;; roughly size balanced so that each subset takes
  ;; the same disk space (for level 1)
  ;; same order as createmap_run_allmaps
  ;;
  ;; Note that helms and hers are (deliberately!) absent
  fields = [ $
           {f: "abell0370",        s: 1},$
           {f: "abell0370-2",      s: 1},$
           {f: "abell1689",        s: 0},$
           {f: "abell1835",        s: 0},$
           {f: "abell2218",        s: 4},$
           {f: "abell2219",        s: 1},$
           {f: "abell2390",        s: 3},$
           {f: "adfs",             s: 1},$
           {f: "bootes",           s: 0},$
           {f: "cdfs-swire",       s: 2},$
           {f: "cl0024",           s: 4},$
           {f: "cl0024-2",         s: 4},$
           {f: "cosmos",           s: 0},$
           {f: "cosmos2",          s: 4},$
           {f: "ecdfs",            s: 2},$
           {f: "egroth",           s: 4},$
           {f: "egs-maynov",       s: 2},$
           {f: "egs-scuba",        s: 2},$
           {f: "elais-n1",         s: 1},$
           {f: "elais-n1-new-ivan",s: 3},$
           {f: "elais-n2",         s: 4},$
           {f: "elais-n2-swire2",  s: 1},$
           {f: "elais-s1",         s: 3},$
           {f: "fls",              s: 1},$
           {f: "global-epicentre1",s: 3},$
           {f: "goodsn",           s: 2},$
           {f: "goodsn-gh",        s: 0},$
           {f: "goodss",           s: 3},$
           {f: "lockman-east",     s: 2},$
           {f: "lockman-north",    s: 4},$
           {f: "lockman-swire",    s: 4},$
           {f: "lockman-swire3",   s: 3},$
           {f: "lockman-new",      s: 3},$
           {f: "ms0451",           s: 0},$
           {f: "ms1054",           s: 2},$
           {f: "ms1358",           s: 0},$
           {f: "rxj0152",          s: 1},$
           {f: "rxj1347",          s: 0},$
           {f: "rxj1347-2",        s: 0},$
           {f: "sa13",             s: 0},$
           {f: "s1-video",         s: 3},$
           {f: "uds",              s: 3},$
           {f: "video-xmm1",       s: 2},$
           {f: "video-xmm2",       s: 2},$
           {f: "video-xmm3",       s: 4},$
           {f: "vvds",             s: 0},$
           {f: "xmm-lss",          s: 1},$
           {f: "xmm13hr",          s: 1} $
           ]

  ;; using input fieldlist instead of above, if exists
  IF N_ELEMENTS(fieldlist) GT 0 THEN BEGIN
      IF SIZE(fieldlist, /TYPE) NE 7 THEN $
         MESSAGE, "input keyword FIELDLIST must be string type"
      nf = N_ELEMENTS(fieldlist)
      fields = REPLICATE({f:"", s:0}, nf)
      fields.f = fieldlist
  ENDIF

; find createmap dir (find create_itermap.pro)
  temppath = FILE_WHICH("create_itermap.pro")

; remove filename from temppath
  FDECOMP, temppath, temp, createmap_dir

; turn off all segments to begin
  do_segment = BYTARR(nseg)

  IF KEYWORD_SET(one)   THEN do_segment[0] = 1B
  IF KEYWORD_SET(two)   THEN do_segment[1] = 1B
  IF KEYWORD_SET(three) THEN do_segment[2] = 1B
  IF KEYWORD_SET(four)  THEN do_segment[3] = 1B
  IF KEYWORD_SET(five)  THEN do_segment[4] = 1B

; if none turned on, do all
  IF TOTAL(do_segment) EQ 0 THEN do_segment = REPLICATE(1B, nseg)

  ; if using fieldlists, ignore segment settings and do all 
  IF N_ELEMENTS(fieldlist) GT 0 THEN do_segment[0] = 1B

  confdirfull = ADDSLASH(createmap_dir) + ADDSLASH(confdir)

; date for output directory
  CALDAT, SYSTIME(/JUL), m, d, y
  todaystr = STRING([y,m,d], FORMAT="(I04,I02,I02)")

  outdir = ADDSLASH(outdir)

; loop over segments
  FOR iseg=0,nseg-1 DO BEGIN
     IF do_segment[iseg] EQ 0 THEN CONTINUE

     find = WHERE(fields.s EQ iseg, nf)
     IF nf EQ 0 THEN CONTINUE

                                ; loop over fields
     FOR i=0,nf-1 DO BEGIN

        fieldname = fields[find[i]].f
        confname = fieldname + "-aor.conf"
        
        ;; manage directory stuff
        !SMAP_MAPS = outdir + todaystr + "/" + fieldname + "/"
        FILE_MKDIR, !SMAP_MAPS

        CREATE_ITERMAP_FROM_CONF, confdirfull + confname, DATE=todaystr
     ENDFOR
  ENDFOR


END
