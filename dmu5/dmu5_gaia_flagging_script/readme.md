Script to flag GAIA stars
=========================

This product is a Python script to add a `gaia_flag` column to a catalogue base
of Seb's prescriptions:

- 1 (possibly a star) if the nearest Gaia source is between 1.5” and 2”;
- 2 (probably a star) if the nearest Gaia source is between 0.6” and 1.5”;
- 3 (definitely a star) if the nearest Gaia source is closer that 0.6”;
- 0 otherwise.

The script needs these Python modules: astropy, click, numpy, and pyvo. It is
executed like this:

`flag_catalogue_with_gaia.py <catalogue> <gaia_cat_or_field>`

where:

- `<catalogue>` is the catalogue to flag. The positions must be in the `ra` and
  `dec` columns, in decimal degrees, and in the J2000 reference.
- `gaia_cat_or_field` is either a Gaia catalogue extracted from the HELP
  database or the name on an HELP field; in that case the Gaia catalogue will be
  downloaded from the HELP VO server.

The script produces a `_flagged.fits` catalogue.
