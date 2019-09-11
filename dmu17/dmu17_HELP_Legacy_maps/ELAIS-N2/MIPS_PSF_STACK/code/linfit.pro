;$Id: //depot/Release/IDL_81/idl/idldir/lib/linfit.pro#1 $
;
; Copyright (c) 1994-2011, ITT Visual Information Solutions. All
;       rights reserved. Unauthorized reproduction is prohibited.
;+
; NAME:
;       LINFIT
;
; PURPOSE:
;       This function fits the paired data {X(i), Y(i)} to the linear model,
;       y = A + Bx, by minimizing the chi-square error statistic. The result
;       is a two-element vector containing the model parameters,[A,B].
;
; CATEGORY:
;       Statistics.
;
; CALLING SEQUENCE:
;       Result = LINFIT(X, Y)
;
; INPUTS:
;       X:    An n-element vector of type integer, float or double.
;
;       Y:    An n-element vector of type integer, float or double.
;
; KEYWORD PARAMETERS:
;   CHISQ:    Use this keyword to specify a named variable which returns the
;             chi-square error statistic as the sum of squared errors between
;             Y(i) and A + BX(i). If individual standard deviations are
;             supplied, then the chi-square error statistic is computed as
;             the sum of squared errors divided by the standard deviations.
;
;  COVAR:   Set this keyword to a named variable that will contain the
;           covariance matrix of the fitted coefficients.
;
;  DOUBLE:    If set to a non-zero value, computations are done in double
;             precision arithmetic.
;
;   MEASURE_ERRORS: Set this keyword to a vector containing standard
;       measurement errors for each point Y[i].  This vector must be the same
;       length as X and Y.
;
;     Note - For Gaussian errors (e.g. instrumental uncertainties),
;        MEASURE_ERRORS should be set to the standard
; 	     deviations of each point in Y. For Poisson or statistical weighting
; 	     MEASURE_ERRORS should be set to sqrt(Y).
;
;    PROB:    Use this keyword to specify a named variable which returns the
;             probability that the computed fit would have a value of CHISQR
;             or greater. If PROB is greater than 0.1, the model parameters
;             are "believable". If PROB is less than 0.1, the accuracy of the
;             model parameters is questionable.
;
;   SIGMA:    Use this keyword to specify a named variable which returns a
;             two-element vector of probable uncertainties for the model par-
;             ameters, [SIG_A,SIG_B].
;
;        Note: if MEASURE_ERRORS is omitted, then you are assuming that the
;              linear fit is the correct model. In this case,
;              SIGMA is multiplied by SQRT(CHISQ/(N-M)), where N is the
;              number of points in X. See section 15.2 of Numerical Recipes
;              in C (Second Edition) for details.
;
;    YFIT:    Set this keyword to a named variable that will contain the
;             vector of calculated Y values.
;
; EXAMPLE:
;       Define two n-element vectors of paired data.
;         x = [-3.20, 4.49, -1.66, 0.64, -2.43, -0.89, -0.12, 1.41, $
;               2.95, 2.18,  3.72, 5.26]
;         y = [-7.14, -1.30, -4.26, -1.90, -6.19, -3.98, -2.87, -1.66, $
;              -0.78, -2.61,  0.31,  1.74]
;       Define a vector of standard deviations with a constant value of 0.85
;         sdev = replicate(0.85, n_elements(x))
;       Compute the model parameters, A and B.
;         result = linfit(x, y, chisq = chisq, prob = prob, sdev = sdev)
;       The result should be the two-element vector:
;         [-3.44596, 0.867329]
;       The keyword parameters should be returned as:
;         chisq = 11.4998, prob = 0.319925
;
; REFERENCE:
;       Numerical Recipes, The Art of Scientific Computing (Second Edition)
;       Cambridge University Press
;       ISBN 0-521-43108-5
;
; MODIFICATION HISTORY:
;       Written by:  GGS, RSI, September 1994
;                    LINFIT is based on the routines: fit.c, gammq.c, gser.c,
;                    and gcf.c described in section 15.2 of Numerical Recipes,
;                    The Art of Scientific Computing (Second Edition), and is
;                    used by permission.
;         Modified:  SVP, RSI, June 1996
;		     Changed SIG_AB to SIGMA to be consistant with the other
;		     fitting functions. Changed CHISQR to CHISQ in the docs
;                    for the same reason. Note that the chisqr and the SIG_AB
;		     keywords are left for backwards compatibility.
;         Modified:  GGS, RSI, October 1996
;                    Modified keyword checking and use of double precision.
;                    Added DOUBLE keyword.
;    Modified: CT, RSI, July 2000: Added COVAR, MEASURE_ERRORS, YFIT keywords.
;-

