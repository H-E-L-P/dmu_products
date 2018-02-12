# CDFS SWIRE Photometric Redshifts - V1 (20180211)

CDFS-SWIRE/master_catalogue_cdfs-swire_20171103_photoz_20180210.fits

## Key information

#### Masterlist used:
dmu1/dmu1_ml_CDFS-SWIRE/data/master_catalogue_cdfs-swire_20170801.fits

#### Spectroscopic redshift sample used:
dmu23/dmu23_CDFS-SWIRE/data/CDFS_SWIRE-specz-v2.3.fits

#### Templates used:

- EAZY Default
- Atlas of Galaxy SEDs (Brown et al. 2014)
- XMM-COSMOS Template library

#### Filters used (Templates):

| Telescope / Instrument | Filter         | Available | Used |
|------------------------|----------------|-----------|------|
| VST/OmegaCam           | omegacam_u     | Yes    | Yes   |
| VST/OmegaCam           | omegacam_g     | Yes    | Yes   |
| VST/OmegaCam           | omegacam_r     | Yes    | Yes   |
| VST/OmegaCam           | omegacam_i     | Yes    | Yes   |
| VST/OmegaCam           | omegacam_z     | Yes    | Yes   |
| Pan-STARRS1/Pan-STARRS1| gpc1_g         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_r         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_i         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_z         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_y         | Yes    | No   |
| VISTA/VIRCAM           | vircam_z       | Yes    | Yes   |
| VISTA/VIRCAM           | vircam_y       | Yes    | Yes   |
| VISTA/VIRCAM           | vircam_j       | Yes    | Yes   |
| VISTA/VIRCAM           | vircam_h       | Yes    | Yes   |
| VISTA/VIRCAM           | vircam_k       | Yes    | Yes   |
| Spitzer/IRAC           | i1             | Yes    | Yes   |
| Spitzer/IRAC           | i2             | Yes    | Yes   |
| Spitzer/IRAC           | i3             | Yes    | Yes   |
| Spitzer/IRAC           | i4             | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_u          | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_b          | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_v          | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_r          | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_416nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_461nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_485nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_518nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_571nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_604nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_646nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_696nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_753nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_815nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_856nm      | Yes    | Yes   |
| MPG/ESO 2.2-m / WFI    | wfi_914nm      | Yes    | Yes   |


#### Additional Machine Learning Estimates

For the main galaxy population, three additional Gaussian Process machine learning estimates were also incorporated into the Bayesian combination estimates. These were training using the combined spectroscopic sample of all three GAMA fields - with cost-sensitive learning weights calibrated for each specific field.
The three sets of filters used were:
- PS1 g, r, i, z
- PS1 g, r, i, z + VISTA/VIRCAM J and Ks


#### Additional selections applied:
 - In order to have a fully calibrated redshift estimate, sources must have a magnitude measurement in any of the optical r-bands.
 - Sources must also be detected in 4 bands at different wavelengths for a redshift to have been estimated (i.e. multiple r-band detections count only as one), including 3 optical bands (u -> y). Additionally, detection in VISTA Ks band is also required. Multiple detections in similar optical bands are not counted.


#### Field-specific issues encountered:
Initial runs including PanSTARRS and DECam observations resulted in significantly poorer results than expected given the excellent KIDS and HSC photometry available in the field. As these two datasets were found to be the main causes of the issues when used in combination with the other datasets, they were excluded resulting in excellent overall quality.

## Plots for diagnostics and quality checking

![Chi2 Distributions](plots/dmu24_CDFS-SWIRE_chi2_distributions.png "$\Chi^{2} Distributions")

![Star-Galaxy Chi2 Comparison](plots/dmu24_CDFS-SWIRE_chi2_galaxy_star_comparison.png "Star-Galaxy $\Chi^{2} Comparison")

![Spec-z Comparison](plots/dmu24_CDFS-SWIRE_specz_vs_photz_pz.png "Photometric redshift vs spectroscopic redshift comparison")

![Stats vs z](plots/dmu24_CDFS-SWIRE_stats_vs_z.png "Photometric redshift statistics as a function of spec-z")

![Stats vs mag](plots/dmu24_CDFS-SWIRE_stats_vs_mag.png "Photometric redshift statistics as a function of optical magnitude")

![PDF Accuracy Gal](plots/dmu24_CDFS-SWIRE_pz_accuracy_gal.png "Photometric redshift PDF accuracy for galaxy-like sources")

![PDF Accuracy AGN](plots/dmu24_CDFS-SWIRE_pz_accuracy_agn.png "Photometric redshift PDF accuracy for identified AGN sources")

