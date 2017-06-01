# DMU2 validation report (2017-06-01)

- There is no meta information files (the `yml` files).
- Some source have a reliability to -.  As it's a float column, it's better to
  use NaN.  That was changed.
- I added a `specz_id` column with a position base identifier like we have in
  the specZ table on the VO server.
- The update catalogue is `SSDF-specz-v2.fits`.
- 41 sources have an empty redshift.
