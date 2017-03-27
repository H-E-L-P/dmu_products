Spitzer IRAC Equatorial Survey (SpIES)
======================================

This product contains the catalogue from the Spitzer IRAC Equatorial Survey
(SpIES).

    The Spitzer IRAC Equatorial Survey (SpIES) is a large-area survey of 115 sq.
    degrees in the Equatorial SDSS Stripe 82 field. SpIES achieves 5 sigma
    depths of 6.13 microJy (21.93 AB magnitude) and 5.75 microJy (22.0 AB
    magnitude) at 3.6 and 4.5 microns, respectively. If you use SpIES data,
    please cite Timlin et al. (2016).

The data was downloaded from http://irsa.ipac.caltech.edu/data/SPITZER/SpIES/
and is described in  [Timlin et al.
(2016)](http://adsabs.harvard.edu/abs/2016ApJS..225....1T).

The catalogues were limited to HELP coverage and an `internal_id` column was
added to uniquely identify each source.  There are three catalogues:

- `SpIES_ch1_only_HELP-coverage.fits` contains the sources found only in IRAC1;
- `SpIES_ch2_only_HELP-coverage.fits` contains the sources found only in IRAC2;
- `SpIES_ch1andch2_HELP-coverage.fits` contains the sources found both in IRAC1
    and IRAC2.

*Note: The “channel 2 only” catalogue seems to have zone of really different
depth (see the MOC).*
