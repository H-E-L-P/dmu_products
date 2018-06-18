# DMU 24 Photometric Redshift Repository
========================================

This repository contains all the HELP photometric redshifts (photo-zs) across the various HELP fields. These catalogues include photo-z estimates for subsets of the corresponding field masterlists (DMU1).

Each field will contain:

Notebook 1_Photo-z_QC_and_Diagnostics.ipynb which presents an overview of the photometric redshifts for the field, including information of the input catalogue used, steps applied in the photo-z estimation and the filters used. A series of diagnostic plots are also included to enable assessment of the photo-z quality.
Notebook 2_Photo-z_Selection_Function.ipynb which describes the creation of selection function maps to describe the likelihood of a source having a photo-z in a given HEALpix cell as a function of a specified magnitude.

All of the DMU 24 Data can be found on [HeDAM](http://hedam.lam.fr/HELP/data/dmu_products/dmu24/) following the folder structure outlined in this repository.

## HELP Photometric Redshift Methodology

The photo-z method employed to produce the HELP products are based on the template-fitting method presented in [Duncan et al. (2018a)](https://ui.adsabs.harvard.edu/link_gateway/2018MNRAS.473.2655D/doi:10.1093/mnras/stx2536), with later estimates also incorporating additional machine-learning following the method based estimates presented in [Duncan et al. (2018b)](https://ui.adsabs.harvard.edu/link_gateway/2018MNRAS.477.5177D/doi:10.1093/mnras/sty940). In the folder for each field we outline which filters were included in the photo-z estimation as well as what machine-learning estimates were included (if any).

An overview of the photo-z method as applied to the HELP datasets in outlined in [METHOD NOTEBOOK](Method). This notebook serves both as a reference for the HELP data products and a tutorial for reproducing the results and/or applying the method to new datasets.

All zeropoint offset files used during the photo-z estimation are stored in the dmu24_zeropoints/ folder structure for reference.

## Fields

HELP Field            | Photo-z Available | Masterlist Used | DR1 Photo-z Suffix
----------------------|-------------------|-----------------|--------------------
AKARI-NEP             | No | |
AKARI-SEP             | No | |
Bootes                | No | |
CDFS-SWIRE            | Yes | 20170801 | 20180210
COSMOS                | Yes | |
EGS                   | Yes | 20180501 | 20180608
ELAIS-N1              | Yes | 20170706 | 20170725
ELAIS-N2              | No | |
ELAIS-S1              | Yes | 20171103 | 20180412
GAMA-09               | Yes | 20180119 | 20180213
GAMA-12               | Yes | 20171210 | 20180410
GAMA-15               | Yes | 20180119 | 20180210
HDF-N                 | No | |
Herschel-Stripe-82    | Yes | 20180307 | 20180509
Lockman-SWIRE         | Yes | 20170710 | 20170802
NGP                   | Yes | 20180501 | 20180601
SA13                  | No | |
SGP                   | Yes | 20180221 | 20180502
SPIRE-NEP             | No | |
SSDF                  | Yes | 20180221 | 20180612
xFLS                  | No | |
XMM-13hr              | No | |
XMM-LSS               | Yes | 20180221 | 20180518
