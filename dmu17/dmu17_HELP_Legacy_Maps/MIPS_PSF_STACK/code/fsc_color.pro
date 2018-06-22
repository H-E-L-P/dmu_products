;+
; NAME:
;       FSC_COLOR
;
; PURPOSE:
;
;       The purpose of this function is to obtain drawing colors
;       by name and in a device/decomposition independent way.
;       The color names and values may be read in as a file, or 104 color
;       names and values are supplied with the program. These colors were
;       obtained from the file rgb.txt, found on most X-Window distributions.
;       Representative colors were chosen from across the color spectrum. To
;       see a list of colors available, type:
;
;          Print, FSC_Color(/Names), Format='(6A18)'.
;
; AUTHOR:
;
;       FANNING SOFTWARE CONSULTING:
;       David Fanning, Ph.D.
;       1645 Sheely Drive
;       Fort Collins, CO 80526 USA
;       Phone: 970-221-0438
;       E-mail: davidf@dfanning.com
;       Coyote's Guide to IDL Programming: http://www.dfanning.com
;
; CATEGORY:
;
;       Graphics, Color Specification.
;
; CALLING SEQUENCE:
;
;       color = FSC_Color(theColor, theColorIndex)
;
; NORMAL CALLING SEQUENCE FOR DEVICE-INDEPENDENT COLOR:
;
;       If you write your graphics code *exactly* as it is written below, then
;       the same code will work in all graphics devices I have tested.
;       These include the PRINTER, PS, and Z devices, as well as X, WIN, and MAC.
;
;       In practice, graphics code is seldom written like this. (For a variety of
;       reasons, but laziness is high on the list.) So I have made the
;       program reasonably tolerant of poor programming practices. I just
;       point this out as a place you might return to before you write me
;       a nice note saying my program "doesn't work". :-)
;
;       axisColor = FSC_Color("Green", !D.Table_Size-2)
;       backColor = FSC_Color("Charcoal", !D.Table_Size-3)
;       dataColor = FSC_Color("Yellow", !D.Table_Size-4)
;       thisDevice = !D.Name
;       Set_Plot, 'toWhateverYourDeviceIsGoingToBe', /Copy
;       Device, .... ; Whatever you need here to set things up properly.
;       IF (!D.Flags AND 256) EQ 0 THEN $
;         POLYFILL, [0,1,1,0,0], [0,0,1,1,0], /Normal, Color=backColor
;       Plot, Findgen(11), Color=axisColor, Background=backColor, /NoData, $
;          NoErase= ((!D.Flags AND 256) EQ 0)
;       OPlot, Findgen(11), Color=dataColor
;       Device, .... ; Whatever you need here to wrap things up properly.
;       Set_Plot, thisDevice
;
; OPTIONAL INPUT PARAMETERS:
;
;       theColor: A string with the "name" of the color. To see a list
;           of the color names available set the NAMES keyword. This may
;           also be a vector of color names. Colors available are these:
;
;           Active            Almond     Antique White        Aquamarine             Beige            Bisque
;             Black              Blue       Blue Violet             Brown         Burlywood        Cadet Blue
;          Charcoal        Chartreuse         Chocolate             Coral   Cornflower Blue          Cornsilk
;           Crimson              Cyan    Dark Goldenrod         Dark Gray        Dark Green        Dark Khaki
;       Dark Orchid          Dark Red       Dark Salmon   Dark Slate Blue         Deep Pink       Dodger Blue
;              Edge              Face         Firebrick      Forest Green             Frame              Gold
;         Goldenrod              Gray             Green      Green Yellow         Highlight          Honeydew
;          Hot Pink        Indian Red             Ivory             Khaki          Lavender        Lawn Green
;       Light Coral        Light Cyan        Light Gray      Light Salmon   Light Sea Green      Light Yellow
;        Lime Green             Linen           Magenta            Maroon       Medium Gray     Medium Orchid
;          Moccasin              Navy             Olive        Olive Drab            Orange        Orange Red
;            Orchid    Pale Goldenrod        Pale Green            Papaya              Peru              Pink
;              Plum       Powder Blue            Purple               Red              Rose        Rosy Brown
;        Royal Blue      Saddle Brown            Salmon       Sandy Brown         Sea Green          Seashell
;          Selected            Shadow            Sienna          Sky Blue        Slate Blue        Slate Gray
;              Snow      Spring Green        Steel Blue               Tan              Teal              Text
;           Thistle            Tomato         Turquoise            Violet        Violet Red             Wheat
;             White            Yellow
;
;           The color WHITE is used if this parameter is absent or a color name is mis-spelled. To see a list
;           of the color names available in the program, type this:
;
;              Print, FSC_Color(/Names), Format='(6A18)'
;
;       theColorIndex: The color table index (or vector of indices the same length
;           as the color name vector) where the specified color is loaded. The color table
;           index parameter should always be used if you wish to obtain a color value in a
;           color-decomposition-independent way in your code. See the NORMAL CALLING
;           SEQUENCE for details. If theColor is a vector, and theColorIndex is a scalar,
;           then the colors will be loaded starting at theColorIndex.
;
; RETURN VALUE:
;
;       The value that is returned by FSC_Color depends upon the keywords
;       used to call it, on the version of IDL you are using,and on the depth
;       of the display device when the program is invoked. In general,
;       the return value will be either a color index number where the specified
;       color is loaded by the program, or a 24-bit color value that can be
;       decomposed into the specified color on true-color systems. (Or a vector
;       of such numbers.)
;
;       If you are running IDL 5.2 or higher, the program will determine which
;       return value to use, based on the color decomposition state at the time
;       the program is called. If you are running a version of IDL before IDL 5.2,
;       then the program will return the color index number. This behavior can
;       be overruled in all versions of IDL by setting the DECOMPOSED keyword.
;       If this keyword is 0, the program always returns a color index number. If
;       the keyword is 1, the program always returns a 24-bit color value.
;
;       If the TRIPLE keyword is set, the program always returns the color triple,
;       no matter what the current decomposition state or the value of the DECOMPOSED
;       keyword. Normally, the color triple is returned as a 1 by 3 column vector.
;       This is appropriate for loading into a color index with TVLCT:
;
;          IDL> TVLCT, FSC_Color('Yellow', /Triple), !P.Color
;
;       But sometimes (e.g, in object graphics applications) you want the color
;       returned as a row vector. In this case, you should set the ROW keyword
;       as well as the TRIPLE keyword:
;
;          viewobj= Obj_New('IDLgrView', Color=FSC_Color('charcoal', /Triple, /Row))
;
;       If the ALLCOLORS keyword is used, then instead of a single value, modified
;       as described above, then all the color values are returned in an array. In
;       other words, the return value will be either an NCOLORS-element vector of color
;       table index numbers, an NCOLORS-element vector of 24-bit color values, or
;       an NCOLORS-by-3 array of color triples.
;
;       If the NAMES keyword is set, the program returns a vector of
;       color names known to the program.
;
;       If the color index parameter is not used, and a 24-bit value is not being
;       returned, then colorIndex is typically set to !D.Table_Size-1. However,
;       this behavior is changed on 8-bit devices (e.g., the PostScript device,
;       or the Z-graphics buffer) and on 24-bit devices that are *not* using
;       decomposed color. On these devices, the colors are loaded at an
;       offset of !D.Table_Size - ncolors - 2, and the color index parameter reflects
;       the actual index of the color where it will be loaded. This makes it possible
;       to use a formulation as below:
;
;          Plot, data, Color=FSC_Color('Dodger Blue')
;
;       on 24-bit displays *and* in PostScript output! Note that if you specify a color
;       index (the safest thing to do), then it will always be honored.
;
; INPUT KEYWORD PARAMETERS:
;
;       ALLCOLORS: Set this keyword to return indices, or 24-bit values, or color
;              triples, for all the known colors, instead of for a single color.
;
;       DECOMPOSED: Set this keyword to 0 or 1 to force the return value to be
;              a color table index or a 24-bit color value, respectively.
;
;       FILENAME: The string name of an ASCII file that can be opened to read in
;              color values and color names. There should be one color per row
;              in the file. Please be sure there are no blank lines in the file.
;              The format of each row should be:
;
;                  redValue  greenValue  blueValue  colorName
;
;              Color values should be between 0 and 255. Any kind of white-space
;              separation (blank characters, commas, or tabs) are allowed. The color
;              name should be a string, but it should NOT be in quotes. A typical
;              entry into the file would look like this:
;
;                  255   255   0   Yellow
;
;       NAMES: If this keyword is set, the return value of the function is
;              a ncolors-element string array containing the names of the colors.
;              These names would be appropriate, for example, in building
;              a list widget with the names of the colors. If the NAMES
;              keyword is set, the COLOR and INDEX parameters are ignored.
;
;                 listID = Widget_List(baseID, Value=GetColor(/Names), YSize=16)
;
;       ROW:   If this keyword is set, the return value of the function when the TRIPLE
;              keyword is set is returned as a row vector, rather than as the default
;              column vector. This is required, for example, when you are trying to
;              use the return value to set the color for object graphics objects. This
;              keyword is completely ignored, except when used in combination with the
;              TRIPLE keyword.
;
;       SELECTCOLOR: Set this keyword if you would like to select the color name with
;              the PICKCOLORNAME program. Selecting this keyword automaticallys sets
;              the INDEX positional parameter. If this keyword is used, any keywords
;              appropriate for PICKCOLORNAME can also be used. If this keyword is used,
;              the first positional parameter can be either a color name or the color
;              table index number. The program will figure out what you want.
;
;       TRIPLE: Setting this keyword will force the return value of the function to
;              *always* be a color triple, regardless of color decomposition state or
;              visual depth of the machine. The value will be a three-element column
;              vector unless the ROW keyword is also set.
;
;       In addition, any keyword parameter appropriate for PICKCOLORNAME can be used.
;       These include BOTTOM, COLUMNS, GROUP_LEADER, INDEX, and TITLE.
;
; OUTPUT KEYWORD PARAMETERS:
;
;       CANCEL: This keyword is always set to 0, unless that SELECTCOLOR keyword is used.
;              Then it will correspond to the value of the CANCEL output keyword in PICKCOLORNAME.
;
;       COLORSTRUCTURE: This output keyword (if set to a named variable) will return a
;              structure in which the fields will be the known color names (without spaces)
;              and the values of the fields will be either color table index numbers or
;              24-bit color values. If you have specified a vector of color names, then
;              this will be a structure containing just those color names as fields.
;
;       NCOLORS: The number of colors recognized by the program. It will be 104 by default.
;
; COMMON BLOCKS:
;       None.
;
; SIDE EFFECTS:
;       None.
;
; RESTRICTIONS:
;
;   Required programs from the Coyote Library:
;
;      http://www.dfanning.com/programs/error_message.pro
;      http://www.dfanning.com/programs/pickcolorname.pro
;
; EXAMPLE:
;
;       To get drawing colors in a device-decomposed independent way:
;
;           axisColor = FSC_Color("Green", !D.Table_Size-2)
;           backColor = FSC_Color("Charcoal", !D.Table_Size-3)
;           dataColor = FSC_Color("Yellow", !D.Table_Size-4)
;           Plot, Findgen(11), Color=axisColor, Background=backColor, /NoData
;           OPlot, Findgen(11), Color=dataColor
;
;       To set the viewport color in object graphics:
;
;           theView = Obj_New('IDLgrView', Color=FSC_Color('Charcoal', /Triple))
;
;       To change the viewport color later:
;
;           theView->SetProperty, Color=FSC_Color('Antique White', /Triple)
;
;       To load the drawing colors "red", "green", and "yellow" at indices 100-102, type this:
;
;           IDL> TVLCT, FSC_Color(["red", "green", and "yellow"], /Triple), 100
;
; MODIFICATION HISTORY:
;
;       Written by: David W. Fanning, 19 October 2000. Based on previous
;          GetColor program.
;       Fixed a problem with loading colors with TVLCT on a PRINTER device. 13 Mar 2001. DWF.
;       Added the ROW keyword. 30 March 2001. DWF.
;       Added the PICKCOLORNAME code to the file, since I keep forgetting to
;          give it to people. 15 August 2001. DWF.
;       Added ability to specify color names and indices as vectors. 5 Nov 2002. DWF.
;       Fixed a problem with the TRIPLE keyword when specifying a vector of color names. 14 Feb 2003. DWF.
;       Fixed a small problem with the starting index when specifying ALLCOLORS. 24 March 2003. DWF.
;       Added system color names. 23 Jan 2004. DWF
;       Added work-around for WHERE function "feature" when theColor is a one-element array. 22 July 2004. DWF.
;       Added support for 8-bit graphics devices when color index is not specified. 25 August 2004. DWF.
;       Fixed a small problem with creating color structure when ALLCOLORS keyword is set. 26 August 2004. DWF.
;       Extended the color index fix for 8-bit graphics devices on 25 August 2004 to
;         24-bit devices running with color decomposition OFF. I've concluded most of
;         the people using IDL don't have any idea how color works, so I am trying to
;         make it VERY simple, and yet still maintain the power of this program. So now,
;         in general, for most simple plots, you don't have to use the colorindex parameter
;         and you still have a very good chance of getting what you expect in a device-independent
;         manner. Of course, it would be *nice* if you could use that 24-bit display you paid
;         all that money for, but I understand your reluctance. :-)   11 October 2004. DWF.
;       Have renamed the first positional parameter so that this variable doesn't change
;         while the program is running. 7 December 2004. DWF.
;       Fixed an error I introduced on 7 December 2004. Sigh... 7 January 2005. DWF.
;       Added eight new colors. Total now of 104 colors. 11 August 2005. DWF.
;       Modified GUI to display system colors and removed PickColorName code. 13 Dec 2005. DWF.
;       Fixed a problem with colorIndex when SELECTCOLOR keyword was used. 13 Dec 2005. DWF.
;       Fixed a problem with color name synonyms. 19 May 2006. DWF.
;       The previous fix broke the ability to specify several colors at once. Fixed. 24 July 2006. DWF.
;       Updated program to work with 24-bit Z-buffer in IDL 6.4. 11 June 2007. DWF
;-
;
;###########################################################################
;
; LICENSE
;
; This software is OSI Certified Open Source Software.
; OSI Certified is a certification mark of the Open Source Initiative.
;
; Copyright � 2000-2007 Fanning Software Consulting.
;
; This software is provided "as-is", without any express or
; implied warranty. In no event will the authors be held liable
; for any damages arising from the use of this software.
;
; Permission is granted to anyone to use this software for any
; purpose, including commercial applications, and to alter it and
; redistribute it freely, subject to the following restrictions:
;
; 1. The origin of this software must not be misrepresented; you must
;    not claim you wrote the original software. If you use this software
;    in a product, an acknowledgment in the product documentation
;    would be appreciated, but is not required.
;
; 2. Altered source versions must be plainly marked as such, and must
;    not be misrepresented as being the original software.
;
; 3. This notice may not be removed or altered from any source distribution.
;
; For more information on Open Source Software, visit the Open Source
; web site: http://www.opensource.org.
;
;###########################################################################


