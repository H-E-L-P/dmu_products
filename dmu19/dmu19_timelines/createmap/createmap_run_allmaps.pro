;+
; CREATEMAP_RUN_ALLMAPS, /ONE, /TWO, /THREE, /FOUR, /FIVE, $
;                        /NEST, /FILTER, /REDMAPS, DATE=date, $
;                        FIELDLIST=fieldlist
;
; Create final maps. Uses conf files found in
; 
;    conffiles/
;
; Options ONE, TWO, THREE, FOUR , FIVE are for divided up the fields into 
; batches, for processing on multiple nodes. If none are set, all segments 
; are run.  Note you can set more than one.
;
; If either /NEST or /FILTER is set, will run nested or filtered maps 
; instead of regular set of maps. Setting both is an error.
;
; Optional input FIELDLIST allows specifying 1 or more fields to process,
; instead of running on all fields. Fields passed as scalar string or list 
; of strings. If set, /ONE, /TWO, etc are ignored.
;
; CREATED BY gmarsden@phas.ubc.ca 2011-03-01
;            based on createmap_run_aormaps.pro
;
; CHANGELOG
;   20110325 (GM) add cdfs-sw and elais-n2, put cdfs in separate group
;   20110428 (GM) add DATE keyword to override today's date
;   20110706 (GM) add /NEST and /FILTER keywords
;   20120315 (GM) add FIELDLIST keyword
;-

PRO CREATEMAP_RUN_ALLMAPS, ONE=one, TWO=two, THREE=three, FOUR=four, $
                           FIVE=five, NEST=donest, FILTER=dofilter, DATE=date,$
                           REDMAPS=redmaps, FIELDLIST=fieldlist

  nseg = 5

  confdir = "conffiles"         ; relative to createmap dir
  outdir = "/data/spire/maps"   ; output directory
  current_link = "current"      ; create symbolic link to most recent version

; which set of maps do we do?
; 0 -> regular maps
; 1 -> nest maps
; 2 -> filter maps
; 3 -> red maps
  mapset = 0
  IF KEYWORD_SET(donest) THEN mapset = 1
  IF KEYWORD_SET(dofilter) THEN mapset = 2
  IF KEYWORD_SET(redmaps) THEN mapset = 3

  IF KEYWORD_SET(donest) AND KEYWORD_SET(dofilter) THEN $
     MESSAGE, "cannon run with /NEST *and* /FILTER set"

