

# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) Spitzer Enhanced Imaging Products 24 micron Super mosaics  (dmu17 SEIP maps)


This is a data product of the Herschel Extragalactic Legacy Project ([HELP](http://www.herschel.sussex.ac.uk)).  This is collection of Super Mosaics (combining data from multiple programs where appropriate) of Spitzer MIPS data produced by the [NASA/IPAC Infrared Science Archive](https://irsa.ipac.caltech.edu/data/SPITZER/Enhanced/SEIP/).

The maps that are located within or near to the HELP field have been identified and retrieved using code here.


The full files which are not stored in the Git repository can be downloaded from HeDaM:

- [http://hedam.lam.fr/HELP/dataproducts/](http://hedam.lam.fr/HELP/dataproducts/)

## Code and files located in this folder

* readme.md: this file
* GenSEIPscripts.ipynb: jupyter notebook to generate the wget scripts to locate and retrieve the MIPS SEIP files
* fields.txt: list of HELP fields
* mosaic_tiles.cat : table of all the SEIP mosaic tiles
* mosaic_tiles.fits : fits version of the above
* get_SEIP_data_seb.pl: perl script called by the jupyter notbook above
* run_all_wget_scripts.csh: tcshell script to run all the wget scripts in the sub-folders.




## Folder structure

* One folder is dedicated to each survey field
 * AKARI-NEP
 * AKARI-SEP
 * Bootes
 * CDFS-SWIRE
 * COSMOS
 * EGS
 * ELAIS-N1
 * ELAIS-N2
 * ELAIS-S1
 * GAMA-09
 * GAMA-12
 * GAMA-15
 * HDF-N
 * Herschel-Stripe-82
 * Lockman-SWIRE
 * NGP
 * SA13
 * SEIP
 * SGP
 * SPIRE-NEP
 * SSDF
 * XMM-13hr
 * XMM-LSS
 * xFLS

-------------------------------------------------------------------------------

*This is a default HELP Readme markdown footer which should be identical across all fields*

**Authors**:  [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)

