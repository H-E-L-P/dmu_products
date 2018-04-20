Hyper Suprime-Cam Subaru Strategic Program Catalogues - Public Data Release 1 (PDR1)
====================================================================================

The catalogues are downloaded from the [Hyper Suprime-Cam Subaru Strategic
Program Public Data Release 1](https://hsc-release.mtk.nao.ac.jp/doc/) using the
[Freeform SQL
Query](https://hsc-release.mtk.nao.ac.jp/datasearch/catalog_jobs/new) and the
query below.

The HSC SSP Survey Paper is [Aihara et al.
2017a](https://arxiv.org/abs/1704.05858).

We downloaded the photometry and flags contained in the *forced* photometric
catalogue and some flags contained in the *afterbuner* catalogue. The *junk
suppression* algorithm was in fact mistakenly left disabled in the main *forced*
photometry processing, but it was turned on in the *afterburner* processing. We
therefore join the afterburner catalogue to the main forced photometry catalogue
to recover this information.

The description of the columns is available
[here](https://hsc-release.mtk.nao.ac.jp/schema/)

We limited the queries to sources flagged as `detect_is_primary` to remove
duplicates.

The ‘hsc-ssp-pdr1-forced-afterburner-20170526’ catalogue contains all primary
detection sources in PDR1 (both good and possible spurious sources). We then
create a catalogue named *hsc-ssp-pdr1-forced-afterburner-20170526-plus*
**(which is the one released)** using the stilts procedure reported below. In
the released *plus* catalogue we created a flag named `CleanPhotoFlag` for each
band.  This flag can be used to eliminate spurious objects and is based on
a combination of flags/reccomandation described in the PDR1 data release paper
[Aihara et al. 2017b](https://arxiv.org/abs/1702.08449).

For most sources, the reference band is the i-band; for sources not detected (or
low signal-to-noise) in i, the reference band is r, then z, y, g, and narrow
bands. To delete most of the spurious sources in the released catalogue we kept
only those sources with clean photometry in EITHER band i OR in band r.

The users are advised to select objects with `CleanPhotoFlag = 1` to ensure
a clean photometry in each band. This flag takes into account most of the known
features contained in the PDR1 catalogue, but please check the notes below for
more information about other known features that we decided to not include in
our `CleanPhotoFlag` filter.

## NOTES AND KNOWN POSSIBLE FEATURES:

**REFERENCE BAND DEFINITION**: After measuring the coadds for each band
independently, they select a “reference band” for each source. For most sources,
this is the i-band; for sources not detected (or low signal-to-noise) in i, they
use r, then z, y, g, and narrow bands. They then measure “forced” photometry in
the coadds in all bands, in which positions and shapes are held fixed at their
values from the reference band and only amplitudes (i.e. fluxes) are allowed to
vary. This consistent photometry across bands produces their best estimates of
colors (Aihara et al. 2017).

**MAGNITUDE LIMITS**: Our `CleanPhotoFlag` does not filter for faint sources or
below the magnitude limits, but the users are advised to check the magnitude
limits in each band and relative errors to clean for bad photometry. The
magnitude limits for each survey tier are available
[here](https://hsc-release.mtk.nao.ac.jp/doc/).

**BRIGHT OBJECTS** : bright objects with possibly bad photometric measurements
can be identified using the *flags_pixel_bright_object_center*. We decided to
not eliminate these sources using our CleanPhotoFlag as often nearby bright
galaxies are misinterpreted as stars by this flag. About 8% of bright objects (<
17.5 mag in one of gri bands) are actually galaxies and they would be masked out
by using these flags.

**JUNKS** : Our `CleanPhotoFlag` select objects that are defined as NO JUNK in
the afterburner catalog.

**ALGORITHM FAILURES**: Our `CleanPhotoFlag` does eliminate cases in which the
centroids measurements failed (this is done using the centroid_sdss_flags),
however does not flag/eliminate entries in which the PDF, KRON or CModel flux
measurements failed. Users who want to use these specific measurements are
advised to remove these failures using the flags `flux_psf_flags`,
`flux_kron_flags` and `flux_cmodel_flags` in each band.

## SQL QUERIES

1. *EXAMPLE FOR DEEP/ULTRADEEP SURVEY (to download other fields and/or survey
   tier the user has to uncomment the line associated to the field and survey
   tier of interest and comment the others)*

```sql
SELECT
  object_id, ra, dec,
  -- Magnitudes
  gmag_aperture30, rmag_aperture30, imag_aperture30, zmag_aperture30, ymag_aperture30, n921mag_aperture30, n816mag_aperture30,
  gmag_aperture30_err, rmag_aperture30_err, imag_aperture30_err, zmag_aperture30_err, ymag_aperture30_err, n921mag_aperture30_err, n816mag_aperture30_err,
  gmag_kron, rmag_kron, imag_kron, zmag_kron, ymag_kron, n921mag_kron, n816mag_kron,
  gmag_kron_err, rmag_kron_err, imag_kron_err, zmag_kron_err, ymag_kron_err, n921mag_kron_err, n816mag_kron_err,
  gmag_psf, rmag_psf, imag_psf, zmag_psf, ymag_psf, n921mag_psf, n816mag_psf,
  gmag_psf_err, rmag_psf_err, imag_psf_err, zmag_psf_err, ymag_psf_err, n921mag_psf_err, n816mag_psf_err,
  gcmodel_mag, rcmodel_mag, icmodel_mag, zcmodel_mag, ycmodel_mag, n921cmodel_mag, n816cmodel_mag,
  gcmodel_mag_err, rcmodel_mag_err, icmodel_mag_err, zcmodel_mag_err, ycmodel_mag_err, n921cmodel_mag_err, n816cmodel_mag_err,
  -- extension measurement
  gflux_kron_radius, rflux_kron_radius, iflux_kron_radius, zflux_kron_radius, yflux_kron_radius, n921flux_kron_radius, n816flux_kron_radius,
  -- Extendedness flags or star/galaxy separation flag
  gclassification_extendedness, rclassification_extendedness, iclassification_extendedness, zclassification_extendedness, yclassification_extendedness, n921classification_extendedness, n816classification_extendedness,
  -- Series of photometric flags
  gflags_pixel_offimage, rflags_pixel_offimage, iflags_pixel_offimage, zflags_pixel_offimage, yflags_pixel_offimage,n921flags_pixel_offimage, n816flags_pixel_offimage,
  gflags_pixel_bright_object_center, rflags_pixel_bright_object_center, iflags_pixel_bright_object_center, zflags_pixel_bright_object_center, yflags_pixel_bright_object_center,n921flags_pixel_bright_object_center, n816flags_pixel_bright_object_center,
  gflags_pixel_bright_object_any, rflags_pixel_bright_object_any, iflags_pixel_bright_object_any, zflags_pixel_bright_object_any, yflags_pixel_bright_object_any,n921flags_pixel_bright_object_any, n816flags_pixel_bright_object_any,
  -- flags recommended for filtering spurious sources; Table 4 PDR1 survey paper (Aihara et al. 2017)
  gflags_pixel_interpolated_center, rflags_pixel_interpolated_center, iflags_pixel_interpolated_center, zflags_pixel_interpolated_center, yflags_pixel_interpolated_center,n921flags_pixel_interpolated_center, n816flags_pixel_interpolated_center,
  gflags_pixel_interpolated_any, rflags_pixel_interpolated_any, iflags_pixel_interpolated_any, zflags_pixel_interpolated_any, yflags_pixel_interpolated_any,n921flags_pixel_interpolated_any, n816flags_pixel_interpolated_any,
  gflags_pixel_saturated_center, rflags_pixel_saturated_center, iflags_pixel_saturated_center, zflags_pixel_saturated_center, yflags_pixel_saturated_center,n921flags_pixel_saturated_center, n816flags_pixel_saturated_center,
  gflags_pixel_saturated_any, rflags_pixel_saturated_any, iflags_pixel_saturated_any, zflags_pixel_saturated_any, yflags_pixel_saturated_any,n921flags_pixel_saturated_any, n816flags_pixel_saturated_any,
  gflux_kron_flags, rflux_kron_flags, iflux_kron_flags, zflux_kron_flags, yflux_kron_flags,n921flux_kron_flags, n816flux_kron_flags,
  gflux_psf_flags, rflux_psf_flags, iflux_psf_flags, zflux_psf_flags, yflux_psf_flags,n921flux_psf_flags, n816flux_psf_flags,
  gcmodel_flux_flags, rcmodel_flux_flags, icmodel_flux_flags, zcmodel_flux_flags, ycmodel_flux_flags,n921cmodel_flux_flags, n816cmodel_flux_flags,
  -- flags included in the "clean photometry" set query (of these only *centroid_sdss_flags, *pixel_edge, *pixel_cr_any, *pixel_bad flags are used in our filtering; parent_id is not used)
  gcentroid_sdss_flags, rcentroid_sdss_flags, icentroid_sdss_flags, zcentroid_sdss_flags, ycentroid_sdss_flags,n921centroid_sdss_flags, n816centroid_sdss_flags,
  gflags_pixel_edge, rflags_pixel_edge, iflags_pixel_edge, zflags_pixel_edge, yflags_pixel_edge,n921flags_pixel_edge, n816flags_pixel_edge,
  gflags_pixel_cr_any, rflags_pixel_cr_any, iflags_pixel_cr_any, zflags_pixel_cr_any, yflags_pixel_cr_any,n921flags_pixel_cr_any, n816flags_pixel_cr_any,
  gflags_pixel_bad, rflags_pixel_bad, iflags_pixel_bad, zflags_pixel_bad, yflags_pixel_bad, n921flags_pixel_bad, n816flags_pixel_bad,
  parent_id,
  -- the following flags are not downloaded because they are included in the selection here applied for primary objects
  -- detect_is_patch_inner, detect_is_tract_inner, deblend_nchild, detect_is_primary,
  -- Afterburner quantities (left joined to forced photometry) to eliminate "junk"; the junk detection algorithm was turned off in the forced photometry production
  object_id, gdetected_notjunk, gchild_flux_convolved_flag, rdetected_notjunk, rchild_flux_convolved_flag, idetected_notjunk, ichild_flux_convolved_flag, zdetected_notjunk, zchild_flux_convolved_flag, ydetected_notjunk, ychild_flux_convolved_flag, n921detected_notjunk, n921child_flux_convolved_flag, n816detected_notjunk, n816child_flux_convolved_flag
FROM
  -- from forced photometry catalogue (recommended)
  -- uncomment the survey tier of interest and comment the other
  -- UDEEP SURVEY (in PDR1 available in COSMOS and SXDS)
  -- pdr1_udeep.forced
  -- DEEP SURVEY (in PDR1 available in ELAIS-N1, XMM-LSS, E(xtended)-COSMOS, DEEP2-3)
  pdr1_deep.forced
  -- uncomment the survey tier of interest and comment the other
  -- LEFT JOIN pdr1_udeep.afterburner USING(object_id)
  LEFT JOIN pdr1_deep.afterburner USING(object_id)
  WHERE
  -- uncomment the field and survey tier of interest and comment the others
  -- pdr1_udeep.search_cosmos(object_id)
  -- pdr1_udeep.search_sxds(object_id)
  pdr1_deep.search_elais_n1(object_id)
  -- pdr1_deep.search_xmm_lss(object_id)
  -- pdr1_deep.search_cosmos(object_id)
  -- pdr1_deep.search_deep2_3(object_id)
  -- WE keep only primary detection to avoid duplicates
  AND detect_is_primary
```

2. *EXAMPLE FOR WIDE SURVEY (to download other fields the user has to uncomment
   the line associated to the field of interest and comment the others)*

```sql
SELECT
  object_id, ra, dec,
  -- Magnitudes
  gmag_aperture30, rmag_aperture30, imag_aperture30, zmag_aperture30, ymag_aperture30,
  gmag_aperture30_err, rmag_aperture30_err, imag_aperture30_err, zmag_aperture30_err, ymag_aperture30_err,
  gmag_kron, rmag_kron, imag_kron, zmag_kron, ymag_kron,
  gmag_kron_err, rmag_kron_err, imag_kron_err, zmag_kron_err, ymag_kron_err,
  gmag_psf, rmag_psf, imag_psf, zmag_psf, ymag_psf,
  gmag_psf_err, rmag_psf_err, imag_psf_err, zmag_psf_err, ymag_psf_err,
  gcmodel_mag, rcmodel_mag, icmodel_mag, zcmodel_mag, ycmodel_mag,
  gcmodel_mag_err, rcmodel_mag_err, icmodel_mag_err, zcmodel_mag_err, ycmodel_mag_err,
  -- extension measurement
  gflux_kron_radius, rflux_kron_radius, iflux_kron_radius, zflux_kron_radius, yflux_kron_radius,
  -- Extendedness flags or star/galaxy separation flag
  gclassification_extendedness, rclassification_extendedness, iclassification_extendedness, zclassification_extendedness, yclassification_extendedness,
  -- Series of photometric flags
  gflags_pixel_offimage, rflags_pixel_offimage, iflags_pixel_offimage, zflags_pixel_offimage, yflags_pixel_offimage,
  gflags_pixel_bright_object_center, rflags_pixel_bright_object_center, iflags_pixel_bright_object_center, zflags_pixel_bright_object_center, yflags_pixel_bright_object_center,
  gflags_pixel_bright_object_any, rflags_pixel_bright_object_any, iflags_pixel_bright_object_any, zflags_pixel_bright_object_any, yflags_pixel_bright_object_any,
  -- flags recommended for filtering spurious sources; Table 4 PDR1 survey paper (Aihara et al. 2017)
  gflags_pixel_interpolated_center, rflags_pixel_interpolated_center, iflags_pixel_interpolated_center, zflags_pixel_interpolated_center, yflags_pixel_interpolated_center,
  gflags_pixel_interpolated_any, rflags_pixel_interpolated_any, iflags_pixel_interpolated_any, zflags_pixel_interpolated_any, yflags_pixel_interpolated_any,
  gflags_pixel_saturated_center, rflags_pixel_saturated_center, iflags_pixel_saturated_center, zflags_pixel_saturated_center, yflags_pixel_saturated_center,
  gflags_pixel_saturated_any, rflags_pixel_saturated_any, iflags_pixel_saturated_any, zflags_pixel_saturated_any, yflags_pixel_saturated_any,
  gflux_kron_flags, rflux_kron_flags, iflux_kron_flags, zflux_kron_flags, yflux_kron_flags,
  gflux_psf_flags, rflux_psf_flags, iflux_psf_flags, zflux_psf_flags, yflux_psf_flags,
  gcmodel_flux_flags, rcmodel_flux_flags, icmodel_flux_flags, zcmodel_flux_flags, ycmodel_flux_flags,
  -- flags included in the "clean photometry" set query (of these only *centroid_sdss_flags, *pixel_edge, *pixel_cr_any, *pixel_bad flags are used in our filtering; parent_id is not used)
  gcentroid_sdss_flags, rcentroid_sdss_flags, icentroid_sdss_flags, zcentroid_sdss_flags, ycentroid_sdss_flags,
  gflags_pixel_edge, rflags_pixel_edge, iflags_pixel_edge, zflags_pixel_edge, yflags_pixel_edge,
  gflags_pixel_cr_any, rflags_pixel_cr_any, iflags_pixel_cr_any, zflags_pixel_cr_any, yflags_pixel_cr_any,
  gflags_pixel_bad, rflags_pixel_bad, iflags_pixel_bad, zflags_pixel_bad, yflags_pixel_bad,
  parent_id,
  -- the following flags are not downloaded because they are included in the selection here applied for primary objects
  -- detect_is_patch_inner, detect_is_tract_inner, deblend_nchild, detect_is_primary,
  -- Afterburner quantities (left joined to forced photometry) to eliminate "junk"; the junk detection algorithm was turned off in the forced photometry production
  object_id, gdetected_notjunk, gchild_flux_convolved_flag, rdetected_notjunk, rchild_flux_convolved_flag, idetected_notjunk, ichild_flux_convolved_flag, zdetected_notjunk, zchild_flux_convolved_flag, ydetected_notjunk, ychild_flux_convolved_flag
FROM
  -- from forced photometry catalogue (recommended)
  -- WIDE SURVEY (in PDR1 available in AEGIS, XMM-LSS,GAMA9H, WIDE12H, GAMA15H, HECTOMAP, VVDS)
  pdr1_wide.forced
  LEFT JOIN pdr1_wide.afterburner USING(object_id)
  WHERE
  -- uncomment the field of interest and comment the others
  pdr1_wide.search_xmm_lss(object_id)
  -- pdr1_wide.search_aegis(object_id)
  -- pdr1_wide.search_gama9h(object_id)
  -- pdr1_wide.search_wide12h(object_id)
  -- pdr1_wide.search_gama15h(object_id)
  -- pdr1_wide.search_hectomap(object_id)
  -- pdr1_wide.search_vvds(object_id)
  -- WE keep only primary detection because recommended
  AND detect_is_primary
```

## SCRIPT to create the released catalogue
(example for en1, but the same for all the other fields/surveys)

```shell
$ stilts tpipe in=en1-deep-hsc-ssp-pdr1-forced-afterburner-20170526.fits.gz \
       cmd='addcol "gCLeanPhotoFlag" "( gflags_pixel_edge || gflags_pixel_saturated_center || gflags_pixel_offimage || gflags_pixel_interpolated_center || gflags_pixel_cr_any || gflags_pixel_bad || gcentroid_sdss_flags || gcentroid_sdss_flags || !(gdetected_notjunk) ) ? 0 : 1"' \
       cmd='addcol "rCLeanPhotoFlag" "( rflags_pixel_edge || rflags_pixel_saturated_center || rflags_pixel_offimage || rflags_pixel_interpolated_center || rflags_pixel_cr_any || rflags_pixel_bad || rcentroid_sdss_flags || rcentroid_sdss_flags || !(rdetected_notjunk) ) ? 0 : 1"' \
       cmd='addcol "iCLeanPhotoFlag" "( iflags_pixel_edge || iflags_pixel_saturated_center || iflags_pixel_offimage || iflags_pixel_interpolated_center || iflags_pixel_cr_any || iflags_pixel_bad || icentroid_sdss_flags || icentroid_sdss_flags || !(idetected_notjunk) ) ? 0 : 1"' \
       cmd='addcol "zCLeanPhotoFlag" "( zflags_pixel_edge || zflags_pixel_saturated_center || zflags_pixel_offimage || zflags_pixel_interpolated_center || zflags_pixel_cr_any || zflags_pixel_bad || zcentroid_sdss_flags || zcentroid_sdss_flags || !(zdetected_notjunk) ) ? 0 : 1"' \
       cmd='addcol "yCLeanPhotoFlag" "( yflags_pixel_edge || yflags_pixel_saturated_center || yflags_pixel_offimage || yflags_pixel_interpolated_center || yflags_pixel_cr_any || yflags_pixel_bad || ycentroid_sdss_flags || ycentroid_sdss_flags || !(ydetected_notjunk) ) ? 0 : 1"' \
       cmd='addcol "n921CLeanPhotoFlag" "( n921flags_pixel_edge || n921flags_pixel_saturated_center || n921flags_pixel_offimage || n921flags_pixel_interpolated_center || n921flags_pixel_cr_any || n921flags_pixel_bad || n921centroid_sdss_flags || n921centroid_sdss_flags || !(n921detected_notjunk) ) ? 0 : 1"' \
       cmd='addcol "n816CLeanPhotoFlag" "( n816flags_pixel_edge || n816flags_pixel_saturated_center || n816flags_pixel_offimage || n816flags_pixel_interpolated_center || n816flags_pixel_cr_any || n816centroid_sdss_flags || n816centroid_sdss_flags || !(n816detected_notjunk) ) ? 0 : 1"' \
       cmd='select "iCleanPhotoFlag == 1 || rCleanPhotoFlag ==1 "' \
       out=en1-deep-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits ofmt=fits
```

## Ingestion notes

The catalogues were limited to HELP coverage and renamed according to field
names:

| Original file                                                       | New file                              |
|---------------------------------------------------------------------|---------------------------------------|
| aegis-wide-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz    | HSC-PDR1_wide_EGS.fits                |
| cosmos-deep-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz   | HSC-PDR1_deep_COSMOS.fits             |
| cosmos-udeep-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz  | HSC-PDR1_uDeep_COSMOS.fits            |
| deep2-3-deep-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz  | HSC-PDR1_deep_Herschel-Stripe-82.fits |
| elais-n1-deep-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz | HSC-PDR1_deep_ELAIS-N1.fits           |
| gama09h-wide-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz  | HSC-PDR1_wide_GAMA-09.fits            |
| gama15h-wide-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz  | HSC-PDR1_wide_GAMA-15.fits            |
| hectomap-wide-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz | **NOT ON HELP COVERAGE**              |
| sxds-udeep-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz    | HSC-PDR1_uDeep_XMM-LSS.fits           |
| vvds-wide-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz     | **NOT ON HELP COVERAGE**              |
| wide12h-wide-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz  | HSC-PDR1_wide_GAMA-12.fits            |
| xmm-lss-deep-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz  | HSC-PDR1_deep_XMM-LSS.fits            |
| xmm-lss-wide-hsc-ssp-pdr1-forced-afterburner-20170526-plus.fits.gz  | HSC-PDR1_wide_XMM-LSS.fits            |

Some columns are associated to a column with the same name with *_isnull*
added. For float columns, we've set their content to NaN when the value of the
isnull column is true and we removed the isnull column.

On 2017-06-20, the data was updated with a new extraction containing more
aperture fluxes (for aperture correction). The SQL queries above were not
updated.

On 2017-10-23, the data was updated to correct a wrong extraction in the wide
fields.  The catalogue names where changed to append v2 to them.
