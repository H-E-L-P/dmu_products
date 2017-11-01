IAC Stripe 82 Legacy Project
============================

This resource contains the catalogues from the IAC (Instituto de Astrofísica de
Canarias) Stripe 82 Legacy project. Nacho Trujillo provided us with two
archives:

- `galaxies.cat.gz`: A tar.gz file containing 1000 catalogues of galaxies.
- `pointsources.cat.gz`: A tar.gz file containing 1000 catalogues of point
    sources.

We merged everything in a `iac_stripe82_concat.fits` adding two columns:

- The `tile` contains the integer present in the original catalogue name: e.g.
    the sources from the `f0483_gal.cat` will have 483 in this column.
- The `stellarity` is a float column set to 0 for the sources from the galaxy
    catalogues and to 1 for the sources from the point source catalogues.

The initial catalogues have the same column names for all the bands (the
description tell the band name) so we renamed all band column with the band name
as prefix: e.g. MAG_AUTO for the band u is now u_MAG_AUTO.

We also limited the catalogue to HELP coverage in
`iac_stripe82_concat_helpcoverage.fits`.

Note that the tiles probably overlap and the catalogue will need to be cleaned
for duplicates.
