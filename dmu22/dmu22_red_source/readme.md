HELP DMU22 SPIRE blind catalogues, Red source catalgoues

The `Red catalogues`, containing all the Red SPIRE sources found using a similar method as described in Asboth et al. 2016.

- http://hedam.lam.fr/HELP/data/dmu_products/dmu22/dmu22_red_source
# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP Blind catalogues (dmu19)

This is a data product of the Herschel Extragalactic Legacy Project ([HELP](http://www.herschel.sussex.ac.uk))

The full files which are not stored in the Git repository can be downloaded from HeDaM:

- [http://hedam.lam.fr/HELP/data/dmu_products/](http://hedam.lam.fr/HELP/data/dmu_products/)

- dmu22_red_source/data/`"name field"_SPIRE_map_6ac.fits` is the fits file for the 500um map with 6 arcsec pixels
- dmu22_red_source/data/`"name field"_SPIRE_D_map.fits` is the D-map
- dmu22_red_source/data/`"name field"_SPIRE_D_cat.fits` The location of the 3 sigma peaks in the Dmap
- dmu22_red_source/data/`"name field"_SPIRE_D_MF_cat.fits` The flux desnsity of all the sources detecte (3 sigma) in the D-map

Where "name field" can be e.g. "ELAIS-N1". 
-------------------------------------------------------------------------------

The red sources are selected by finding peaks in a difference map (D) between the 500um and 250um map.


**Authors**: Steven Duivenvoorden

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)
