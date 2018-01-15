HELP DMU product repository
===========================

This repository contains all the HELP masterlists across the various fields. These catalogues are cross matched photometry catalogues constructed from teh pristine catalogues contained in dmu0.

HELP Data Release 1
---------------------------------------

As new surveys and data releases are coming out all the time we decided to define a masterlist across all HELP field called Data Release 1 (DR1). There is a soft link to the appropriately dated file in every folder according to the following naming convention:

dmu_products/dmu1/dmu1_ml_FIELD/data/master_catalogue_field_dr1.fits

In some cases there may be newer data and a newer masterlist. You must take care in those cases when using subsequent HELP data products as we can't guarantee that the ids will properly match up.

The following table defines the masterlist in terms of the dated file that was used on a given field.

Notably the DES DR1 data is not included in all of the HELP masterlist DR1 catalogues as it was released after the creation of the masterlist on some fields.



 HELP field   |  DR1 masterlist file
--------------|------------------------------------------
 ELAIS-N1     |  master_catalogue_elais-n1_20171016.fits
 CDFS-SWIRE   |  master_catalogue_cdfs-swire_20171103.fits
 
 These are the catalogues on which checks and diagnostics have been run, validations performed, xid+ fir fluxes calculated, photometric redshifts calculated, and CIGALE parameters fitted.


