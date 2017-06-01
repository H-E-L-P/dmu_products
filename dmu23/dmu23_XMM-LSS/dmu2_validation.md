# DMU2 validation report (2016-12-05)

- The readme was forgotten in the mail.
- There is no meta information associated.
- Some OBJID are duplicated but added a `specz_id` does not produce duplicates.

I added a field column and a `specz_id` based on the position like we have in
the specZ table on the VO server.

The updated file is `XMM-LSS-specz-v2.5_helpid_20160512.fits`.

# DMU2 validation report (2017-03-14)

- There is no meta information associated.
- There is no meta information files (the `yml` files).
- Some source have a reliability to -1.  As it's a float column, it's better to
  use NaN.  That was changed.
- I added a `specz_id` column with a position base identifier like we have in
  the specZ table on the VO server.
- The update catalogue is `XMM-LSS-specz-v2.6_hedam.csv`.
- 1278 sources have no (NaN) spectroscopic redshift.

# DMU2 validation report (2017-06-01)

- There is no meta information files (the `yml` files).
- Some source have a reliability to -.  As it's a float column, it's better to
  use NaN.  That was changed.
- I added a `specz_id` column with a position base identifier like we have in
  the specZ table on the VO server.
- The update catalogue is `XMM-LSS-specz-v2.7.fits`.
- 1278 sources have no (NaN) spectroscopic redshift.
