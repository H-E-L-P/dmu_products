function star_artefacts_threshold, fit_params, ythresh,reliability=reliability


;+
; NAME:
;      star_artefacts_threshold
;
;
; PURPOSE:
;      takes a model radial density profile for artefacts around a star and
;      defines a radius at which the artefacts reach a given
;      relibability threshold
;
;
; CATEGORY:
;      HELP star masking
;
;
; CALLING SEQUENCE:
;      radius=star_artefacts_threshold(fit_params, reliability=reliability)
;
;
; INPUTS:
;    fit_params: fit parameters for an expontial + constant as defined
;    in IDL comfit exponential function y=a0*a1^x+a2 
;    
;
;
; OPTIONAL INPUTS:
;
;
;
; KEYWORD PARAMETERS:
;    reliability: threshold in relibability, default 0.8
;
;
; OUTPUTS:
;   star_artefacts_threshold: radius (x) at which artefact density has
;   declined to reliability threshold
;
;
; OPTIONAL OUTPUTS:
;
;
;
; COMMON BLOCKS:
;
;
;
; SIDE EFFECTS:
;
;
;
; RESTRICTIONS:
;
;
;
; PROCEDURE:
;
; this takes the fit paramameters from a function y=a0*a1^x+a2 and
; calculates where the function intercepts with a threshold defined to
; be such that a2/y = reliability
;
; This model is taken to be an exponentially declining number denisty profile of
; "artefacts" a0*a1^x 
; on top of a background of "real" objects: a2
; so the limit is where the real objects make up a high fraction
; (relibabilty) of the total (artefacts + real)
;
;
; EXAMPLE:
;
;
;
; MODIFICATION HISTORY:
;
; Seb Oliver 6th April 2017
;-

;

if n_params() eq 2 then begin 
   limit=(alog(ythresh-fit_params[2])-alog(fit_params[0]))/alog(fit_params[1])
endif else begin 
   if not keyword_set(reliability) then reliability=0.8
   
   limit=(alog(fit_params[2]*(1./reliability-1.))-alog(fit_params[0]))/alog(fit_params[1])
endelse

return,limit

end

