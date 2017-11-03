VISTA-VIDEO catalogues (private)
================================

This product contains the private version of the VISTA-VIDEO catalogues. We used
the `VIDEO-all_2017-02-12_fullcat_errfix.fits` downloaded from
http://www-astro.physics.ox.ac.uk/~video/data/VIDEO_all/cats/


In an electronic mail, Boris Häußler described the `errfix` catalogue as:

    The errfix version of each catalogue fixes the error bars given by
    SExtractor by creating fake positions in all images and taking the
    uncertainties from there. I THINK this is described in Matts initial VIDEO
    paper.  The values themselves in the catalogues are identical, it's jus the
    error bars that should be more realistic.


The description of the columns (from the DR4 version) is available
[there](http://horus.roe.ac.uk/vsa/www/VIDEODR4/VIDEODR4_TABLE_videoSourceSchema.html)

There is also a readme in the `data` folder.

The video fields are fully included in HELP ones.

The `ID` column is unique for each source in each field (but not cross-field).

Detection is attempted in every band. The paper Jarvis et al. 2012 states:

"Each tile catalogue contains objects detected in any of the Ks, H, J, Y , or
Z bands, with measurements made in all the other bands based on the position in
the detection image. Duplicate detections of objects are removed, by retaining
only the longest wavelength detection (after matching the Ks −, H −, J−, Y − and
Z−band detected catalogues with a 1 arcsecond tolerance)"

# Wrong z band magnitudes

We discovered that the catalogue contains some wrong z magnitudes in the
CDFS-SWIRE field.  Strangely, Sextractor affected some magnitudes to sources
which are not on the z image.  Boris found a way to get rid of these magnitudes,
all the wrong sources have a Z_MAGERR_AUTO to 0 in the *not errfix* catalogue.

The `data` folder contains the `VIDEO-cdfs_2017-02-12_fullcat.fits` in which we
can look for the corresponding IDs and remove their z magnitudes in the `errfix`
catalogue.
