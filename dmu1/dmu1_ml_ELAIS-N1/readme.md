# Master-catalogue on ELAIS-N1

This is the master-catalogue on the ELAIS-N1 field. The processing is described
in the `master_catalogue_ELAIS-N1.ipynb` Jupyter notebook.

## Data

- Isaac Newton Telescope / Wide Field Camera (INT/WFC) catalogue: the catalogue
  comes from `dmu0_INTWFC`.

- UKIRT Infrared Deep Sky Survey / Deep Extragalactic Survey (UKIDSS/DXS) on
  ELAIS-N1: The catalogue comes from `dmu0_ELAIS-N1_DXS`.

- Spitzer datafusion SERVS and SWIRE: the Spitzer catalogues produced by the
  datafusion team are available in the HELP virtual observatory server. They are
  described there: http://vohedamtest.lam.fr/browse/df_spitzer/q.

- SpARCS (Spitzer Adaptation of the Red-sequence Cluster Survey) catalogue. This
  catalogue comes from `dmu0_SpARCS`.

## Additional notebook

The `sparcs_aperture_correction.ipynb` notebook is used to analyse the aperture
magnitudes in SpARCS data and to make choice for the aperture correction in the
main notebook.
