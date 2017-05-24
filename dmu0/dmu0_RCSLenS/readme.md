Red Cluster Sequence Lensing Survey (RCSLenS) catalogue
=======================================================

These catalogues were queried on the [RCSLenS catalog query
page](http://www.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/en/community/rcslens/query.html).
As the survey is quite large (more that 70 million sources) we first queried
only the position of all the sources to generate a MOC (`RCSLenS_MOC.fits`) for
all the survey.  The we compared it to HELP coverage:

|      Field       |Coverage|
|------------------|-------:|
|            COSMOS|     0.0|
|           GAMA-15|     0.0|
|           XMM-LSS|     0.0|
|            Bootes|     0.0|
|        CDFS-SWIRE|     0.0|
|          ELAIS-N1|   100.0|
|           GAMA-12|     0.0|
|           GAMA-09|     0.0|
|     Lockman-SWIRE|    95.2|
|               EGS|     0.0|
|          ELAIS-S1|     0.0|
|         AKARI-NEP|     0.0|
|          ELAIS-N2|    84.6|
|              xFLS|     0.0|
|Herschel-Stripe-82|    37.0|
|               NGP|     0.0|
|               SGP|     0.0|
|         AKARI-SEP|     0.0|
|         SPIRE-NEP|     0.0|
|              SSDF|     0.0|
|             HDF-N|     0.0|
|              SA13|     0.0|
|          XMM-13hr|     0.0|
|           __ALL__|    13.9|

We then queried the database for ELAIS-N1, Lockman-SWIRE, ELAIS-N2, and
Herschel-Stripe-82 with these queries:

```sql
# ELAIS-N1
SELECT * FROM cfht.rcslens
WHERE ALPHA_J2000 BETWEEN 237.9 AND 247.9 AND DELTA_J2000 BETWEEN 52.37 AND 57.59

# Lockman-SWIRE
SELECT * FROM cfht.rcslens
WHERE ALPHA_J2000 BETWEEN 154.7 AND 167.8 AND DELTA_J2000 BETWEEN 54.95 AND 60.89

# ELAIS-N2
SELECT * FROM cfht.rcslens
WHERE ALPHA_J2000 BETWEEN 246.1 AND 252.3 AND DELTA_J2000 BETWEEN 39.02 AND 43.02

# Herschel-Stripe-82
SELECT * FROM cfht.rcslens
WHERE
(
 ((ALPHA_J2000 >= 348.3 OR ALPHA_J2000 <= 19.1) AND DELTA_J2000 BETWEEN -9.5 AND 9.25)
 OR
 ALPHA_J2000 BETWEEN 13.4 AND 36.3 AND DELTA_J2000 BETWEEN -2.32 AND 2.49
) AND ALPHA_J2000 < 180 AND DELTA_J2000 >= 0

SELECT * FROM cfht.rcslens
WHERE
(
 ((ALPHA_J2000 >= 348.3 OR ALPHA_J2000 <= 19.1) AND DELTA_J2000 BETWEEN -9.5 AND 9.25)
 OR
 ALPHA_J2000 BETWEEN 13.4 AND 36.3 AND DELTA_J2000 BETWEEN -2.32 AND 2.49
) AND ALPHA_J2000 < 180 AND DELTA_J2000 < 0

SELECT * FROM cfht.rcslens
WHERE
(
 ((ALPHA_J2000 >= 348.3 OR ALPHA_J2000 <= 19.1) AND DELTA_J2000 BETWEEN -9.5 AND 9.25)
 OR
 ALPHA_J2000 BETWEEN 13.4 AND 36.3 AND DELTA_J2000 BETWEEN -2.32 AND 2.49
) AND ALPHA_J2000 >= 180 AND DELTA_J2000 >= 0

SELECT * FROM cfht.rcslens
WHERE
(
 ((ALPHA_J2000 >= 348.3 OR ALPHA_J2000 <= 19.1) AND DELTA_J2000 BETWEEN -9.5 AND 9.25)
 OR
 ALPHA_J2000 BETWEEN 13.4 AND 36.3 AND DELTA_J2000 BETWEEN -2.32 AND 2.49
) AND ALPHA_J2000 >= 180 AND DELTA_J2000 < 0
```

The resulting files were processed by `filterAndTag.sh` to keep only the sources
on HELP coverage.

## Description of the columns taken from the output VO-table

| Name             | Description                                                                                           |
|------------------|-------------------------------------------------------------------------------------------------------|
| id               | Unique identifier                                                                                     |
| pos              | PGsphere position                                                                                     |
| SeqNr            | Running object number                                                                                 |
| KRON_RADIUS      | Kron radius in units of A or B                                                                        |
| BackGr           | Background at centroid position [counts]                                                              |
| Level            | Detection threshold above background [counts]                                                         |
| MU_THRESHOLD     | Detection threshold above background [mag x arcsec^-2]                                                |
| MaxVal           | Peak flux above background [counts]                                                                   |
| MU_MAX           | Peak surface brightness above background [mag x arcsec^-2]                                            |
| ISOAREA_WORLD    | Isophotal area above Analysis threshold [deg^2]                                                       |
| Xpos             | Object position along x in the MegaCAM pointing (non unique) [pixel]                                  |
| Ypos             | Object position along y in the MegaCAM pointing (non unique) [pixel]                                  |
| ALPHA_J2000      | Right ascension of barycenter (J2000) [deg]                                                           |
| DELTA_J2000      | Declination of barycenter (J2000) [deg]                                                               |
| A_WORLD          | Profile RMS along major axis (world units) [deg]                                                      |
| B_WORLD          | Profile RMS along minor axis (world units) [deg]                                                      |
| THETA_J2000      | Position angle (east of north) (J2000) [deg]                                                          |
| ERRA_WORLD       | error of A_WORLD [deg]                                                                                |
| ERRB_WORLD       | error of B_WORLD [deg]                                                                                |
| ERRTHETA_J2000   | error of THETA_J2000 [deg]                                                                            |
| FWHM_IMAGE       | FWHM assuming a Gaussian core [pixel]                                                                 |
| FWHM_WORLD       | FWHM assuming a Gaussian core [pixel]                                                                 |
| Flag             | Extraction flags                                                                                      |
| FLUX_RADIUS      | Half light radius [pixel]                                                                             |
| CLASS_STAR       | SExtractor S/G classifier output                                                                      |
| E_B_V            | E_(B-V) at the objects position from SFD98 maps [mag]                                                 |
| IMAFLAGS_ISO_r   | FLAG-image flags ORed over the iso. profile- r-band                                                   |
| MAG_LIM_r        | 1-sigma limiting magnitude in the r-band [mag]                                                        |
| EXTINCTION_r     | Galactic dust absorption in the r-band from SFD98 [mag]                                               |
| IMAFLAGS_ISO_y   | FLAG-image flags ORed over the iso. profile- y-band                                                   |
| MAG_LIM_y        | 1-sigma limiting magnitude in the y-band [mag]                                                        |
| EXTINCTION_y     | Galactic dust absorption in the y-band from SFD98 [mag]                                               |
| IMAFLAGS_ISO_z   | FLAG-image flags ORed over the iso. profile- z-band                                                   |
| MAG_LIM_z        | 1-sigma limiting magnitude in the z-band [mag]                                                        |
| EXTINCTION_z     | Galactic dust absorption in the z-band from SFD98 [mag]                                               |
| e1               | Lensfit galaxy e1 expectation value                                                                   |
| e2               | Lensfit galaxy e2 expectation value                                                                   |
| weight           | Lensfit inverse variance shear weight                                                                 |
| fitclass         | Lensfit fit class                                                                                     |
| size             | Lensfit galaxy model scalelength [pixel]                                                              |
| bulge_fraction   | Lensfit galaxy model bulge-fraction B/T                                                               |
| model_flux       | Lensfit galaxy model flux                                                                             |
| SNratio          | Lensfit data S/N ratio                                                                                |
| fit_probability  | Lensfit fit probability                                                                               |
| PSF_e1           | Lensfit PSF model mean ellipticity e1                                                                 |
| PSF_e2           | Lensfit PSF model mean ellipticity e2                                                                 |
| PSF_Strehl_ratio | Lensfit PSF model mean pseudo-Strehl ratio                                                            |
| n_exposures_used | Number of exposures used in lensfit measurements                                                      |
| MAG_r            | Magnitude in the r-band [mag]                                                                         |
| MAG_y            | Magnitude in the y-band [mag]                                                                         |
| MAG_z            | Magnitude in the z-band [mag]                                                                         |
| MAGERR_r         | Magnitude error in the r-band [mag]                                                                   |
| MAGERR_y         | Magnitude error in the y-band [mag]                                                                   |
| MAGERR_z         | Magnitude error in the z-band                                                                         |
| MASK             | RCSLenS mask value at the objects position                                                            |
| m                | Multiplicative shear calibration                                                                      |
| SG_FLAG          | RCSLenS S/G classifier                                                                                |
| c1_DP            | Additive shear bias correction for e1- 2nd pass                                                       |
| c2_DP            | Additive shear bias correction for e2- 2nd pass                                                       |
| PZ_full          | Vector containing the posterior photo-z probability in steps of Delta_z=0.05                          |
| c1_NB            | Additive shear bias correction for e1- 1st pass                                                       |
| c2_NB            | Additive shear bias correction for e2- 1st pass                                                       |
| MAG_LIM_g        | 1-sigma limiting magnitude in the g-band [mag]                                                        |
| EXTINCTION_g     | Galactic dust absorption in the g-band from SFD98 [mag]                                               |
| MAG_g            | Magnitude in the g-band [mag]                                                                         |
| MAGERR_g         | Magnitude error in the g-band                                                                         |
| IMAFLAGS_ISO_g   | FLAG-image flags ORed over the iso. profile- g-band                                                   |
| MAG_LIM_i        | 1-sigma limiting magnitude in the i-band [mag]                                                        |
| EXTINCTION_i     | Galactic dust absorption in the i-band from SFD98 [mag]                                               |
| MAG_i            | Magnitude in the i-band [mag]                                                                         |
| MAGERR_i         | Magnitude error in the i-band [mag]                                                                   |
| IMAFLAGS_ISO_i   | FLAG-image flags ORed over the iso. profile- i-band                                                   |
| Z_B              | BPZ redshift estimate; peak of the posterior redshift probability distribution                        |
| Z_B_MIN          | Lower bound of the 95% confidence interval of Z_B                                                     |
| Z_B_MAX          | Upper bound of the 95% confidence interval of Z_B                                                     |
| T_B              | Spectral type corresponding to Z_B                                                                    |
| ODDS             | Empirical odds of Z_B                                                                                 |
| Z_ML             | BPZ maximum likelihood redshift                                                                       |
| T_ML             | Spectral type corresponding to Z_B                                                                    |
| CHI_SQUARED_BPZ  | Chi^2 value associated with Z_B                                                                       |
| BPZ_FILT         | Filters with good photometry (BPZ); bit-coded mask                                                    |
| NBPZ_FILT        | Number of filters with good photometry (BPZ)                                                          |
| BPZ_NONDETFILT   | Filters with faint photometry (not used by BPZ); bit-coded mask                                       |
| NBPZ_NONDETFILT  | Number of filters with faint photometry (not used by BPZ)                                             |
| BPZ_FLAGFILT     | Filters with flagged photometry (not used by BPZ); bit-coded mask                                     |
| NBPZ_FLAGFILT    | Number of filters with flagged photometry (not used by BPZ)                                           |
| LP_kcor_g        | k-correction in the MegaCam g-band (estimated with LePhare) [mag]                                     |
| LP_kcor_r        | k-correction in the MegaCam r-band (estimated with LePhare) [mag]                                     |
| LP_kcor_i        | k-correction in the MegaCam i-band (estimated with LePhare) [mag]                                     |
| LP_kcor_y        | k-correction in the MegaCam y-band (estimated with LePhare) [mag]                                     |
| LP_kcor_z        | k-correction in the MegaCam z-band (estimated with LePhare) [mag]                                     |
| LP_Mg            | Absolute rest-frame magnitude in the MegaCam g-band (estimated with LePhare) [mag]                    |
| LP_Mr            | Absolute rest-frame magnitude in the MegaCam r-band (estimated with LePhare) [mag]                    |
| LP_Mi            | Absolute rest-frame magnitude in the MegaCam i-band (estimated with LePhare) [mag]                    |
| LP_My            | Absolute rest-frame magnitude in the MegaCam y-band (estimated with LePhare) [mag]                    |
| LP_Mz            | Absolute rest-frame magnitude in the MegaCam z-band (estimated with LePhare) [mag]                    |
| LP_log10_SM_MED  | Logarithm of the stellar mass (estimated with LePhare) [log_10(M_sun)]                                |
| LP_log10_SM_INF  | Lower bound of the logarithm of the stellar mass (estimated with LePhare) [log_10(M_sun)]             |
| LP_log10_SM_SUP  | Upper bound of the logarithm of the stellar mass (estimated with LePhare) [log_10(M_sun)]             |
| LP_log10_SFR_MED | Logarithm of the star formation rate (estimated with LePhare) [log_10(M_sun/year)]                    |
| LP_log10_SFR_INF | Upper bound of the logarithm of the star formation rate (estimated with LePhare) [log_10(M_sun/year)] |
| LP_log10_SFR_SUP | Lower bound of the logarithm of the star formation rate (estimated with LePhare) [log_10(M_sun/year)] |
