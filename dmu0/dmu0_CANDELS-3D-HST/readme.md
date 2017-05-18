3D-HST+CANDELS catalog
======================

This product contains the 3D-HST WFC3-selected photometric catalogs in the five
CANDELS/3D-HST fields (Skelton+, 2014).  The data was obtained querying Vizier
at http://vizier.cfa.harvard.edu/viz-bin/VizieR?-source=J/ApJS/214/24 and making
one catalogue per field.

In the original catalogue, the `ID` column is unique per field.  We created an
`ORIG_ID` column concatenating the `ID` value to the name of the 3D-HST+CANDELS
field. We are using this column to identify back to the pristine catalogue.

Here is the description of the columns. Note the strange units for the fluxes:

| Name      | Unit       | Description                                                                                                                                               |
|-----------|------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| ID        | None       | [1/50507] Sequential number (1)                                                                                                                           |
| Field     | None       | Field name ("AEGIS" "COSMOS" "GOODS-N" "GOODS-S" or "UDS")                                                                                                |
| RAJ2000   | deg        | Right ascension in decimal degrees (J2000)                                                                                                                |
| DEJ2000   | deg        | Declination in decimal degrees (J2000)                                                                                                                    |
| x         | None       | X centroid in image coordinates                                                                                                                           |
| y         | None       | Y centroid in image coordinates                                                                                                                           |
| zsp       | None       | [0/6.2]? Spectroscopic redshift from litterature (2)                                                                                                      |
| zpk       | None       | [0.01/6]? Photometric redshift from EAZY fit (z_peak)                                                                                                     |
| F140Wap   | 0.3631 uJy | [-483/47052] Flux within a 0.7" aperture in F140W zeropoint 25.0 (faper_F140W) (3) {\fg{grey50}(negative fluxes have been removed from VizieR)}           |
| e_F140Wap | 0.3631 uJy | [-483/10592] 1{sigma} error within a 0.7" aperture in F140W zeropoint 25.0 (eaper_F140W) (3) {\fg{grey50}(negative fluxes have been removed from VizieR)} |
| F160Wap   | 0.3631 uJy | [-0.3/91185]? Flux within a 0.7" aperture in F160W zeropoint 25.0 (faper_F160W) (3)                                                                       |
| e_F160Wap | 0.3631 uJy | [0.01/475]? 1{sigma} error within a 0.7" aperture in F160W zeropoint 25.0 (eaper_F160W) (3)                                                               |
| F606W     | 0.3631 uJy | [-1.4/14536]? Total flux in HST F606W zeropoint 25 (f_F606W) (3)                                                                                          |
| e_F606W   | 0.3631 uJy | [0/1.6e+21]? 1{sigma} error in F606W total flux zeropoint 25 (e_F606W) (3)                                                                                |
| F814W     | 0.3631 uJy | [-1.4/17867]? Total flux in HST F814W zeropoint 25 (f_F814W) (3)                                                                                          |
| e_F814W   | 0.3631 uJy | [0/1.9e+21]? 1{sigma} error in F814W total flux zeropoint 25 (e_F814W) (3)                                                                                |
| F125W     | 0.3631 uJy | [-0.6/114490]? Total flux in F125W zeropoint 25 (f_F125W) (3)                                                                                             |
| e_F125W   | 0.3631 uJy | [0/2481]? 1{sigma} error in F125W total flux zeropoint 25 (e_F125W) (3)                                                                                   |
| F140W     | 0.3631 uJy | [-2/66530]? Total flux in F140W zeropoint 25 (f_F140W) (3)                                                                                                |
| e_F140W   | 0.3631 uJy | [0.001/20681]? 1{sigma} error in F140W total flux zeropoint 25 (e_F140W) (3)                                                                              |
| F160W     | 0.3631 uJy | [-0.3/130810]? Total flux in F160W zeropoint 25 (f_F160W) (3)                                                                                             |
| e_F160W   | 0.3631 uJy | [0.02/8075]? 1{sigma} error in F160W total flux zeropoint 25 (e_F160W) (4)                                                                                |
| Cor       | None       | [1/1.3] Correction from AUTO to total flux based on F160W F140W (tot_cor)                                                                                 |
| Krad      | None       | [0/10.2]? KRON_RADIUS                                                                                                                                     |
| Aimg      | pix        | [0.5/154.1]? A_IMAGE semi-major axis                                                                                                                      |
| Bimg      | pix        | [0.2/71.4]? B_IMAGE semi-minor axis                                                                                                                       |
| Frad      | pix        | [-5480/13400] Circular aperture radius enclosing half the total flux (flux_radius)                                                                        |
| FWHM      | pix        | [-1.6/537]? FWHM pixels from a gaussian fit to the core (fwhm_image)                                                                                      |
| Flag      | None       | [0/23] SExtractor extraction flags measured                                                                                                               |
| f_F140W   | None       | [0/1] Set if F140W is used for the corrections to total i.e. no F160W coverage (f140w_flag) [NULL integer written as an empty string]                     |
| S/G       | None       | [0/2] Stellarity flag (star_flag) (4)                                                                                                                     |
| Use       | None       | [0/1] Flag: 1=USE 0=DON'T USE (use_phot)                                                                                                                  |
| St        | None       | [0/1] 1=Close to a star (near_star)                                                                                                                       |
| N125      | None       | [0/91] Number of individual exposures in F125W based on NEXP maps (nexp_f125w)                                                                            |
| N140      | None       | [0/84] Number of individual exposures in F140W based on NEXP maps (nexp_f140w)                                                                            |
| N160      | None       | [0/132] Number of individual exposures in F160 based on NEXP maps (nexp_f160w)                                                                            |
| logM      | [Msun]     | [-0.2/14.7]? LogMstar/Msun from FAST fit (lmass)                                                                                                          |
| Av        | mag        | [0/4]? Dust attenuation in the V-band from FAST fit                                                                                                       |
