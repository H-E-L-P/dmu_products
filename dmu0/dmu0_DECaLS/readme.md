Dark Energy Camera Legacy Survey (DECaLS)
=========================================

This product contains the tractor catalogues from the [Dark Energy Camera Legacy
Survey](http://legacysurvey.org/decamls/) (DECaLS).  The data is available
through Table Access Protocol (TAP) on [National Optical Astronomy Observatory
Datalab](http://datalab.noao.edu) or as individual tractor (the software used
for source extraction) on each *brick* - part of the sky observed at once.

The TAP server contains several table of interest.  Mike Fitzpatrick from the
NOAO described the tables in some mail exchanges:

“Yes, the tractor catalog is a concatenation of all the tractor files.  The
tractor_primary is a view of that table where the 'brick_primary' is true
meaning that in overlapped regions only one object is designated as the
'primary'.  Likewise, tractor_secondary is the opposite, so to query for
only unique objects select on tractor_primary.  Similarly, 'star' and
'galaxy' are views of primary objects based on whether the 'type' is 'PSF'
(which may include QSOs in the star view)”.

As the VO database is difficult to use for large queries, we downloaded directly
the individual tractor files. Using the [list of the
bricks](http://portal.nersc.gov/project/cosmo/data/legacysurvey/dr3/survey-bricks-dr3.fits.gz)
composing the DR3 we identified the 11,041 bricks having their centre on HELP
coverage and downloaded them.

We merged all the catalogues used the `filterAndTag.sh` script to keep only the
sources actually on HELP coverage and add the field information.  The we kept
only the sources with `brick_primary` set to true and made one catalogue per
field.

The columns of the catalogues are described (on this
page)[http://legacysurvey.org/dr3/catalogs/].
