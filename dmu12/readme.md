# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP Template Files (dmu12) LOFAR masterlist crossmatching

Contains code that implements a modified version of the likelihood ratio code from https://github.com/nudomarinero/mltier1 to crossmatch LOFAR catalogues to the masterlist.

## Folder structure
The notebook radio_masterlist_liklihood_ratio_crossmatch.ipynb provides a detailed description of the likelihood ratio method used in the crossmatching as well as some diagnostic and validation plots. It uses functions from Q0_calc.py and mltier.py. The likelihood_ratio.py is the same code as the notebook but written as a function that can be called in other notebooks without producing all the diagnostic plots.

-------------------------------------------------------------------------------


**Authors**: Ian McCheyne  Yannick Rohelly, [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)