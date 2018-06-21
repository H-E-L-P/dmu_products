;***********************************************************************

PRO my_idl_startup_pro

;+
; NAME:
;	my_idl_startup_pro
;
; PURPOSE:
;	
;       defines some commands to be run in IDL setup
;       very basic template.
;       user can have their own version of this routine
;       in their IDL_PATH and personalise it
;        
;
; CATEGORY:
;	utitlies
;
; CALLING SEQUENCE:
;	my_idl_startup_pro
;
; INPUTS:
;	NONE
;
; OPTIONAL INPUTS:
;	NONE
;	
; KEYWORD PARAMETERS:
;	NONE
;
; OUTPUTS:
;	NONE
;
; OPTIONAL OUTPUTS:
;	NONE
;
; COMMON BLOCKS:
;	NONE
;
; SIDE EFFECTS:
;	set-up system variables
;
; RESTRICTIONS:
;	should be run from startup file
;
; PROCEDURE:
;	
;
; EXAMPLE:
;	
;
; MODIFICATION HISTORY:
; 	Written by:	Seb Oliver 28th Oct 1997
;	July, 1996	
;-


;setup astrolib system variables

astrolib

; increase history buffer for command recall

!EDIT_INPUT=100


;colours


; device, decomposed=0 



END

