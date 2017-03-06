### dmu26_XID+PACS_COSMOS
Description:

  XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see Hurley et al. 2017 for more details).


  This catalogue uses IRAC sources from the SPLASH survey, with a flux > 1 uJy in any of the 4 bands. The cut was made using *MIPS_prior.py*


  The resulting marginalised flux probability distributions for each source, are
  described by the 50th, 84th and 16th percentiles. For those wanting to assume
  Gaussian uncertainties, take the maximum of (84th-50th percentile) and
  (50th-16th percentile).


  We note the Gaussian approximation to uncertainties is only valid for sources
  above:

    ~ 4 mJy at 100 µm
    ~ 10 mJy at 160 µm
    Column descriptions:

      * help_id                    -  ID
      * RA                   degrees  Right Ascension (J2000)
      * Dec                  degrees  Declination (J2000)
      * F_PACS_100               uJy  Flux density at 100 µm (Median)
      * FErr_PACS_100_u          uJy  Flux density at 100 µm (84th Percentile)
      * FErr_PACS_100_l          uJy  Flux density at 100 µm (16th Percentile)
      * F_PACS_160               uJy  Flux density at 160 µm (Median)
      * FErr_PACS_160_u          uJy  Flux density at 160 µm (84th Percentile)
      * FErr_PACS_160_l          uJy  Flux density at 160 µm (16th Percentile)
      * Bkg_PACS_100           MJy/Sr  Fitted Background of 100µm map (Median)
      * Bkg_PACS_160           MJy/Sr  Fitted Background of 160µm map (Median)
      * Sig_conf_PACS_100      MJy/Sr  Additional confusion noise parameter
      * Sig_conf_PACS_160      MJy/Sr  Additional confusion noise parameter
      * Rhat_PACS_100             -  Convergence Statistic (ideally <1.2)
      * Rhat_PACS_160             -  Convergence Statistic (ideally <1.2)
      * n_eff_PACS_100            -  Number of effective samples (ideally >40)
      * n_eff_PACS_160            -  Number of effective samples (ideally >40)
      * Pval_res_PACS_100               -  Local Goodness of fit measure: 0=good, 1=bad
      * Pval_res_PACS_160               -  Local Goodness of fit measure: 0=good, 1=bad

Hurley, P.  et al. 2017, MNRAS 464, 885

The research leading to these results has received funding from the Cooperation
Programme (Space) of the European Union’s Seventh Framework Programme
FP7/2007-2013/ under REA grant agreement n° 607254

================================================================================
Herschel Extragalactic Legacy Programme