; fields with segment in which to process
  CASE mapset OF
     0: BEGIN
        ;;These are roughly size balanced, so that each subset
        ;; takes about the same disk space (level1)
        ;; on the theory that the processing time should be
        ;; roughly proportional to that value.  This particular
        ;; ordering gets the ntL1g fields to balance to within 71MB
        ;;note that elais-n2-swire2 is not present; although it
        ;; constitutes an AOR set, the actual map is never made
        ;; independently of elais-n2

        fields = [ $
                 {f: "abell0370",        s: 1},$
                 {f: "abell1689",        s: 0},$
                 {f: "abell1835",        s: 0},$
                 {f: "abell2218",        s: 4},$
                 {f: "abell2219",        s: 1},$
                 {f: "abell2390",        s: 3},$
                 {f: "adfs",             s: 1},$
                 {f: "bootes",           s: 0},$
                 {f: "cdfs-swire",       s: 2},$
                 {f: "cdfs-swire3",      s: 1},$
                 {f: "cl0024",           s: 4},$
                 {f: "cosmos",           s: 0},$
                 {f: "cosmos2",          s: 4},$
                 {f: "ecdfs",            s: 2},$
                 {f: "egroth",           s: 4},$
                 {f: "egs-scuba",        s: 2},$
                 {f: "elais-n1",         s: 1},$
                 {f: "elais-n1-new-ivan",s: 3},$
                 {f: "elais-n2",         s: 4},$
                 {f: "elais-s1",         s: 3},$
                 {f: "fls",              s: 1},$
                 {f: "global-epicentre1",s: 3},$
                 {f: "goodsn",           s: 2},$
                 {f: "goodsn-gh",        s: 0},$
                 {f: "goodss",           s: 3},$
                 {f: "helms",            s: 4},$
                 {f: "helms-act",        s: 4},$
                 {f: "helms-act-direct", s: 4},$
                 {f: "lockman-east",     s: 2},$
                 {f: "lockman-north",    s: 4},$
                 {f: "lockman-swire",    s: 4},$
                 {f: "lockman-swire3",   s: 3},$
                 {f: "ms0451",           s: 0},$
                 {f: "ms1054",           s: 1},$
                 {f: "ms1358",           s: 0},$
                 {f: "rxj0152",          s: 1},$
                 {f: "rxj1347",          s: 0},$
                 {f: "s1-video",         s: 3},$
                 {f: "uds",              s: 3},$
                 {f: "video-xmm1",       s: 2},$
                 {f: "video-xmm2",       s: 2},$
                 {f: "video-xmm3",       s: 4},$
                 {f: "vvds",             s: 0},$
                 {f: "xmm-lss",          s: 1} $
                 ]
     END
     1: BEGIN ;;Nest
        fields = [ $
                 {f: "cdfs-nest",      s: 0}, $
                 {f: "cosmos-nest",    s: 3}, $
                 {f: "egs-nest",       s: 1}, $
                 {f: "elais-n1-nest",  s: 0}, $
                 {f: "elais-s1-nest",  s: 1}, $
                 {f: "goodsn-nest",    s: 1}, $
                 {f: "lockman-nest",   s: 2}, $
                 {f: "xmm-nest",       s: 2}  $
                 ]
     END
     2: BEGIN ;;Filter
        fields = [ $
                 {f: "cosmos-filter",         s: 0}, $
                 {f: "egroth-filter",         s: 1}, $
                 {f: "goodsn-filter",         s: 1}, $
                 {f: "goodss-filter",         s: 3}, $
                 {f: "lockman-east-filter",   s: 0}, $
                 {f: "lockman-north-filter",  s: 2}, $
                 {f: "uds-filter",            s: 2}, $
                 {f: "vvds-filter",           s: 3} $
                 ]
     END
     3: BEGIN ;;redmaps
        fields = [$
                 {f: "adfs-redmap",            s: 0},$
                 {f: "bootes-redmap",          s: 0},$
                 {f: "egs-redmap",             s: 1},$
                 {f: "elais-n1-redmap",        s: 3},$
                 {f: "elais-n2-redmap",        s: 2},$
                 {f: "elais-s1-redmap",        s: 1},$
                 {f: "fls-redmap",             s: 2},$
                 {f: "goodsn-redmap",          s: 2},$
                 {f: "lockman-swire-redmap",   s: 3},$
                 {f: "xmm-lss-redmap",         s: 3} $
                 ]
     END
  ENDCASE

  ; using input fieldlist instead of above, if exists
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
  IF KEYWORD_SET(date) THEN BEGIN
     todaystr = date
  ENDIF ELSE BEGIN
     CALDAT, SYSTIME(/JUL), m, d, y
     todaystr = STRING([y,m,d], FORMAT="(I04,I02,I02)")
  ENDELSE

  outdir = ADDSLASH(outdir)

; loop over segments
  FOR iseg=0,nseg-1 DO BEGIN
     IF do_segment[iseg] EQ 0 THEN CONTINUE

     find = WHERE(fields.s EQ iseg, nf)
     IF nf EQ 0 THEN CONTINUE

                                ; loop over fields
     FOR i=0,nf-1 DO BEGIN

        fieldname = fields[find[i]].f
        confname = fieldname + ".conf"
        
        MESSAGE,"Doing field: "+fieldname,/INF

                                ; manage directory stuff
        !SMAP_MAPS = outdir + fieldname + "/" + todaystr + "/"
        FILE_MKDIR, !SMAP_MAPS

        current = outdir + fieldname + "/" + current_link

        IF FILE_TEST(current, /SYMLINK) OR $
           FILE_TEST(current, /DANGLING) THEN FILE_DELETE, current
        SPAWN, "ln -s " + !SMAP_MAPS + " " + current

        CREATE_ITERMAP_FROM_CONF, confdirfull + confname, DATE=todaystr
     ENDFOR
  ENDFOR


END
