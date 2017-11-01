# Master list on HATLAS-SGP

This folder contains the Jupyter notebooks used to create the HELP master list on
HATLAS-SGP. 

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|

| KIDS          | VLT OmegaCAM     | ugri                              | dmu0_KIDS       |  
| PanSTARRS-3SS | GPC1             | grizy                          | dmu0_PanSTARRS-3SS |     
| VIKING        | VISTA VIRCAM     | ZYHJKs                          | dmu0_VISTA-VIKING |


## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.


- [1.2_KIDS.ipynb](1.2_KIDS.ipynb) 
- [1.3_PanSTARRS-3SS.ipynb](1.3_PanSTARRS-3SS.ipynb) 
- [1.4_VISTA-VIKING.ipynb](1.4_VISTA-VIKING.ipynb) 

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
