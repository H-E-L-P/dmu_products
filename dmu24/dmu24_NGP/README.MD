# NGP Photometric Redshifts - V1 (20180601)

NGP/master_catalogue_ngp_20180501_photoz_r_optimised.fits

## Key information

#### Masterlist used:
dmu1/dmu1_ml_NGP/data/master_catalogue_ngp_20180501.fits

#### Spectroscopic redshift sample used:
dmu23/dmu23_NGP/data/NGP-specz-v2.0.csv

#### Templates used:

- EAZY Default
- Atlas of Galaxy SEDs (Brown et al. 2014)
- XMM-COSMOS Template library

#### Filters used:

| Telescope / Instrument | Filter         | Available | Used |
|------------------------|----------------|-----------|------|
| Pan-STARRS1/Pan-STARRS1| gpc1_g         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_r         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_i         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_z         | Yes    | No   |
| Pan-STARRS1/Pan-STARRS1| gpc1_y         | Yes    | No   |
| UKIRT/WFCAM           | ukidss_y       | Yes    | No    | 
| UKIRT/WFCAM           | ukidss_j       | Yes    | Yes   | 
| UKIRT/WFCAM           | ukidss_h       | Yes    | Yes   | 
| UKIRT/WFCAM           | ukidss_k       | Yes    | Yes   |



#### Additional Machine Learning Estimates

For the main galaxy population, three additional Gaussian Process machine learning estimates were also incorporated into the Bayesian combination estimates. These were training using the combined spectroscopic sample of NGP, GAMA12 and NGP with cost-sensitive learning weights calibrated specifically for the NGP field.
The three sets of filters used were:
- PS1 grizy
- PS1 griz + UKIDSS J+K

Additionally, an AGN classifier was trained using the following filters:
- PS1 grizy + UKIDSS


#### Additional selections applied:
 - In order to have a fully calibrated redshift estimate, sources must have a magnitude measurement in either any of the optical r-bands.
 - Sources must also have S/N > 2 in at least 4 bands at different wavelengths for a redshift to have been estimated (i.e. multiple r-band detections count only as one). Multiple detections in similar optical bands do not count due to the issues described below.

For a very small subset of sources, EAZY struggled to converge on fit. For the three subsets of 25k sources that this issue occurred in, the EAZY requirement of NMIN colours was raised to 6 when fitting the eazy template set. This change was not required for the Atlas/COSMOS libraries.

## Plots for diagnostics and quality checking

![Chi2 Distributions](plots/dmu24_NGP_chi2_distributions.png "$\Chi^{2} Distributions")

![Star-Galaxy Chi2 Comparison](plots/dmu24_NGP_chi2_galaxy_star_comparison.png "Star-Galaxy $\Chi^{2} Comparison")

![Spec-z Comparison](plots/dmu24_NGP_specz_vs_photz_pz.png "Photometric redshift vs spectroscopic redshift comparison")

![Stats vs z](plots/dmu24_NGP_stats_vs_z.png "Photometric redshift statistics as a function of spec-z")

![Stats vs mag](plots/dmu24_NGP_stats_vs_mag.png "Photometric redshift statistics as a function of optical magnitude")

![PDF Accuracy Gal](plots/dmu24_NGP_pz_accuracy_gal.png "Photometric redshift PDF accuracy for galaxy-like sources")

![PDF Accuracy AGN](plots/dmu24_NGP_pz_accuracy_agn.png "Photometric redshift PDF accuracy for identified AGN sources")

