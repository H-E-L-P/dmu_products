;***********************************************************************

PRO COLOURS,cmax

;+
; NAME:
;	COLOURS
;
; PURPOSE:
;	Sets up a few colours into low numbers on the LUT for use in
;       graphs.
;       Resulting colors
;       0:    Black
;       1:    White
;       2:    Red
;       3:    Blinding Bright Green
;       4:    Blue
;       5:    Lemon Yellow
;       6:    Blinding Bright Blue
;       7:    Bright Horrible Magenta
;       8:    Sun Yellow
;       9:    Baby Pink
;      10:    Magenta
;      11:    Pretty Sky Blue
;      12:    Moss Green
;
; CATEGORY:
;	graphics
;
; CALLING SEQUENCE:
;	colours
;
; INPUTS:
;	
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
;	Alters LUT
;
; RESTRICTIONS:
;	
;
; PROCEDURE:
;	
;
; EXAMPLE:
;	colours
;
; MODIFICATION HISTORY:
; 	Written by:	Seb Oliver June 1996
;-
; color set up


 common colors,r_orig,g_orig,b_orig,r_cur,g_cur,b_cur

 on_error,2

; if a lookup table is not set load the black and white one
 if n_elements(r_orig) eq 0 then loadct,0


 if n_params() eq 0 then cmax=13

 red=  [  0B,255B,255B,  0B,  0B,255B,  0B,255B,255B,255B,150B, 70B, 0B]
 green=[  0B,255B,  0B,255B,  0B,255B,255B,  0B,204B,204B,  0B, 160B, 150B]
 blue= [  0B,255B,  0B,  0B,255B,  0B,255B,255B, 51B,224B, 80B, 200B, 0B]

; setting current to have colours as first cmax elements
 r_cur=[red(0:cmax-1),r_orig(cmax:*)]
 g_cur=[green(0:cmax-1),g_orig(cmax:*)]
 b_cur=[blue(0:cmax-1),b_orig(cmax:*)]
 
;----------------------------------------------------------------------
; adding in some of David Fanning's colours
;----------------------------------------------------------------------


 tvlct,r_cur,g_cur,b_cur
FOR i=2, cmax DO BEGIN 
CASE i OF 
2: tmp = fsc_color('Crimson', 2) 
3: tmp = fsc_color('Forest Green', 3)
4: tmp = fsc_color('Navy', 4)
5: tmp = fsc_color('Goldenrod', 5)
6: tmp = fsc_color('Dodger Blue', 6)
7: tmp = fsc_color('Orchid', 7)
8: tmp = fsc_color('Chocolate', 8)
9: tmp = fsc_color('Deep Pink', 9)
10: tmp = fsc_color('Dark Green', 10)
11: tmp = fsc_color('Dark Orchid', 11)
12: tmp = fsc_color('Dark Red', 12)
13: tmp = fsc_color('Steel Blue', 13)
14: tmp = fsc_color('Teal', 14)
15: tmp = fsc_color('Salmon', 15)
16: tmp = fsc_color('Dark Gray', 16)
ELSE: message, 'cmax out of range'
ENDCASE 

ENDFOR 
;stop

; setting original to current No I don't understand this
; either but it is the IDL standard way of doing things

 r_orig=r_cur 
 g_orig=g_cur 
 b_orig=b_cur 

END

