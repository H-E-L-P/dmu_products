# Master list on AKARI-SEP

This folder contains the Jupyter notebooks used to create HELP mater list on
AKARI-SEP. 

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|
| VISTA-VHS | VISTA/VIRCAM         |   JHKs                            | dmu0_VISTA-VHS  |    
| DES   | Blanco/DECam             |     grizy                         | dmu0_DES        | 
| SIMES | Spitzer/IRAC             |   IRAC12                          | dmu0_SIMES      |  


## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_SIMES.ipynb](1.1_SIMES.ipynb) 
- [1.2_VISTA-VHS.ipynb](1.2_VISTA-VHS.ipynb) 
- [1.3_DES.ipynb](1.3_DES.ipynb) 

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.



