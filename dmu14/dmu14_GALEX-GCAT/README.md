# GALEX-GCAT catalogues

This product contains the GALEX catalogues processed by the DMU14 “GALEX data”.
They are based on the GALEX GCAT catalogues: the GALEX All-Sky Source Catalogue
(GASC) and the GALEX Medium Imaging Survey Catalogue (GMSC).

More information on the GCAT is available on [the Caltech GALEX
site](http://www.galex.caltech.edu/wiki/GCAT_Manual). In particular:

> GALEX has been undertaking a number of surveys covering large areas of sky at
> a variety of depths. However making use of this large data set can be
> difficult because the standard GALEX database contains all of the detected
> sources which include many duplicate observations of the same sources as well
> as numerous spurious low signal-to-noise sources. At the same time, the sky
> footprint associated with GALEX observations has not been well defined or
> presented in an easily useable format. In order to remedy these problems, we
> have constructed two catalogues of GALEX measurements, namely the GALEX
> All-Sky Survey Source Catalog (GASC) and the GALEX Medium Imaging Survey
> Catalog (GMSC). Our intention is that these catalogues will provide the
> primary reference catalog useful for matching GALEX measurements with other
> large surveys of the sky at other wavelengths.  Covering a total of 26,300
> deg2 of sky, the GASC consists of all GALEX observations with exposure times
> below 800 sec and reaches a depth of NUV 21 (AB mag). The GMSC covers
> a smaller region of 5000 deg2 with exposure times between 800 and 10,000 sec
> and reaches a depth of NUV 23 mag.  There are a total of 40 million unique
> sources in the GASC and 22 million in the GMSC.  Each catalogues accompanied
> by exposure time, coverage and flag maps in FITS and Healpix formats.
>
> These catalogues do not contain the deepest images available for the GALEX
> deep fields. While the sky covered by these tiles is included, we have limited
> the total exposure time to 10,000 sec. Crowding becomes a significant issue
> for the depths reached in the deep fields and thus requires more careful
> treatment than what is possible using the standard GALEX pipeline source
> detection. Users interested in these regions can find the deepest co-adds from
> the MAST archive and complete their own an analysis. Currently these
> catalogues only include GALEX data up to the GR6 data release.

The pristine catalogues where downloaded and limitied to HELP coverage and are
available in `dmu0_GALEX-GCAT`.

## Catalogue processing

The GCAT catalogues were limited to HELP coverage and a `field` column was
added.  The `name` column identify uniquely each source and must be used to link
back to the original GCAT catalogue.

We kept only the position and the total NUV and FUV fluxes (and their associated
errors).  These fluxes are **not corrected for the galactic extinction**.  They
must be corrected during the datafusion process and renamed to `F_NUV`,
`Ferr_NUV`, `F_FUV`, and `FErr_FUV`.

We also kept only the sources corresponding to a good combination of flags.

### Flag selection

EXTENDED: deblending parameters in the SExtractor program correctly measure most
galaxies up to one arcminute in diameter. Galaxies larger than this will have
a larger probability of being shredded into multiple sources by the GALEX
pipeline. So that users can avoid these shredded galaxies in the catalog,  the
"EXTENDED" flag is given in the catalog for known optical sources with diameters
(typically 25th magnitude isophote optical diameters, D25) greater than 1.5
arcminute. If a source in the catalogs lies within an elliptical aperture with
major axis scaled to 1.25*D25, then EXTENDED is equal to one and zero otherwise.

—> We dropped objects with EXTENDED equal to 1

ARTIFACT_NUV, ARTIFACT_FUV: it is preconised to exclude sources with flags 2 and
3. It is also safer to exclude measures close to the edge of the field (flag=6)

—> We excluded objects with ARTIFACT=2 or 3 or 6

MANFLAG: There are additional artefacts due to bright stars lying just off of
the field-of-view that are not in general flagged by the standard GALEX
pipeline. These artefacts are in general shaped like horseshoes or long, thin
cones. The primary regions of both the GASC and GMSC were visually inspected and
these artefacts are identified. For any source that lies within one of these
flagged regions, the column MANFLAG will be set to one.  In addition bright
stars  can create thin elliptical sources somewhat resembling an edge-on galaxy
that lie perpendicular to the edge of the field-of-view. The location and shape
parameters in the catalogues are used to flag such sources. Any source that is
likely one of these artefacts will have MANFLAG set equal to two.

—> We kept only sources with MANFLAG=0