FUNCTION FSC_Color_Count_Rows, filename, MaxRows = maxrows

; This utility routine is used to count the number of
; rows in an ASCII data file.

IF N_Elements(maxrows) EQ 0 THEN maxrows = 500L
IF N_Elements(filename) EQ 0 THEN BEGIN
   filename = Dialog_Pickfile()
   IF filename EQ "" THEN RETURN, -1
ENDIF

OpenR, lun, filename, /Get_Lun

Catch, theError
IF theError NE 0 THEN BEGIN
   Catch, /Cancel
   count = count-1
   Free_Lun, lun
   RETURN, count
ENDIF

RESTART:

count = 1L
line = ''
FOR j=count, maxrows DO BEGIN
   ReadF, lun, line
   count = count + 1

      ; Try again if you hit MAXROWS without encountering the
      ; end of the file. Double the MAXROWS parameter.

   IF j EQ maxrows THEN BEGIN
      maxrows = maxrows * 2
      Point_Lun, lun, 0
      GOTO, RESTART
   ENDIF

ENDFOR

RETURN, -1
END ;-------------------------------------------------------------------------------



FUNCTION FSC_Color_Color24, color

   ; This FUNCTION accepts a [red, green, blue] triple that
   ; describes a particular color and returns a 24-bit long
   ; integer that is equivalent to (can be decomposed into)
   ; that color. The triple can be either a row or column
   ; vector of 3 elements or it can be an N-by-3 array of
   ; color triples.

