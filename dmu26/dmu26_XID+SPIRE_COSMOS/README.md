                              HELP COSMOS-XID+                      November 2016
================================================================================

Description:

  XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see Hurley et al. 2017 for more details).


  This catalogue uses 24 micron detected sources from the MIPS 24 catalogue (Le
  Floc'h et al. 2009), SCUBA 2 detected sources, radio sources detected by JVLA 
  and sources in hte public ALMA archiveas a prior list for extracting SPIRE 
  fluxes from the Herschel Multi-Tiered Extragalactic Survey (HerMES) SPIRE 
  maps (Oliver et al.2012).


  The resulting marginalised flux probability distributions for each source, are
  described by the 50th, 84th and 16th percentiles. For those wanting to assume
  Gaussian uncertainties, take the maximum of (84th-50th percentile) and
  (50th-16th percentile).


  We note the Gaussian approximation to uncertainties is only valid for sources
  above:
  
    ~ 4mJy at 250 µm
    ~ 4mJy at 350 µm
    ~ 6mJy at 500 µm

Column descriptions:

  * help_id                    -  ID
  * RA                   degrees  Right Ascension (J2000)
  * Dec                  degrees  Declination (J2000)
  * F_SPIRE_250              mJy  Flux density at 250 µm (Median)
  * FErr_SPIRE_250_u         mJy  Flux density at 250 µm (84th Percentile)
  * FErr_SPIRE_250_l         mJy  Flux density at 250 µm (16th Percentile)
  * F_SPIRE_350              mJy  Flux density at 350 µm (Median)
  * FErr_SPIRE_350_u         mJy  Flux density at 350 µm (84th Percentile)
  * FErr_SPIRE_350_l         mJy  Flux density at 350 µm (16th Percentile)
  * F_SPIRE_500              mJy  Flux density at 500 µm (Median)
  * FErr_SPIRE_500_u         mJy  Flux density at 500 µm (84th Percentile)
  * FErr_SPIRE_500_l         mJy  Flux density at 500 µm (16th Percentile)
  * Bkg_SPIRE_250       mJy/Beam  Fitted Background of 250 µm map (Median)
  * Bkg_SPIRE_350       mJy/Beam  Fitted Background of 350 µm map (Median)
  * Bkg_SPIRE_500       mJy/Beam  Fitted Background of 500 µm map (Median)
  * Sig_conf_SPIRE_250  mJy/Beam  Fitted residual noise component due to confusion (Median)
  * Sig_conf_SPIRE_350  mJy/Beam  Fitted residual noise component due to confusion (Median)
  * Sig_conf_SPIRE_500  mJy/Beam  Fitted residual noise component due to confusion (Median)
  * Rhat_SPIRE_250             -  Convergence Statistic (ideally <1.2)
  * Rhat_SPIRE_350             -  Convergence Statistic (ideally <1.2)
  * Rhat_SPIRE_500             -  Convergence Statistic (ideally <1.2)
  * n_eff_SPIRE_250            -  Number of effective samples (ideally >40)
  * n_eff_SPIRE_350            -  Number of effective samples (ideally >40)
  * n_eff_SPIRE_500            -  Number of effective samples (ideally >40)
  * Pval_res_250		     -	Local Goodness of fit measure: 0=good, 1=bad
  * Pval_res_350		     -	Local Goodness of fit measure: 0=good, 1=bad
  * Pval_res_500		     -	Local Goodness of fit measure: 0=good, 1=bad


  Hurley, P.  et al. 2017, MNRAS 464, 885
  Oliver, S. et al. 2012, MNRAS 424, 1614
  Le Floc’h E., et al., 2009, Astrophys. J., 703, 222

--------------------------------------------------------------------------------

History:

 July 1st, 2016: Fourth Hermes data release.

--------------------------------------------------------------------------------

The research leading to these results has received funding from the Cooperation
Programme (Space) of the European Union’s Seventh Framework Programme
FP7/2007-2013/ under REA grant agreement n° 607254

================================================================================
Herschel Extragalactic Legacy Programme (HELP)                     November, 2016

Files can obtained via:
https://dl.dropboxusercontent.com/u/81317960/P4/dmu26_XID%2BSPIRE_COSMOS_20161129.fits
