# DMU2 validation report (2016-12-05)

- There is no README. Is it the same as for previous versions. What is the
  encoding for the `z_source` column.
- There is no meta information associated.
- There are some sources outside of HELP coverage. They were excluded using the
  `filterAndTag.sh` script (also adding the field column).
- I added a `specz_id` column with a position base identifier like we have in
  the specZ table on the VO server.

The updated file is `COSMOS-specz-v2.5-public_helpcoverage_helpid_20160512.fits`.