ON_ERROR, 2

s = Size(color)

IF s[0] EQ 1 THEN BEGIN
   IF s[1] NE 3 THEN Message, 'Input color parameter must be a 3-element vector.'
   RETURN, color[0] + (color[1] * 2L^8) + (color[2] * 2L^16)
ENDIF ELSE BEGIN
   IF s[2] GT 3 THEN Message, 'Input color parameter must be an N-by-3 array.'
   RETURN, color[*,0] + (color[*,1] * 2L^8) + (color[*,2] * 2L^16)
ENDELSE

END ;--------------------------------------------------------------------------------------------



FUNCTION FSC_Color, theColour, colorIndex, $
   AllColors=allcolors, $
   ColorStructure=colorStructure, $
   Cancel=cancelled, $
   Decomposed=decomposedState, $
   _Extra=extra, $
   Filename=filename, $
   Names=names, $
   NColors=ncolors, $
   Row=row, $
   SelectColor=selectcolor, $
   Triple=triple

   ; Error handling.

Catch, theError
IF theError NE 0 THEN BEGIN
   Catch, /Cancel
   ok = Error_Message(/Traceback)
   cancelled = 1
   RETURN, !P.Color
ENDIF

; I don't want to change the original variable.
IF N_Elements(theColour) NE 0 THEN theColor = theColour ELSE theColor = 'WHITE'

   ; Load the colors.

