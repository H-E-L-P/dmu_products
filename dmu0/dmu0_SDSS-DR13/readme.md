Sloan Digital Sky Survey - 13<sup>th</sup> Data Release
=======================================================

This product contains the catalogues from the 13<sup>th</sup> data release of
the Sload Digital Sky Survey (SDSS-DR13).  Mattia queried the SDSS database and
sent us several files.  The files were joined and remove from duplicates using
the `ObjID` column (there were overlaps in the queries).  We also renamed the
`field` column to `sdss_field` because the former name is used in our workflow.

The resulting table was then processed with our `filterAndTag.sh` script and the
resulting catalogue was divided into one catalogue per field.
