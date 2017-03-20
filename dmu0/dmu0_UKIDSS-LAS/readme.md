UKIRT Infrared Deep Sky Survey / Large Area Survey (UKIDSS/LAS)
===============================================================

This is the extraction of the UKIDSS/LAS catalogue from the Cambridge database
with scripts provided by Eduardo.

- We renamed the `RA` and `DEC` columns to `RA_RADIANS` and `DEC_RADIANS`.
- We added `RA` and `Dec` columns in decimal degrees.
- We limited to HELP coverage and added a `field` column.

The columns are described at
http://horus.roe.ac.uk/wsa/www/WSA_TABLE_lasSourceSchema.html#lasSource

# Privacy concerns

Eduardo's script is querying the `lasSource` table in the `UKIDSSDR10PLUS`
database. Is this data public?