IF N_Elements(filename) NE 0 THEN BEGIN

      ; Count the number of rows in the file.

   ncolors = FSC_Color_Count_Rows(filename)

      ; Read the data.

   OpenR, lun, filename, /Get_Lun
   rvalue = BytArr(NCOLORS)
   gvalue = BytArr(NCOLORS)
   bvalue = BytArr(NCOLORS)
   colors = StrArr(NCOLORS)
   redvalue = 0B
   greenvalue = 0B
   bluevalue = 0B
   colorvalue = ""
   FOR j=0L, NCOLORS-1 DO BEGIN
      ReadF, lun, redvalue, greenvalue, bluevalue, colorvalue
      rvalue[j] = redvalue
      gvalue[j] = greenvalue
      bvalue[j] = bluevalue
      colors[j] = colorvalue
   ENDFOR
   Free_Lun, lun

      ; Trim the colors array of blank characters.

   colors = StrTrim(colors, 2)

ENDIF ELSE BEGIN

   ; Set up the color vectors.
   colors= ['White']
   rvalue = [ 255]
   gvalue = [ 255]
   bvalue = [ 255]
   colors = [ colors,   'Snow',     'Ivory','Light Yellow', 'Cornsilk',     'Beige',  'Seashell' ]
   rvalue = [ rvalue,     255,         255,       255,          255,          245,        255 ]
   gvalue = [ gvalue,     250,         255,       255,          248,          245,        245 ]
   bvalue = [ bvalue,     250,         240,       224,          220,          220,        238 ]
   colors = [ colors,   'Linen','Antique White','Papaya',     'Almond',     'Bisque',  'Moccasin' ]
   rvalue = [ rvalue,     250,        250,        255,          255,          255,          255 ]
   gvalue = [ gvalue,     240,        235,        239,          235,          228,          228 ]
   bvalue = [ bvalue,     230,        215,        213,          205,          196,          181 ]
   colors = [ colors,   'Wheat',  'Burlywood',    'Tan', 'Light Gray',   'Lavender','Medium Gray' ]
   rvalue = [ rvalue,     245,        222,          210,      230,          230,         210 ]
   gvalue = [ gvalue,     222,        184,          180,      230,          230,         210 ]
   bvalue = [ bvalue,     179,        135,          140,      230,          250,         210 ]
   colors = [ colors,  'Gray', 'Slate Gray',  'Dark Gray',  'Charcoal',   'Black',  'Honeydew', 'Light Cyan' ]
   rvalue = [ rvalue,      190,      112,          110,          70,         0,         240,          224 ]
   gvalue = [ gvalue,      190,      128,          110,          70,         0,         255,          255 ]
   bvalue = [ bvalue,      190,      144,          110,          70,         0,         255,          240 ]
   colors = [ colors,'Powder Blue',  'Sky Blue', 'Cornflower Blue', 'Cadet Blue', 'Steel Blue','Dodger Blue', 'Royal Blue',  'Blue' ]
   rvalue = [ rvalue,     176,          135,          100,              95,            70,           30,           65,            0 ]
   gvalue = [ gvalue,     224,          206,          149,             158,           130,          144,          105,            0 ]
   bvalue = [ bvalue,     230,          235,          237,             160,           180,          255,          225,          255 ]
   colors = [ colors,  'Navy', 'Pale Green','Aquamarine','Spring Green',  'Cyan' ]
   rvalue = [ rvalue,        0,     152,          127,          0,            0 ]
   gvalue = [ gvalue,        0,     251,          255,        250,          255 ]
   bvalue = [ bvalue,      128,     152,          212,        154,          255 ]
   colors = [ colors, 'Turquoise', 'Light Sea Green', 'Sea Green','Forest Green',  'Teal','Green Yellow','Chartreuse', 'Lawn Green' ]
   rvalue = [ rvalue,      64,          143,               46,          34,             0,      173,           127,         124 ]
   gvalue = [ gvalue,     224,          188,              139,         139,           128,      255,           255,         252 ]
   bvalue = [ bvalue,     208,          143,               87,          34,           128,       47,             0,           0 ]
   colors = [ colors, 'Green', 'Lime Green', 'Olive Drab',  'Olive','Dark Green','Pale Goldenrod']
   rvalue = [ rvalue,      0,        50,          107,        85,            0,          238 ]
   gvalue = [ gvalue,    255,       205,          142,       107,          100,          232 ]
   bvalue = [ bvalue,      0,        50,           35,        47,            0,          170 ]
   colors = [ colors,     'Khaki', 'Dark Khaki', 'Yellow',  'Gold', 'Goldenrod','Dark Goldenrod']
   rvalue = [ rvalue,        240,       189,        255,      255,      218,          184 ]
   gvalue = [ gvalue,        230,       183,        255,      215,      165,          134 ]
   bvalue = [ bvalue,        140,       107,          0,        0,       32,           11 ]
   colors = [ colors,'Saddle Brown',  'Rose',   'Pink', 'Rosy Brown','Sandy Brown', 'Peru']
   rvalue = [ rvalue,     139,          255,      255,        188,        244,        205 ]
   gvalue = [ gvalue,      69,          228,      192,        143,        164,        133 ]
   bvalue = [ bvalue,      19,          225,      203,        143,         96,         63 ]
   colors = [ colors,'Indian Red',  'Chocolate',  'Sienna','Dark Salmon',   'Salmon','Light Salmon' ]
   rvalue = [ rvalue,    205,          210,          160,        233,          250,       255 ]
   gvalue = [ gvalue,     92,          105,           82,        150,          128,       160 ]
   bvalue = [ bvalue,     92,           30,           45,        122,          114,       122 ]
   colors = [ colors,  'Orange',      'Coral', 'Light Coral',  'Firebrick', 'Dark Red', 'Brown',  'Hot Pink' ]
   rvalue = [ rvalue,       255,         255,        240,          178,        139,       165,        255 ]
   gvalue = [ gvalue,       165,         127,        128,           34,          0,        42,        105 ]
   bvalue = [ bvalue,         0,          80,        128,           34,          0,        42,        180 ]
   colors = [ colors, 'Deep Pink',    'Magenta',   'Tomato', 'Orange Red',   'Red', 'Crimson', 'Violet Red' ]
   rvalue = [ rvalue,      255,          255,        255,        255,          255,      220,        208 ]
   gvalue = [ gvalue,       20,            0,         99,         69,            0,       20,         32 ]
   bvalue = [ bvalue,      147,          255,         71,          0,            0,       60,        144 ]
   colors = [ colors,    'Maroon',    'Thistle',       'Plum',     'Violet',    'Orchid','Medium Orchid']
   rvalue = [ rvalue,       176,          216,          221,          238,         218,        186 ]
   gvalue = [ gvalue,        48,          191,          160,          130,         112,         85 ]
   bvalue = [ bvalue,        96,          216,          221,          238,         214,        211 ]
   colors = [ colors,'Dark Orchid','Blue Violet',  'Purple']
   rvalue = [ rvalue,      153,          138,       160]
   gvalue = [ gvalue,       50,           43,        32]
   bvalue = [ bvalue,      204,          226,       240]
   colors = [ colors, 'Slate Blue',  'Dark Slate Blue']
   rvalue = [ rvalue,      106,            72]
   gvalue = [ gvalue,       90,            61]
   bvalue = [ bvalue,      205,           139]

