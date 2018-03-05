HELP DMU1 masterlist repository
===========================

This repository contains all the HELP masterlists across the various fields. These catalogues are cross matched photometry catalogues constructed from the pristine catalogues contained in dmu0.

Each field will contain: 

- Notebooks 1.x which describe the conversion of each pristine catalogue to HELP format.
- Notebook 2_Merging.ipynb which describes the merging of individual catalogues and addition of HELP derived data.
- Notebook 3_Checks_and_diagnostics.ipynb which shows some checks performed on the masterlists to confirm unit changes and other conversions have been performed correctly.
- Notebook 4_Selection_function.ipynb which describes the creation of depth maps to describe depth of the masterlist in a given band in a given HEALpix cell.


HELP Data Release 1
---------------------------------------

As new surveys and data releases are coming out all the time we decided to define a masterlist across all HELP field called Data Release 1 (DR1). 

In some cases there may be newer data and a newer masterlist. You must take care in those cases when using subsequent HELP data products as we can't guarantee that the IDs and other data will properly match up.

The following table defines the DR1 masterlist in terms of the dated file that was used on a given field.

The file dr1_overview.fits gives an overview of the current DR1 definition. When a field has been run through to the final stage through all parts of help we will add the final used masterlist below. Occasionally, different partts fo the pipeline may have been conducted with a different masterlist file. In those case care was taken to ensure HELP ids do not change. It is however possible that new sources or photometry may have been added and that selection functions might be altered. In those cases one should take care to note which masterlist was used at any given stage.



 HELP field            |  DR1 masterlist file
-----------------------|------------------------------------------
 AKARI-NEP             |
 AKARI-SEP             |
 Bootes	               |
 XMM-LSS               |
 CDFS-SWIRE            |  master_catalogue_cdfs-swire_20180221.fits
 COSMOS                |
 EGS                   |
 ELAIS-N1              |  master_catalogue_elais-n1_20171016.fits
 ELAIS-N2              |
 ELAIS-S1              |  
 GAMA-09               |
 GAMA-12               |
 GAMA-15               |
 HDF-N                 |
 Herschel-Stripe-82    |
 Lockman-SWIRE         |
 NGP                   |
 SA13                  |
 SGP                   |
 SPIRE-NEP             |
 SSDF                  |
 XMM-13hr              |
 XMM-LSS               |
 xFLS                  |
 
 These are the catalogues on which checks and diagnostics have been run, validations performed, xid+ fir fluxes calculated, photometric redshifts calculated, and CIGALE parameters fitted.


