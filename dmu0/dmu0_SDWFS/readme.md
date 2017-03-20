Spitzer Deep, Wide-Field Survey (SDWFS)
=======================================

This product contains the IRAC catalogues from the Spitzer Deep, Wide-Field
Survey (SDWFS) downloaded from IRSA. It's the updated first data release
(DR1.1).

 SDWFS is a four-epoch survey of roughly 10 square degrees of the NOAO Deep,
 Wide-Field Survey field in Bo?tes. The first visit to the field occurred very
 early in the Spitzer mission, in 2004 January, as part of the IRAC Shallow
 Survey (Eisenhardt et al. 2004). Subsequent visits to the field as part of the
 SDWFS program reimaged the same area to the same depth.

The full documentation is available at
http://irsa.ipac.caltech.edu/data/SPITZER/SDWFS/documentation/sdwfs_DR1.1.html

There are 4 catalogues corresponding to sources selected in each IRAC channel.
Each catalogue contains the magnitudes in all IRAC bands.

- sdwfs.i1: 3.6µm-selected sources (SDWFS-I1_20160531.fits);
- sdwfs.i2: 4.5µm-selected sources (SDWFS-I2_20160531.fits);
- sdwfs.i3: 5.8µm-selected sources (SDWFS-I3_20160531.fits);
- sdwfs.i4: 8.0µm-selected sources (SDWFS-I4_20160531.fits).

We ingested the only “total coadd” catalogues, not the individual epoch ones.

These catalogues cover the Böotes field. We did not limit them to HELP (SPIRE
based) coverage as only a few parts of the IRAC coverage is not on the SPIRE
one.

We added a column internal_id identifying uniquely each source. Please, use it
when crossmatching the catalogue.

# Master-list selected catalogue

`SDWFS_MLselected_20160801.fits` is the masterlist selected version of the 3.6μm
selected SDWFS catalogue. It has been cleaned from duplicates and limited to the
HELP field. The help_id column makes the link with the HELP masterlist. Please
use this identifier while crossmatching.
