# DMU2 validation report (2016-11-24)

- The catalogues are not limited to HELP coverage.
- There is no unique identifier. The `name` column has duplicates.
- There is no meta information associated.
- The coverage flag is not a binary integer flag.
- The columns in the `catalogue` file are not fluxes and does not have
  standardised names.

The catalogues were processed with the `filterAndTag.sh` script to limit them to
HELP coverage. A `help_id` column was added containing a unique identifier based
on the position. The new files produced are
`gama15_masterlist_helplimited_helpid_20161124.fits.bz2` and
`gama15_catalogue_helplimited_helpid_20161124.fits`.

## Addition 2017-02-28

- The filter bandpass are not provided.
