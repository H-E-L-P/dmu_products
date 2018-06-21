# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP Optical and NIR/MIR photometry validation (DMU6)


This is a data product of the Herschel Extragalactic Legacy Project ([HELP](http://www.herschel.sussex.ac.uk)). This repository contains documents that describe and quantify the quality of the masterlist data in dmu1. It contains a simplified description of steps taken to homogenise and reformat data in dmu1 and quick checks performed there. It also contains work done to highlight specific problems with the input data that could not be corrected.

Vital to subsequent stages of the HELP pipeline and using the data products for science is having confidence that problems with input catalogues and the cross matching have been identified, fixed if possible and flagged as spurious if not.

The full files which are not stored in the Git repository can be downloaded from HeDaM:

- [http://hedam.lam.fr/HELP/data/dmu_products/dmuXX/](http://hedam.lam.fr/HELP/data/dmu_products/dmuXX/)


Folder structure
----------------

The folder is organised by field and takes the input masterists from dmu1. In every folder there are two main notebooks:


- help_FIELDNAME_checks.ipynb (An investigation of the data with tests for problems that might not have been found in the standard checks and diagnostics performed in DMU1.

- 2_flags_FIELDNAME.ipynb (Based on the checks we implement flags on problematic bands to be folded in to the final catalogues in DMU32.

-------------------------------------------------------------------------------

**Authors**: Raphael Shirley, Yannick Rohelly, Peter Hurley, Ken Duncan, Kasia Malek, Estelle Pons, [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)