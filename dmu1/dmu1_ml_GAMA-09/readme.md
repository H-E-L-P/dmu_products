# Master list on GAMA-09

This folder contains the Jupyter notebooks used to create HELP mater list on
GAMA-09. 

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_CFHTLS.ipynb](1.1_CFHTLS.ipynb) 
- [1.2_CFHTLenS.ipynb](1.2_CFHTLenS.ipynb) 
- [1.3_DECaLS.ipynb](1.3_DECaLS.ipynb) 
- [1.4_HSC-SSP.ipynb](1.4_HSC-SSP.ipynb) 
- [1.5_KIDS.ipynb](1.5_KIDS.ipynb) 
- [1.6_PanSTARRS-3SS.ipynb](1.6_PanSTARRS-3SS.ipynb) 
- [1.7_UKIDSS-LAS.ipynb](1.7_UKIDSS-LAS.ipynb) 
- [1.8_VISTA-VHS.ipynb](1.8_VISTA-VHS.ipynb) 
- [1.9_VISTA-VIKING.ipynb](1.9_VISTA-VIKING.ipynb) 

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
