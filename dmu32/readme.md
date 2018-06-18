HELP DMU32 final data repository
===========================

This repository contains all the final HELP catalogues across the various fields. Each folder merges all the data available on each field. The notebook the_end.ipynb also generates a list of files and the code necessary to publish the final data on VO. This is built on using the definition of DR1 objects specified in dmu1.

In general the fits files stored here contain the latest and most complete data products across all of HELP. Each final catalogue contains a SUFFIX equal to the date the masterlist was produced e.g. ELAIS-N1_20171016. In general all data products are built on this masterlist which is defined in dmu1 to ensure the exact same file is used throughout. The final file may have _cigale in the name to denote it is an input for CIGALE and does not include the final CIGALE outputs.

In each field folder there is a file field_meta.yml which contains details of all the tables that have gone into producing the final catalogue as well as other meta data regarding the field. Depending on the field this can include:

1. field: FIELDNAME
    * Every field has a name which is used to structure the folders for most dmu products

2. region: dmu2/link/to/region/file/FIELDNAME_MOC.fits
    * This is a Multi Order Coverage map which defines the region on the sky associated with a given field.

3. surveys: [ SURVEYNAME1, SURVEYNAME2, SURVEYNAME3 ]
    * A list of the surveys that have been included on the field in the production of the masterlist. Full details of each survey are provided in dmu0 (input surveys). dmu0 folder names should use the same names used here e.g. dmu0/dmu0_SURVEYNAME1/. These names should also be used for the individual survey processing notebooks in dmu1 e.g. dmu1/dmu1_ml_FIELDNAME/1.x_SURVEYNAME1.ipynb

4. masterlist: dmu_products/dmu1/dmu1_ml_FIELDNAME/data/master_catalogue_FIELDNAME_SUFFIX.fits
    * The masterlist is present on all fields and defines the list of objects in HELP. A full description of its production and contents is provided in dmu1 (masterlist production).

5. depths: dmu_products/dmu1/dmu1_ml_FIELDNAME/data/depths_FIELDNAME_SUFFIX.fits
    * Depths maps for ever masterlist band are provided in order to develop selection functions for a given location on the sky. The production of these files is described in dmu1 (masterlist production).

6. flags: dmu_products/dmu6/dmu6_v_FIELDNAME/data/FIELDNAME_SUFFIX_flags.fits
    * A link to flags for each field. These are developed based on investigations into issues with individual surveys described in dmu6 (validation).

7. xid: [ dmu_products/dmu26/dmu26_XID+INSTRUMENT/data/filename.fits, etc. ]
    * These are the file(s) which contain the XID+ fluxes for the MIPS, PACS, and SPIRE instruments in dmu26 (XID+). These are not present on all fields so it may be empty.

8. photoz: dmu_products/dmu24/dmu24_FIELDNAME/data/filename.fits
    * Theses are the photometric redshift catalogues present in dmu24.

9. cigale: dmu_products/dmu28/dmu28_FIELDNAME/data/best/filename.fits
    * These are the CIGALE physical parameters. They are not present on all fields. dmu28 contains other information such as the full best fit SEDs and possibly alternative CIGALE runs on for instance a spectroscopic redshift sample.

10. final: dmu_products/dmu32/dmu32_FIELDNAME/data/FIELDNAME_SUFFIX_cigale.fits
    * This is the final catalogue found in this folder (dmu32 - Merged catalogue). It is produced based on joining the earlier catalogues based on the HELP_id which is used to identify objects across all the HELP data products. If this field has all the data products (xid+ fluxes, photo-z and CIGALE fits) this file will be called FIELDNAME_SUFFIX.fits. If not all data products are present then only the FIELDNAME_SUFFIX_cigale.fits file will be present which is built as an input for CIGALE.