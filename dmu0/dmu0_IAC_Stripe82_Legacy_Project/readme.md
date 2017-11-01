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

Note that the tiles probably overlap and the catalogue will need to be cleaned
for duplicates.