ENDELSE

   ; Add system color names for IDL version 5.6 and higher.

IF Float(!Version.Release) GE 5.6 THEN BEGIN

   tlb = Widget_Base()
   sc = Widget_Info(tlb, /System_Colors)
   Widget_Control, tlb, /Destroy
   frame = sc.window_frame
   text = sc.window_text
   active = sc.active_border
   shadow = sc.shadow_3d
   highlight = sc.light_3d
   edge = sc.light_edge_3d
   selected = sc.highlight
   face = sc.face_3d
   colors  = [colors,  'Frame',  'Text',  'Active',  'Shadow']
   rvalue =  [rvalue,   frame[0], text[0], active[0], shadow[0]]
   gvalue =  [gvalue,   frame[1], text[1], active[1], shadow[1]]
   bvalue =  [bvalue,   frame[2], text[2], active[2], shadow[2]]
   colors  = [colors,  'Highlight',  'Edge',  'Selected',  'Face']
   rvalue =  [rvalue,   highlight[0], edge[0], selected[0], face[0]]
   gvalue =  [gvalue,   highlight[1], edge[1], selected[1], face[1]]
   bvalue =  [bvalue,   highlight[2], edge[2], selected[2], face[2]]

ENDIF

   ; Make sure the color parameter and the colors array are an uppercase strings.

