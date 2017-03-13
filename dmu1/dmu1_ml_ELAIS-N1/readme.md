# Master-catalogue on ELAIS-N1

This is the master-catalogue on the ELAIS-N1 field. The processing is described
in the `master_catalogue_ELAIS-N1.ipynb` Jupyter notebook.

## Data

- Isaac Newton Telescope / Wide Field Camera (INT/WFC): The catalogue was
  provided by Eduardoi. It is store in `dmu0_ELAIS-N1_DXS`. The catalogue is
  described in [this
  paper](https://academic.oup.com/mnras/article/416/2/927/1055929/Wide-field-optical-imaging-on-ELAIS-N1-ELAIS-N2).

- UKIRT Infrared Deep Sky Survey / Deep Extragalactic Survey (UKIDSS/DXS): The
  catalogue was provided by Eduardo from an extraction made by Mattia. The
  catalogue is quite different from what can be extracted from the UKIDSS
  database (FIXME: Mattia to explain why). The descriptions of the columns of
  the DXS table in the UKIDSS database is available there:
  http://horus.roe.ac.uk/wsa/www/WSA_TABLE_dxsSourceSchema.html. The catalogue
  is stored in `dmu0_ELAIS-N1_DXS`.

- Spitzer datafusion SERVS and SWIRE: the Spitzer catalogues produced by the
  datafusion team are available in the HELP virtual observatory server. They are
  described there: http://vohedamtest.lam.fr/browse/df_spitzer/q.

- SpARCS (Spitzer Adaptation of the Red-sequence Cluster Survey) catalogue. This
  catalogue comes from `dmu0_SpARCS`.

## Additional notebook

The `sparcs_aperture_correction.ipynb` notebook is used to analyse the aperture
magnitudes in SpARCS data and to make choice for the aperture correction in the
main notebook.
