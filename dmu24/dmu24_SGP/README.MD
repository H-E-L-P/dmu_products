# SGP Photometric Redshifts - V1 (20180502)

SGP/master_catalogue_sgp_20180221_photoz_20180502_r_optimised.fits'

## Key information

#### Masterlist used:
dmu1/dmu1_ml_SGP/data/master_catalogue_sgp_20180221.fits

#### Spectroscopic redshift sample used:
dmu23/dmu23_SGP/data/SGP-specz-ver2.0.csv

#### Templates used:

- EAZY Default
- Atlas of Galaxy SEDs (Brown et al. 2014)
- XMM-COSMOS Template library

#### Filters used:

| Telescope / Instrument | Filter         | Available | Used |
|------------------------|----------------|-----------|------|
| VST/OmegaCam           | omegacam_u     | Yes    | Yes   |
| VST/OmegaCam           | omegacam_g     | Yes    | Yes   |
| VST/OmegaCam           | omegacam_r     | Yes    | Yes   |
| VST/OmegaCam           | omegacam_i     | Yes    | Yes   |
| CTIO/DECAM             | degam_g        | Yes    | Yes   |
| CTIO/DECAM             | degam_r        | Yes    | Yes   |
| CTIO/DECAM             | degam_i        | Yes    | Yes   |
| CTIO/DECAM             | degam_z        | Yes    | Yes   |
| CTIO/DECAM             | degam_y        | Yes    | Yes   |
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


#### Additional Machine Learning Estimates

For the main galaxy population, three additional Gaussian Process machine learning estimates were also incorporated into the Bayesian combination estimates. These were training using the combined spectroscopic sample of SGP with the addition of extra redshifts from three GAMA fields - with cost-sensitive learning weights calibrated specifically for the SGP field.
The three sets of filters used were:
- OmegaCam u,g,r,i
- DECAM g,r,i,z,y
- OmegaCam g,r,i + VISTA/VIRCAM J and Ks


#### Additional selections applied:
 - In order to have a fully calibrated redshift estimate, sources must have a magnitude measurement in either any of the optical r-bands.
 - Sources must also be detected in 4 bands at different wavelengths for a redshift to have been estimated (i.e. multiple r-band detections count only as one). Multiple detections in similar optical bands do not count due to the issues described below.


## Plots for diagnostics and quality checking

![Chi2 Distributions](plots/dmu24_SGP_chi2_distributions.png "$\Chi^{2} Distributions")

![Star-Galaxy Chi2 Comparison](plots/dmu24_SGP_chi2_galaxy_star_comparison.png "Star-Galaxy $\Chi^{2} Comparison")

![Spec-z Comparison](plots/dmu24_SGP_specz_vs_photz_pz.png "Photometric redshift vs spectroscopic redshift comparison")

![Stats vs z](plots/dmu24_SGP_stats_vs_z.png "Photometric redshift statistics as a function of spec-z")

![Stats vs mag](plots/dmu24_SGP_stats_vs_mag.png "Photometric redshift statistics as a function of optical magnitude")

![PDF Accuracy Gal](plots/dmu24_SGP_pz_accuracy_gal.png "Photometric redshift PDF accuracy for galaxy-like sources")

![PDF Accuracy AGN](plots/dmu24_SGP_pz_accuracy_agn.png "Photometric redshift PDF accuracy for identified AGN sources")

