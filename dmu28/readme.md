# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP CIGALE repository (DMU28)


This is a data product of the Herschel Extragalactic Legacy Project ([HELP](http://www.herschel.sussex.ac.uk)). This repository contains the iputs and outputs for the physical modelling performed with the Code Investigating GALaxy Emission ([CIGALE](https://cigale.lam.fr/).

In order to run CIGALE we use the merged catalogues found in dmu32. For fully processed fields, these catalogues will contain optical to mid infrared photometry from the masterlist produced in dmu1, photometric redshifts stored in dmu24, and XID+ fluxes produced from the Herschel maps and the masterlist. After the CIGALE run, the output physical parameters such as dust luminosity and stellar mass are merged in to make the final HELP catalogues in dmu32. We also store the best fit SEDs here for every galaxy.

The full files which are not stored in the Git repository can be downloaded from HeDaM:

- [http://hedam.lam.fr/HELP/data/dmu_products/dmu28/](http://hedam.lam.fr/HELP/data/dmu_products/dmu28/)

Folder structure
----------------

This repository contains all the CIGALE input and output files. The input files, which are stored in 'dmu28_FIELDNAME/data_tmp/' have the following naming convention:

 - 'FIELDNAME_cigale_best_extcor_MASTERLISTDATE.fits': objects with 2 or more 'good' PACS and SPIRE fluxes according to XID+ fitting criteria. These are the photo-z objects.
 
 - 'FIELDNAME_cigale_optnir_extcor_MASTERLISTDATE.fits': All objects at least 2 optical fluxes and at least 2 near infrared fluxes. This is probably used to generate XID+ priors where no IRAC imaging is available.

 - 'FIELDNAME_cigale_all_extcor_zspec_MASTERLISTDATE.fits': All objects with a spectrographic redshift.

 - 'FIELDNAME_cigale_optnir_extcor_zspec_MASTERLISTDATE.fits': All objects with a spectrographic redshift and at least 2 optical fluxes and at least 2 near infrared fluxes.

The outputs, stored in 'dmu28_FIELDNAME/data/' have a folder for each type according to which input file was used. These files should follow the naming convention above and will include fits files containingg the best fit SED of each object in the observing frame.

CIGALE version used
--------------------

We use a dedicated version of CIGALE called cigalon which contains only modules we use to fit HELP's galaxies. This version can be found on the main CIGALE page (https://gitlab.lam.fr/cigale/cigale.git). This version has already implemented all parameters which are used to estimate the physical properties of galaxies. The pcigale.ini files contained in the data folders here, along with the input catalogues produced by the notebooks here and stored in data_tmp should allow complete rerunning of CIGALE.

The files in data are:

- 'HELP_final_results.fits'
- 'pcigale.ini' a configuration file for cigale
- 'SEDs' folder which contains all best models for given catalogue

-------------------------------------------------------------------------------

**Authors**: Raphael Shirley, Yannick Rohelly, Peter Hurley, Ken Duncan, Kasia Malek, Estelle Pons, [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)
