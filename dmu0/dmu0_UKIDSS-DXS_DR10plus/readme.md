UKIRT Infrared Deep Sky Survey / Deep Extragalactic Survey (UKIDSS/DXS)
=======================================================================

This product containst the DR10 UKIDSS-DXS catalogues extracted by Mattia. The
`data/query_tool` folder contains the scripts and SQL queries used to get the
data from the UKIDSS database. The *merged* catalogues where limited to HELP
coverage and named `UKIDSS-DR10plus_<field>.fits`.

These catalogues should be used in place of the catalogues in `dmu0_UKIDSS-DXS`.

The descriptions of the columns of the DXS table in the UKIDSS database is
available there: http://horus.roe.ac.uk/wsa/www/WSA_TABLE_dxsSourceSchema.html.

*Note that there are H-band columns but no H-band data is available for DXS and
these columns are empty.*

The magnitudes are “*Vega like*”.  The AB offsets are given by Hewett *et al.*
(2016):

| Band | AB offset |
|------|-----------|
| J    | 0.938     |
| H    | 1.379     |
| K    | 1.900     |