FUNCTION LinFit, x, y, $
	chisqr = chisqr, Double = DoubleIn, prob = prob, $
	sig_ab = sig_ab, sigma = sigma, $
	COVAR=covar,YFIT=yfit, MEASURE_ERRORS=measure_errors, $
	SDEV = sdevIn  ; obsolete keyword (still works)

COMPILE_OPT idl2

  ON_ERROR, 2

  nX = N_ELEMENTS(x)
  nY = N_ELEMENTS(y)

  if nX ne nY then $
    MESSAGE, "X and Y must be vectors of equal length."

  ;If the DOUBLE keyword is not set then the internal precision and
  ;result are identical to the type of input.
  double = (N_ELEMENTS(doubleIn) gt 0) ? KEYWORD_SET(doubleIn) : $
    (SIZE(x, /TYPE) eq 5) || (SIZE(y, /TYPE) eq 5)

  isSdev = N_ELEMENTS(sdevIn) GT 0
  isMeasure = N_ELEMENTS(measure_errors) GT 0
  IF (isSdev OR isMeasure) THEN BEGIN
    IF (isSdev AND isMeasure) THEN $
  	  MESSAGE,'Conflicting keywords SDEV and MEASURE_ERRORS.'
    sdev = isMeasure ? measure_errors : sdevIn
    nsdev = N_ELEMENTS(sdev)
    IF (nsdev NE nX) THEN MESSAGE, $
      'MEASURE_ERRORS must have the number of elements as X and Y.'
  ENDIF ELSE BEGIN
    sdev = double ? 1d : 1.0
    nsdev = 0
  ENDELSE


; for explanation of constants see Numerical Recipes sec. 15-2
  if nsdev eq nX then begin ;Standard deviations are supplied.
	wt = 1/(sdev^(double ? 2d : 2.0))
	ss = TOTAL(wt, DOUBLE=double)
	sx = TOTAL(wt * x, DOUBLE=double)
	sy = TOTAL(wt * y, DOUBLE=double)
    t =  (x - sx/ss) / sdev
    b = TOTAL(t * y / sdev, DOUBLE=double)
  endif else begin
	ss = nX
	sx = TOTAL(x, DOUBLE=double)
	sy = TOTAL(y, DOUBLE=double)
    t = x - sx/ss
    b = TOTAL(t * y)
  endelse

  st2 = TOTAL(t^2, DOUBLE=double)
  IF (NOT double) THEN BEGIN
	ss = FLOAT(ss)
	sx = FLOAT(sx)
	sy = FLOAT(sy)
	st2 = FLOAT(st2)
	b = FLOAT(b)
  ENDIF

; parameter estimates
  b = b / st2
  a = (sy - sx * b) / ss

; error estimates
  sdeva = SQRT((1.0 + sx * sx / (ss * st2)) / ss)
  sdevb = SQRT(1.0 / st2)
  covar = -sx/(ss*st2)
  covar = [[sdeva^2, covar], [covar, sdevb^2]]

  yfit = b*x + a

  if nsdev ne 0 then begin
    chisqr = TOTAL( ((y - yfit) / sdev)^2, Double = Double )
    if ~Double then $
        chisqr = FLOAT(chisqr)
    prob = 1 - IGAMMA(0.5*(nX-2), 0.5*chisqr)
  endif else begin
    chisqr = TOTAL( (y - yfit)^2, Double = Double )
    if ~Double then $
        chisqr = FLOAT(chisqr)
    prob = double ? 1d : 1.0
    sdevdat = SQRT(chisqr / (nX-2))
    sdeva = sdeva * sdevdat
    sdevb = sdevb * sdevdat
  endelse

  sigma = (sig_ab = [sdeva, sdevb])

  RETURN, [a, b]

END
