;$Id: //depot/Release/ENVI53_IDL85/idl/idldir/lib/comfit.pro#1 $
;
; Copyright (c) 1994-2015, Exelis Visual Information Solutions, Inc. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;       COMFIT
;
; PURPOSE:
;       This function fits the paired data {X(i), Y(i)} to one of six common
;       types of appoximating models using a gradient-expansion least-squares
;       method. The result is a vector containing the model parameters.
;
; CATEGORY:
;       Statistics.
;
; CALLING SEQUENCE:
;       Result = COMFIT(X, Y, A)
;
; INPUTS:
;       X:    An n-element vector of type integer, float or double.
;
;       Y:    An n-element vector of type integer, float or double.
;
;       A:    A vector of initial estimates for each model parameter. The length
;             of this vector depends upon the type of model selected.
;
; KEYWORD PARAMETERS:
;       EXPONENTIAL:    If set to a non-zero value, the parameters of the
;                       exponential model are computed. Y = a0  * a1^x + a2.
;
;         GEOMETRIC:    If set to a non-zero value, the parameters of the
;                       geometric model are computed.  Y = a0 * x^a1 + a2.
;
;          GOMPERTZ:    If set to a non-zero value, the parameters of the
;                       Gompertz model are computed.  Y = a0 * a1^(a2*x) + a3.
;
;        HYPERBOLIC:    If set to a non-zero value, the parameters of the
;                       hyperbolic model are computed.  Y = 1./(a0 + a1*x)
;
;          LOGISTIC:    If set to a non-zero value, the parameters of the
;                       logistic model are computed.  Y = 1./(a0 * a1^x + a2)
;
;         LOGSQUARE:    If set to a non-zero value, the parameters of the
;                       logsquare model are computed.
;			Y = a0 + a1*alog10(x) + a2 * alog10(x)^2
;
;             SIGMA:    Use this keyword to specify a named variable which
;                       returns a vector of standard deviations for the computed
;                       model parameters.
;
;           WEIGHTS:    An n-element vector of weights. If the WEIGHTS vector
;                       is not specified, an n-element vector of 1.0s is used.
;
;              YFIT:    Use this keyword to specify a named variable which
;                       returns n-element vector of y-data corresponding to the
;                       computed model parameters.
;
; EXAMPLE:
;       Define two n-element vectors of paired data.
;         x = [2.27, 15.01, 34.74, 36.01, 43.65, 50.02, 53.84, 58.30, 62.12, $
;             64.66, 71.66, 79.94, 85.67, 114.95]
;         y = [5.16, 22.63, 34.36, 34.92, 37.98, 40.22, 41.46, 42.81, 43.91, $
;             44.62, 46.44, 48.43, 49.70, 55.31]
;       Define a 3-element vector of initial estimates for the logsquare model.
;         a = [1.5, 1.5, 1.5]
;       Compute the model parameters of the logsquare model, a(0), a(1), & a(2).
;         result = comfit(x, y, a, sigma = sigma, yfit = yfit, /logsquare)
;       The result should be the 3-element vector:
;         [1.42494, 7.21900, 9.18794]
;
; REFERENCE:
;       APPLIED STATISTICS (third edition)
;       J. Neter, W. Wasserman, G.A. Whitmore
;       ISBN 0-205-10328-6
;
; MODIFICATION HISTORY:
;       Written by:  GGS, RSI, September 1994
;   Modified: CT, RSI, May 2006: Add check for zeroes for /geometric.
;       Allow keywords to pass thru to curvefit.
;-

;-------------------------------------------------------------------------
pro exp_func, x, a, f, pder
  compile_opt hidden
  f = a[0] * a[1]^x + a[2]
  if n_params() ge 4 then $
    pder = [[a[1]^x], [a[0] * x * a[1]^(x-1)], [replicate(1., n_elements(x))]]
end

;-------------------------------------------------------------------------
pro geo_func, x, a, f, pder
  compile_opt hidden
  f = a[0] * x^a[1] + a[2]
  if n_params() ge 4 then $
    pder = [[x^a[1]], [a[0] * alog(x) * x^a[1]], [replicate(1., n_elements(x))]]
end

;-------------------------------------------------------------------------
pro gom_func, x, a, f, pder
  compile_opt hidden
  f = a[0] * a[1]^(a[2]*x) + a[3]
  if n_params() ge 4 then $
    pder = [[a[1]^(a[2]*x)], [a[0] * a[2] * x * a[1]^(a[2]*x-1)], $
	[a[0] * x * alog(a[1]) * a[1]^(a[2]*x)], [replicate(1., n_elements(x))]]
end

;-------------------------------------------------------------------------
pro hyp_func, x, a, f, pder
  compile_opt hidden
  f = 1.0 / (a[0] + a[1] * x)
  if n_params() ge 4 then $
    pder = [[-1.0 / (a[0] + a[1] * x)^2], [-x / (a[0] + a[1] * x)^2]]
end

;-------------------------------------------------------------------------
pro log_func, x, a, f, pder
  compile_opt hidden
  f = 1.0 / (a[0] * a[1]^x + a[2])
  if n_params() ge 4 then begin
    denom =  -1.0/(a[0] * a[1]^x + a[2])^2
    pder = [[a[1]^x*denom], [a[0] * x * a[1]^(x-1)*denom], [denom]]
    endif
end

;-------------------------------------------------------------------------
pro logsq_func, x, a, f, pder
  compile_opt hidden
  b = alog10(x)
  b2 = b^2
  f = a[0] + a[1] * b + a[2] * b2
  if n_params() ge 4 then $
    pder = [[replicate(1., n_elements(x))], [b], [b2]]
end

;-------------------------------------------------------------------------
function comfit, x, y, a, weights = weights, sigma = sigma, yfit = yfit, $
                       exponential = exponential, geometric = geometric, $
                       gompertz = gompertz, hyperbolic = hyperbolic, $
                       logistic = logistic, logsquare = logsquare, $
                       _REF_EXTRA=extra

  on_error, 2

  fcn_names = ['exp_func', 'geo_func', 'gom_func', 'hyp_func', 'log_func', $
		'logsq_func']
  fcn_npar = [ 3, 3, 4, 2, 3, 3]

  nx = n_elements(x)
  wx = n_elements(weights)
  if nx ne n_elements(y) then $
    message, 'x and y must be vectors of equal length.'

  if wx eq 0 then weights = replicate(1.0, nx) $
  else if wx ne nx then $
	message, 'x and weights must be vectors of equal length.'

  a1 = A			;Copy initial guess
  if keyword_set(exponential) then i = 0 $
  else if keyword_set(geometric) then i = 1 $
  else if keyword_set(gompertz) then i = 2 $
  else if keyword_set(hyperbolic) then i = 3 $
  else if keyword_set(logistic) then i = 4 $
  else if keyword_set(logsquare) then i = 5 $
  else message, 'Type of model must be supplied as a keyword parameter.'

  if n_elements(a1) ne fcn_npar[i] then $
	message, 'A must be supplied as a '+strtrim(fcn_npar[i], 2) + $
	     '-element initial guess vector.'

  ; Special code for /geometric. If X has a zero value we cannot
  ; use the analytic partial derivative. Instead, let curvefit compute it.
  if (i eq 1 && Max(x eq 0) eq 1) then begin
    noderivative = 1
  endif

  yfit = curvefit(x, y, weights, a1, sigma, function_name = fcn_names[i], $
    NODERIVATIVE=noderivative, _EXTRA=extra)
  return, a1
end
