# Master list on xFLS

This folder contains the Jupyter notebooks used to create HELP mater list on
xFLS. 

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|
| DataFusion  | Spitzer/IRAC       |  IRAC12                   | dmu0_DataFusion-Spitzer |
| INT-WFC | INT/WFC                | ugriz                             | dmu0_INT-WFC    |   
| KPNO-FLS        |               | R                             | dmu0_KPNO-FLS        |
| PanSTARRS-3SS | PanSTARRS/GPC1   | ugriz                          | dmu0_PanSTARRS-322 |
| Legacy Survey | BASS             | grz                             | dmu0_LegacySurvey |
| UHS    | UKIRT                   | J                                 | dmu0_UHS        |



## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_DataFusion-Spitzer.ipynb](1.1_DataFusion-Spitzer.ipynb) 
- [1.2_INT-WFC.ipynb](1.2_INT-WFC.ipynb) 
- [1.3_KPNO-FLS.ipynb](1.3_KPNO-FLS.ipynb) 
- [1.4_PanSTARRS-3SS.ipynb](1.4_PanSTARRS-3SS.ipynb) 
- [1.5_LegacySurvey.ipynb](1.5_LegacySurvey.ipynb)
- [1.6_UHS.ipynb](1.6_UHS.ipynb)

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.