varInfo = Size(theColor)
IF varInfo[varInfo[0] + 1] NE 7 THEN $
   Message, 'The color name parameter must be a string.', /NoName
theColor = StrUpCase(StrCompress(StrTrim(theColor,2), /Remove_All))
colors = StrUpCase(StrCompress(StrTrim(colors,2), /Remove_All))

   ; Check synonyms of color names.
FOR j=0, N_Elements(theColor)-1 DO BEGIN
   IF StrUpCase(theColor[j]) EQ 'GREY' THEN theColor[j] = 'GRAY'
   IF StrUpCase(theColor[j]) EQ 'LIGHTGREY' THEN theColor[j] = 'LIGHTGRAY'
   IF StrUpCase(theColor[j]) EQ 'MEDIUMGREY' THEN theColor[j] = 'MEDIUMGRAY'
   IF StrUpCase(theColor[j]) EQ 'SLATEGREY' THEN theColor[j] = 'SLATEGRAY'
   IF StrUpCase(theColor[j]) EQ 'DARKGREY' THEN theColor[j] = 'DARKGRAY'
   IF StrUpCase(theColor[j]) EQ 'AQUA' THEN theColor[j] = 'AQUAMARINE'
   IF StrUpCase(theColor[j]) EQ 'SKY' THEN theColor[j] = 'SKYBLUE'
   IF StrUpCase(theColor[j]) EQ 'NAVYBLUE' THEN theColor[j] = 'NAVY'
   IF StrUpCase(theColor[j]) EQ 'CORNFLOWER' THEN theColor[j] = 'CORNFLOWERBLUE'
   IF StrUpCase(theColor[j]) EQ 'BROWN' THEN theColor[j] = 'SIENNA'
ENDFOR

   ; How many colors do we have?

ncolors = N_Elements(colors)

   ; Get the decomposed state of the IDL session right now.

