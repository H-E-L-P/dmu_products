HELP DMU32 final data repository
===========================

This repository contains all the final HELP catalogues across the various fields. Each folder merges all the data available on each field. The notebook the_end.ipynb also generates a list of files and the code necessary to publish the final data on VO. This is built on using the definition of DR1 objects specified in dmu1.

In general the fits files stored here contain the latest and most complete data products across all of HELP.

In each field folder there is a file field_meta.yml which contains details of all the tables that have gone into producing the final catalogue. Depending on the field this can include:

* field: FIELDNAME
** Every field has a name which is used to structure the folders for most dmu products

* region: dmu2/link/to/region/file/FIELDNAME_MOC.fits
** This is a Multi Order Coverage map which defines the region on the sky associated with a given field.

* surveys: [ SURVEYNAME1, SURVEYNAME2, SURVEYNAME3 ]
** A list of the surveys that have been included on the field in the production of the masterlist. Full details of each survey are provided in dmu0 (input surveys).

* masterlist: /link/to/masterlist/file.fits
** The masterlist is present on all fields and defines the list of objects in HELP. A full description of its production and contents is provided in dmu1 (masterlist production).

* depths: dmu_products/dmu1/dmu1_ml_AKARI-SEP/data/depths_akari-sep_20180221.fits
** Depths maps for ever masterlist band are provided in order to develop selection functions for a given location on the sky. The production of these files is described in dmu1 (masterlist production).

* flags: /link/to/flags/file.fits
** A link to flags for each field. These are developed based on investigations into issues with individual surveys described in dmu6 (validation).

* xid: /link/to/xid/file1.fits, /link/to/xid/file2.fits
** These are the file(s) which contain the XID+ fluxes for MIPS, PACS, and SPIRE in dmu26 (XID+). These are not present on all fields so it may be empty.

* photoz: /link/to/photoz/file.fits
** Theses are the photometric redshift catalogues present in dmu24.

* cigale: /link/to/cigale/file.fits
** These are the CIGALE physical parameters. They are not present on all fields. dmu28 contains other information such as the full best fit SEDs and possibly alternative CIGALE runs on for instance a spectroscopic redshift sample.

* final: /link/to/final/output/file.fits
** This is the final catalogue found in this folder (dmu32 - Merged catalogue). It is produced based on joining the earlier catalogues based on the HELP_id which is used to identify objects across all the HELP data products.