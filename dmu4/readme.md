# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)  Starmasks (DMU 4)

This product contains the starmasks for the HELP fields

There is a folder per field containing holes (regions where sources are not detected due
to saturation caused by bright stars) and star masks (regions where bright stars cause
large numbers of artefacts) They are presented in both ds9 region format and MOC format.

e.g. dmu4_sm_ELAIS-N1/holes_ELAIS-N1.reg

Each folder contains the idl code which reads in the masterlist, cross matches to GAIA and parameterises the starmasking parameters in addition to a Jupyter notebook which takes those parameters and makes the reg and moc files which define the mask.

These masks are used in XID+ to avoid problems caused by bright stars.

-------------------------------------------------------------------------------


**Authors**: [Raphael shirley](http://raphaelshirley.co.uk/), [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European
Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project
under the
SP1-Cooperation, Collaborative project, Small or medium-scale focused
research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)
