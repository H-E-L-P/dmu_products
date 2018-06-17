# EGS Photometric Redshifts - V1 (20180608)

EGS/master_catalogue_egs_20180501_photoz_20180608.fits

## Key information

#### Masterlist used:
dmu1/dmu1_ml_EGS/data/master_catalogue_egs_20180501.fits


#### Spectroscopic redshift sample used:
dmu23/dmu23_EGS/data/EGS-specz-v2.1_hedam.csv

#### Templates used:

- EAZY Default
- Atlas of Galaxy SEDs (Brown et al. 2014)
- XMM-COSMOS Template library

#### Filters used (Templates):

"Available" corresponds to aperture magnitudes. Additional total magnitudes are present in the masterlist but not used during photo-z fitting.


| Telescope / Instrument | Filter         | Available | Used |
|------------------------|----------------|-----------|------|
| Subaru/HSC             | suprime_g      | Yes    | Yes  |
| Subaru/HSC             | suprime_g      | Yes    | Yes  |
| Subaru/HSC             | suprime_i      | Yes    | Yes  |
| Subaru/HSC             | suprime_z      | Yes    | Yes  |
| Subaru/HSC             | suprime_y      | Yes    | Yes  |
| CFHT/Megacam           | megacam_u      | Yes    | Yes  |
| CFHT/Megacam           | megacam_g      | Yes    | Yes  |
| CFHT/Megacam           | megacam_r      | Yes    | Yes  |
| CFHT/Megacam           | megacam_i      | Yes    | Yes  |
| CFHT/Megacam           | megacam_z      | Yes    | Yes  |
| HST/ACS                | acs_f606w      | Yes    | Yes  |
| HST/ACS                | acs_f814w      | Yes    | Yes  |
| HST/WFC3               | wfc3_f125w      | Yes    | Yes  |
| HST/WFC3               | wfc3_f160w      | Yes    | Yes  |
| Bok/90prime            | 90prime_g      | Yes    | Yes  |
| Bok/90prime            | 90prime_r      | Yes    | Yes  |
| Mayall/MOSAIC          | mosaic_z      | Yes    | Yes  |
| Pan-STARRS1/Pan-STARRS1| gpc1_g         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_r         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_i         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_z         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_y         | Yes    | No   |
| CFHT/WIRCam           | wircam_j       | Yes    | Yes   |
| CFHT/WIRCam           | wircam_h       | Yes    | Yes   |
| CFHT/WIRCam           | wircam_ks       | Yes    | Yes   |
| Palomar/WIRCS         | wircs_j         | Yes    | Yes   |
| Palomar/WIRCS         | wircs_k         | Yes    | Yes   |
| UKIDSS/WFCAM          | ukidss_j        | Yes    | Yes   |


#### Additional Machine Learning Estimates

For the main galaxy population, three additional Gaussian Process machine learning estimates were also incorporated into the Bayesian combination estimates. These were training using the combined spectroscopic sample - with cost-sensitive learning weights calibrated for the full field.
The two sets of filters used were:
- Megacam u, g, r, i, z
- HSC g, r, i, z, y


#### Additional selections applied:
 - In order to have a fully calibrated redshift estimate, sources must have a magnitude measurement in any of the optical r-bands.
 - Sources must also be detected in 4 bands at different wavelengths for a redshift to have been estimated (i.e. multiple r-band detections count only as one), including 3 optical bands (b -> y). Multiple detections in similar optical bands are not counted.


## Plots for diagnostics and quality checking

![Chi2 Distributions](plots/dmu24_EGS_chi2_distributions.png "$\Chi^{2} Distributions")

![Star-Galaxy Chi2 Comparison](plots/dmu24_EGS_chi2_galaxy_star_comparison.png "Star-Galaxy $\Chi^{2} Comparison")

![Spec-z Comparison](plots/dmu24_EGS_specz_vs_photz_pz.png "Photometric redshift vs spectroscopic redshift comparison")

![Stats vs z](plots/dmu24_EGS_stats_vs_z.png "Photometric redshift statistics as a function of spec-z")

![Stats vs mag](plots/dmu24_EGS_stats_vs_mag.png "Photometric redshift statistics as a function of optical magnitude")

![PDF Accuracy Gal](plots/dmu24_EGS_pz_accuracy_gal.png "Photometric redshift PDF accuracy for galaxy-like sources")

![PDF Accuracy AGN](plots/dmu24_EGS_pz_accuracy_agn.png "Photometric redshift PDF accuracy for identified AGN sources")

