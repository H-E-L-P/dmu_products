;+
; info = CREATE_READ_CONF(conffile, INFO=info)
;
; Called by CREATE_READ_CONF() for interpreting jackknife declaration
; parameters. The routine CREATEMAP_CONFJK_FREE is provided for
; releasing pointers. 
;
; CREATED BY gmarsden@phas.ubc.ca (2011-02-14)
;-

PRO CREATEMAP_CONFJK_FREE, jklistptr

; free jkmap ptr
IF jklistptr NE PTR_NEW() THEN BEGIN

    ; free index arrays
    PTR_FREE, (*jklistptr).index

    ; free jkmap ptr
    PTR_FREE, jklistptr

    ; disconnect ptr
    jklistptr = PTR_NEW()
ENDIF

END


FUNCTION CREATEMAP_CONFJK_INDEXLIST, paramlist

nparams = N_ELEMENTS(paramlist)

first_scan = paramlist[0]
nscans     = paramlist[1]

; optional parameters
IF nparams GE 3 THEN nblock     = paramlist[2] ELSE nblock = 1
IF nparams GE 4 THEN nblock_use = paramlist[3] ELSE nblock_use = 1
IF nparams GE 5 THEN stride     = paramlist[4] ELSE stride = 1

RETURN, first_scan + INDGEN(nscans) * stride + $
        INDGEN(nscans) / nblock_use * (nblock - nblock_use) 

END


PRO CREATEMAP_CONFJK, jklistptr, newname, newparams

; add a new jackknife map to list, or append to existing map

; if list empty
;   make new list
; else
;   if jkname already exists
;     copy index list
;     free pointer
;     append new data
;     make new pointer
;   else
;     copy jk map list
;     free pointer
;     append new map
;     make new pointer
  
jkmapstruct = {name: "", index: PTR_NEW()}

IF jklistptr EQ PTR_NEW() THEN BEGIN
    ; first element in list
    jkmap = jkmapstruct
    jkmap.name = newname
    jkmap.index = PTR_NEW(CREATEMAP_CONFJK_INDEXLIST(newparams))
    maplist = REPLICATE(jkmap, 1)
ENDIF ELSE BEGIN

    ; make copy of data structure and free ptr
    maplist = *jklistptr
    PTR_FREE, jklistptr
    
    ; find if name already exists
    nameind = WHERE(maplist.name EQ newname, nmatch)
    IF nmatch GT 0 THEN BEGIN
        ; append index list
        
        ; make copy of index list
        index = *(maplist[nameind].index)
        
        ; free pointer
        PTR_FREE, maplist[nameind].index

        ; append new list
        index = [index, CREATEMAP_CONFJK_INDEXLIST(newparams)]

        ; re-create pointer
        maplist[nameind].index = PTR_NEW(index, /NO_COPY)
    ENDIF ELSE BEGIN
        ; append new map
        jkmap = jkmapstruct
        jkmap.name = newname
        jkmap.index = PTR_NEW(CREATEMAP_CONFJK_INDEXLIST(newparams))
        maplist = [maplist, jkmap]
    ENDELSE
ENDELSE

jklistptr = PTR_NEW(maplist, /NO_COPY)

END


