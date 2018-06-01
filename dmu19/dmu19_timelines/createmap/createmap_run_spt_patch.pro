;+
; CREATEMAP_RUN_HERS, DATE=date
;
; Version of CREATEMAP_RUN_ALLMAPS for HERS data set
; 
; CREATED BY gmarsden@phas.ubc.ca 2012-09-27
;            based on createmap_run_allmaps.pro
;
;-

PRO CREATEMAP_RUN_SPT_PATCH, DATE=date, FIELDLIST=fieldlist

  confdir = "conffiles"         ; relative to createmap dir
  outdir = "/data/viero/sptspire/maps" ; output directory
  current_link = "current"      ; create symbolic link to most recent version

  psuf=''
  psuf='zea-'
  xsuf='30'
  fields = ['spt-'+psuf+xsuf+'p0', $
	    'spt-'+psuf+xsuf+'p1', $
	    'spt-'+psuf+xsuf+'p2', $
	    'spt-'+psuf+xsuf+'p3', $
	    'spt-'+psuf+xsuf+'p4', $
	    'spt-'+psuf+xsuf+'p5', $
	    'spt-'+psuf+xsuf+'p6', $
	    'spt-'+psuf+xsuf+'p7', $
            'spt-'+psuf+xsuf+'p8']

  ; using input fieldlist instead of above, if exists
  IF N_ELEMENTS(fieldlist) GT 0 THEN BEGIN
      IF SIZE(fieldlist, /TYPE) NE 7 THEN $
         MESSAGE, "input keyword FIELDLIST must be string type"
      fields = fieldlist
  ENDIF


; find createmap dir (find create_itermap.pro)
  temppath = FILE_WHICH("create_itermap.pro")

; remove filename from temppath
  FDECOMP, temppath, temp, createmap_dir

  confdirfull = ADDSLASH(createmap_dir) + ADDSLASH(confdir)

; date for output directory
  IF KEYWORD_SET(date) THEN BEGIN
     todaystr = date
  ENDIF ELSE BEGIN
     CALDAT, SYSTIME(/JUL), m, d, y
     todaystr = STRING([y,m,d], FORMAT="(I04,I02,I02)")
  ENDELSE

  outdir = ADDSLASH(outdir)

  FOR i=0,N_ELEMENTS(fields)-1 DO BEGIN

      fieldname = fields[i]
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

END
