WIRCAM Deep Survey (WIRDS)
==========================

This product contains some catalogue from the CFHT WIRCAM Deep Survey (WIRDS).
The survey is described on the [Terapix web
site](http://terapix.iap.fr/rubrique.php?id_rubrique=261). The catalogues of the
T0002 data release were downloaded from the [Canadian Astronomy Data
Centre](http://www.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/) database limiting to:

- The D1 field (022559-042940 files, over XMM-LSS), the D2 field
  (100028+021230 files, over COSMOS), and the D3 field (141927+524056 files,
  over EGS). The D4 field is out of HELP coverage.
- We got only the J, H, and Ks blind extraction catalogues (as we want to use
  WIRDS for near-infrared domain) and Ks driven multi-wavelength catalogues.
  Raphael will choose what to use when he build the master list.

The various catalogues were limited to HELP coverage en renamed to match the
field names.

## Notes

- The Ks prior catalogue contains only the Kron magnitude and the 2 arc-seconds
  magnitude.  We don't know if the last one is aperture corrected.  If it needs
  aperture correction, we may either use the blind catalogue to compute the
  correction (is it right?) or download the separated, per band, Ks prior
  catalogues that should contain all the apertures.
- The fluxes are given in counts.
- We have to check if the magnitudes are in AB or Vega system.