IF N_Elements(decomposedState) EQ 0 THEN BEGIN
   IF Float(!Version.Release) GE 5.2 THEN BEGIN
      IF (!D.Name EQ 'X' OR !D.Name EQ 'WIN' OR !D.Name EQ 'MAC') THEN BEGIN
         Device, Get_Decomposed=decomposedState
      ENDIF ELSE decomposedState = 0
   ENDIF ELSE decomposedState = 0
   IF (Float(!Version.Release) GE 6.4) AND (!D.NAME EQ 'Z') THEN BEGIN
      Device, Get_Decomposed=decomposedState
   ENDIF
ENDIF ELSE decomposedState = Keyword_Set(decomposedState)

   ; Get depth of visual display.

IF (!D.Flags AND 256) NE 0 THEN Device, Get_Visual_Depth=theDepth ELSE theDepth = 8
IF (Float(!Version.Release) GE 6.4) AND (!D.NAME EQ 'Z') THEN Device, Get_Pixel_Depth=theDepth
IF (theDepth EQ 8) OR (decomposedState EQ 0) THEN offset = !D.Table_Size - ncolors - 2 ELSE offset = 0

   ; Did the user want to select a color name? If so, we set
   ; the color name and color index, unless the user provided
   ; them. In the case of a single positional parameter, we treat
   ; this as the color index number as long as it is not a string.

cancelled = 0.0
IF Keyword_Set(selectcolor) THEN BEGIN

   CASE N_Params() OF
      0: BEGIN
         theColor = PickColorName(Filename=filename, _Extra=extra, Cancel=cancelled)
         IF cancelled THEN RETURN, !P.Color
         IF theDepth GT 8 AND (decomposedState EQ 1) THEN BEGIN
               colorIndex = !P.Color < (!D.Table_Size - 1)
         ENDIF ELSE BEGIN
               colorIndex = Where(StrUpCase(colors) EQ StrUpCase(StrCompress(theColor, /Remove_All)), count) + offset
               colorIndex = colorIndex[0]
               IF count EQ 0 THEN Message, 'Cannot find color: ' + StrUpCase(theColor), /NoName
         ENDELSE

         END
      1: BEGIN
         IF Size(theColor, /TName) NE 'STRING' THEN BEGIN
            colorIndex = theColor
            theColor='White'
         ENDIF ELSE colorIndex = !P.Color < 255
         theColor = PickColorName(theColor, Filename=filename, _Extra=extra, Cancel=cancelled)
         IF cancelled THEN RETURN, !P.Color
         END
      2: BEGIN
         theColor = PickColorName(theColor, Filename=filename, _Extra=extra, Cancel=cancelled)
         IF cancelled THEN RETURN, !P.Color
         END
   ENDCASE
ENDIF

   ; Make sure you have a color name and color index.

