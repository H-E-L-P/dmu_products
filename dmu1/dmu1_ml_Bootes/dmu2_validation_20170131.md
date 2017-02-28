# DMU2 validation report (2017-01-31)

- There is no documentation.
- The catalogues are not limited to HELP coverage.
- There is no unique identifier. The `name` column has duplicates.
- There is no meta information associated.
- The coverage flag is not a binary integer flag.
- The columns in the `catalogue` file are not fluxes and does not have
  standardised names.

The catalogues were processed with the `filterAndTag.sh` script to limit them to
HELP coverage. A `help_id` column was added containing a unique identifier based
on the position. The new files produced are
`bootes_masterlist_20170131_helplimited_helpid.fits` and
`bootes_catalogue_20170131_helplimited_helpid.fits`.

## Addition 2017-02-28

- The filter bandpass are not provided.
