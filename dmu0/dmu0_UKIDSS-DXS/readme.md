UKIRT Infrared Deep Sky Survey / Deep Extragalactic Survey (UKIDSS/DXS)
=======================================================================

This is the extraction of the UKIDSS/DXS catalogue from the Cambridge database
with scripts provided by Eduardo.

- We renamed the `RA` and `DEC` columns to `RA_RADIANS` and `DEC_RADIANS`.
- We added `RA` and `Dec` columns in decimal degrees.
- We limited to HELP coverage and added a `field` column.

The columns are described at
http://horus.roe.ac.uk/wsa/www/WSA_TABLE_dxsSourceSchema.html#dxsSource

# Privacy concerns

Eduardo's script is querying the `dxsSource` table in the `UKIDSSDR10PLUS`
database. Is this data public?
