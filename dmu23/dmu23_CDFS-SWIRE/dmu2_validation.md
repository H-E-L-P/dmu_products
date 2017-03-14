# DMU2 validation report (2017-02-02)

- There is no README.
- What is the encoding of the `z_source` column.
- There is no meta information associated.
- Some source have a reliability to -1.  As it's a float column, it's better to
  use NaN.  That was changed.
- I added a `specz_id` column with a position base identifier like we have in
  the specZ table on the VO server.

# DMU2 validation report (2017-03-14)

- There is no readme.
- There is no meta information files (the `yml` files).
- Some source have a reliability to -1.  As it's a float column, it's better to
  use NaN.  That was changed.
- I added a `specz_id` column with a position base identifier like we have in
  the specZ table on the VO server.
- The update catalogue is `CDFS_SWIRE-specz-v2.1_hedam.csv`.
- 81 sources have no (NaN) spectroscopic redshift.
