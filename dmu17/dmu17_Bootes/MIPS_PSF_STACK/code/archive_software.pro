;***********************************************************************

PRO archive_software, soft_dir

;+
; NAME:
;	archive_software
;
; PURPOSE:
;	archives all the source code for the currently compiled software into a directory
;
; CATEGORY:
;	pipeline
;
; CALLING SEQUENCE:
;	archive_software[, soft_dir]
;
; INPUTS:
;	soft_dir: name of directory to archive the software to
;                 (Default current)
;
; OPTIONAL INPUTS:
;	
;	
; KEYWORD PARAMETERS:
;	
;
; OUTPUTS:
;	
;
; OPTIONAL OUTPUTS:
;	
;
; COMMON BLOCKS:
;	
;
; SIDE EFFECTS:
;	creates a script and executes its copying files into a subdirectory
;
; RESTRICTIONS:
;	Describe any "restrictions" here.
;
; PROCEDURE:
;	You can describe the foobar superfloatation method being used here.
;
; EXAMPLE:
;	Please provide a simple example here.
;
; MODIFICATION HISTORY:
; 	Written by:	Seb Oliver 23rd June 1999
;	July, 1994	Any additional mods get described here. VERSION 1.0
;-

IF n_params() EQ 0 THEN soft_dir = '.'

help, /source, output=help_out
get_lun, unit
openw, unit, soft_dir+'/soft_archive.csh'
help_out = strcompress(help_out)
FOR i=0, n_elements(help_out)-1 DO BEGIN 

   split = str_sep(help_out[i], ' ')
   FOR j=0, n_elements(split)-1 DO BEGIN
      IF strmid(split[j], 0, 1) EQ '/' THEN printf, unit, 'cp '+split[j]+' '+soft_dir
   ENDFOR


ENDFOR

free_lun, unit

spawn, 'source '+soft_dir+'/soft_archive.csh'

END