CASE N_Elements(theColor) OF
   0: BEGIN
         theColor = 'White'
         IF N_Elements(colorIndex) EQ 0 THEN BEGIN
            IF theDepth GT 8 THEN BEGIN
               colorIndex = !P.Color < (!D.Table_Size - 1)
            ENDIF ELSE BEGIN
               colorIndex = Where(colors EQ theColor, count) + offset
               colorIndex = colorIndex[0]
               IF count EQ 0 THEN Message, 'Cannot find color: ' + theColor, /NoName
            ENDELSE
         ENDIF ELSE colorIndex = 0 > colorIndex < (!D.Table_Size - 1)
      ENDCASE

   1: BEGIN
         type = Size(theColor, /TNAME)
         IF type NE 'STRING' THEN Message, 'The color must be expressed as a color name.'
         theColor = theColor[0] ; Make it a scalar or you run into a WHERE function "feature". :-(
         IF N_Elements(colorIndex) EQ 0 THEN BEGIN
            IF (theDepth GT 8) AND (decomposedState EQ 1) THEN BEGIN
               colorIndex = !P.Color < (!D.Table_Size - 1)
            ENDIF ELSE BEGIN
               colorIndex = Where(colors EQ theColor, count) + offset
               colorIndex = colorIndex[0]
               IF count EQ 0 THEN Message, 'Cannot find color: ' + theColor, /NoName
            ENDELSE
         ENDIF ELSE colorIndex = 0 > colorIndex < (!D.Table_Size - 1)
         ENDCASE

   ELSE: BEGIN
         type = Size(theColor, /TNAME)
         IF type NE 'STRING' THEN Message, 'The colors must be expressed as color names.'
         ncolors = N_Elements(theColor)
         CASE N_Elements(colorIndex) OF
            0: colorIndex = Indgen(ncolors) + (!D.Table_Size - (ncolors + 1))
            1: colorIndex = Indgen(ncolors) + colorIndex
            ELSE: IF N_Elements(colorIndex) NE ncolors THEN $
               Message, 'Index vector must be the same length as color name vector.'
         ENDCASE

            ; Did the user want color triples?

         IF Keyword_Set(triple) THEN BEGIN
            colors = LonArr(ncolors, 3)
            FOR j=0,ncolors-1 DO colors[j,*] = FSC_Color(theColor[j], colorIndex[j], Filename=filename, $
               Decomposed=decomposedState, /Triple)
            RETURN, colors
         ENDIF ELSE BEGIN
            colors = LonArr(ncolors)
            FOR j=0,ncolors-1 DO colors[j] = FSC_Color(theColor[j], colorIndex[j], Filename=filename, $
               Decomposed=decomposedState)
            RETURN, colors
        ENDELSE
      END
ENDCASE

   ; Did the user ask for the color names? If so, return them now.

IF Keyword_Set(names) THEN RETURN, Reform(colors, 1, ncolors)

   ; Process the color names.

theNames = StrUpCase( StrCompress(colors, /Remove_All ) )

   ; Find the asked-for color in the color names array.

theIndex = Where(theNames EQ StrUpCase(StrCompress(theColor, /Remove_All)), foundIt)
theIndex = theIndex[0]

   ; If the color can't be found, report it and continue with
   ; the first color in the color names array.

IF foundIt EQ 0 THEN BEGIN
   Message, "Can't find color " + theColor + ". Substituting " + StrUpCase(colors[0]) + ".", /Informational
   theColor = theNames[0]
   theIndex = 0
ENDIF

   ; Get the color triple for this color.

r = rvalue[theIndex]
g = gvalue[theIndex]
b = bvalue[theIndex]

   ; Did the user want a color triple? If so, return it now.

IF Keyword_Set(triple) THEN BEGIN
   IF Keyword_Set(allcolors) THEN BEGIN
      IF Keyword_Set(row) THEN RETURN, Transpose([[rvalue], [gvalue], [bvalue]]) ELSE RETURN, [[rvalue], [gvalue], [bvalue]]
   ENDIF ELSE BEGIN
      IF Keyword_Set(row) THEN RETURN, [r, g, b] ELSE RETURN, [[r], [g], [b]]
   ENDELSE
ENDIF

   ; Otherwise, we are going to return either an index
   ; number where the color has been loaded, or a 24-bit
   ; value that can be decomposed into the proper color.

IF decomposedState THEN BEGIN

      ; Need a color structure?

   IF Arg_Present(colorStructure) THEN BEGIN
      theColors = FSC_Color_Color24([[rvalue], [gvalue], [bvalue]])
      colorStructure = Create_Struct(theNames[0], theColors[0])
      FOR j=1, ncolors-1 DO colorStructure = Create_Struct(colorStructure, theNames[j], theColors[j])
   ENDIF

   IF Keyword_Set(allcolors) THEN BEGIN
      RETURN, FSC_Color_Color24([[rvalue], [gvalue], [bvalue]])
   ENDIF ELSE BEGIN
      RETURN, FSC_Color_Color24([r, g, b])
   ENDELSE

ENDIF ELSE BEGIN

   IF Keyword_Set(allcolors) THEN BEGIN

            ; Need a color structure?

      IF Arg_Present(colorStructure) THEN BEGIN
         allcolorIndex = !D.Table_Size - ncolors - 2
         IF allcolorIndex LT 0 THEN $
            Message, 'Number of colors exceeds available color table values. Returning.', /NoName
         IF (allcolorIndex + ncolors) GT 255 THEN $
            Message, 'Number of colors exceeds available color table indices. Returning.', /NoName
         theColors = IndGen(ncolors) + allcolorIndex
         colorStructure = Create_Struct(theNames[0],  theColors[0])
         FOR j=1, ncolors-1 DO colorStructure = Create_Struct(colorStructure, theNames[j], theColors[j])
      ENDIF

      IF N_Elements(colorIndex) EQ 0 THEN colorIndex = !D.Table_Size - ncolors - 2
      IF colorIndex LT 0 THEN $
         Message, 'Number of colors exceeds available color table values. Returning.', /NoName
      IF (colorIndex + ncolors) GT 255 THEN BEGIN
         colorIndex = !D.Table_Size - ncolors - 2
      ENDIF
      IF !D.Name NE 'PRINTER' THEN TVLCT, rvalue, gvalue, bvalue, colorIndex
      RETURN, IndGen(ncolors) + colorIndex
   ENDIF ELSE BEGIN

            ; Need a color structure?

      IF Arg_Present(colorStructure) THEN BEGIN
         colorStructure = Create_Struct(theColor,  colorIndex)
      ENDIF

      IF !D.Name NE 'PRINTER' THEN TVLCT, rvalue[theIndex], gvalue[theIndex], bvalue[theIndex], colorIndex
      RETURN, colorIndex
   ENDELSE


ENDELSE

END ;-------------------------------------------------------------------------------------------------------