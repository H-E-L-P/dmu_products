Kilo-Degree Survey (KiDS) catalogue
===================================

This product contains the catalogue of the DR3 release of the Kilo Degree Survey
(KIDS).  We downloaded all the catalogue files of the DR3 using the [list of
links](http://kids.strw.leidenuniv.nl/DR3/kids_dr3.0_cat_wget.txt) provided in
the [data access](http://kids.strw.leidenuniv.nl/DR3/access.php) page.  We
combined all the catalogues[^1]  and filtered the source on HELP coverage using
the `filterAndTag.sh` tool.

The catalogue columns are described on [this
page](http://kids.strw.leidenuniv.nl/DR3/format.php).

[^1]: Except `KiDS_DR3.0_ugri_src.fits` which is empty.

## DR4

The anonymous ftp area of the Sterrewacht is available at
[[ftp://ftp.strw.leidenuniv.nl]. You login with username: ftp or
username: anonymous and provide as password your email address.

You need to find my directory ./bilicki

What I put there is the KiDS DR4 multiband catalog, all the tiles
merged into one huge file of 127 GB. That large because I kept all the
columns which are in the release. The details about are in the DR4
paper Kuijken et al. 2019 and on webpages:
http://kids.strw.leidenuniv.nl/DR4/releasenotes.php
This is public data, so no problem with distributing, although the
merge is mine so I take responsibility if that was done incorrectly.
But I haven't spotted any issues so far using this file.

Please note that multiband means here forced photometry on the
ug,iZYJHKs bands using r-band as input. There are also single-band
ugri catalogs available but I don't have them. And we don't have
single-band VIKING catalogs.
