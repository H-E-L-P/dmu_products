HELP DMU28 CIGALE repository
===========================

This repository contains all the CIGALE input and output files. The input files, which are stored in 'dmu28_FIELDNAME/data_tmp/' have the following naming convention:

 - 'FIELDNAME_cigale_best_extcor_MASTERLISTDATE.fits': objects with 2 or more 'good' PACS and SPIRE fluxes according to XID+ fitting criteria. These are the photo-z objects.
 
 - 'FIELDNAME_cigale_optnir_extcor_MASTERLISTDATE.fits': All objects at least 2 optical fluxes and at least 2 near infrared fluxes. This is probably used to generate XID+ priors where no IRAC imaging is available.

 - 'FIELDNAME_cigale_all_extcor_zspec_MASTERLISTDATE.fits': All objects with a spectrographic redshift.

 - 'FIELDNAME_cigale_optnir_extcor_zspec_MASTERLISTDATE.fits': All objects with a spectrographic redshift and at least 2 optical fluxes and at least 2 near infrared fluxes.

The outputs, stored in 'dmu28_FIELDNAME/data/' have a folder for each type according to which input file was used. These files should follow the naming convention above and will include fits files containingg the best fit SED of each object in the observing frame.

We use a dedicated version of CIGALE called cigalon (https://gitlab.lam.fr/cigale/cigale.git) which contains only modules we use to fit HELP's galaxies. This version has already implemented all parameters which are used to estimate the physical properties of galaxies. 

'HELP_final_results.fits'
'pcigale.ini' -	a	configuration	file for cigale
 'SEDs' -folder which contains all best models for given catalogue



