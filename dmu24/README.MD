# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)  Photometric Redshift Repository (DMU 24)

This repository contains all the HELP photometric redshifts (photo-zs) across the various HELP fields. These catalogues include photo-z estimates for subsets of the corresponding field masterlists (DMU1).

Each field will contain:

- Notebook 1_Photo-z_QC_and_Diagnostics.ipynb : which presents an overview of the photometric redshifts for the field, including information of the input catalogue used, steps applied in the photo-z estimation and the filters used. A series of diagnostic plots are also included to enable assessment of the photo-z quality.

- Notebook 2_Photo-z_Selection_Function.ipynb : which describes the creation of selection function maps to describe the likelihood of a source having a photo-z in a given HEALpix cell as a function of a specified magnitude.

All of the DMU 24 Data can be found on [HeDAM](http://hedam.lam.fr/HELP/dataproducts/dmu24/) following the folder structure outlined in this repository. In [Column Descriptions](https://github.com/H-E-L-P/dmu_products/tree/master/dmu24/dmu24_columns.csv) we list the name, description and Universal Content Descriptor (UCD) for all columns in the DMU 24 Photo-z catalogs.

## HELP Photometric Redshift Methodology

The photo-z method employed to produce the HELP products are based on the template-fitting method presented in [Duncan et al. (2018a)](https://ui.adsabs.harvard.edu/link_gateway/2018MNRAS.473.2655D/doi:10.1093/mnras/stx2536), with later estimates also incorporating additional machine-learning following the method based estimates presented in [Duncan et al. (2018b)](https://ui.adsabs.harvard.edu/link_gateway/2018MNRAS.477.5177D/doi:10.1093/mnras/sty940). In the folder for each field we outline which filters were included in the photo-z estimation as well as what machine-learning estimates were included (if any).

An overview of the photo-z method as applied to the HELP datasets in outlined in [User Guide](https://github.com/dunkenj/eazy-pype/blob/master/docs/UserGuide.md) which provides additional documentation for the [eazy-pype](https://github.com/dunkenj/eazy-pype) package that implements the method. This document serves both as a reference for the HELP data products and a tutorial for reproducing the results and/or applying the method to new datasets. Due to the nature of the method and the particularly large datasets involved for some fields, it is not necessarily expected that a novice user would be able to simply apply the photo-z method. Rather, this documentation serves as a record for understanding the method used/choices made and enable moderately experienced users (e.g. familiar with EAzY) to reproduce some or all of the method.

The analysis and selection funciton notebooks presented in this folder _are_ intended to allow novice users to reproduce the plots or selection maps with their own choice of selection criteria.

All zeropoint offset files used during the photo-z estimation are stored in the [dmu24_zeropoints](https://github.com/H-E-L-P/dmu_products/tree/master/dmu24/dmu24_zeropoints) folder structure for reference.



## Fields

HELP Field            | Photo-z Available | Masterlist Used | DR1 Photo-z Suffix | DESI photo-z available
----------------------|-------------------|-----------------|--------------------|----------------------
AKARI-NEP             | No | | Yes
AKARI-SEP             | No | | Yes
Bootes                | Yes | 20180517 | | Yes
CDFS-SWIRE            | Yes | 20170801 | 20180210
COSMOS                | Yes | | | Yes
EGS                   | Yes | 20180501 | 20180608 | Yes
ELAIS-N1              | Yes | 20170706 | 20170725 | Yes
ELAIS-N2              | No | | | Yes
ELAIS-S1              | Yes | 20171103 | 20180412
GAMA-09               | Yes | 20180119 | 20180213 | Yes
GAMA-12               | Yes | 20171210 | 20180410 | Yes
GAMA-15               | Yes | 20180119 | 20180210 | Yes
HDF-N                 | No | | | Yes
Herschel-Stripe-82    | Yes | 20180307 | 20180509 | Yes
Lockman-SWIRE         | Yes | 20170710 | 20170802 | Yes
NGP                   | Yes | 20180501 | 20180601
SA13                  | No | | | Yes
SGP                   | Yes | 20180221 | 20180502
SPIRE-NEP             | No | | Yes
SSDF                  | Yes | 20180221 | 20180612
xFLS                  | No | | | Yes
XMM-13hr              | No | | | Yes
XMM-LSS               | Yes | 20180221 | 20180518


-------------------------------------------------------------------------------


**Authors**: [Ken Duncan](http://dunkenj.github.io/)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European
Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project
under the
SP1-Cooperation, Collaborative project, Small or medium-scale focused
research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)
