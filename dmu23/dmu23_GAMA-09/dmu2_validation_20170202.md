# DMU2 validation report (2017-02-02)

- There is no README.
- What is the encoding of the `z_source` column.
- There is no meta information associated.
- Some source have a reliability to '-' (string).  As it's a float column, it
  was changed to nan.
- I added a `specz_id` column with a position base identifier like we have in
  the specZ table on the VO server.
