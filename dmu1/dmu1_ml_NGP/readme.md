# Master list on HATLAS-NGP

This folder contains the Jupyter notebooks used to create the HELP master list on
HATLAS-NGP. 

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|
| DECaLS        | DEC              | ugrizY                            | dmu0_DECaLS     |
| PanSTARRS-3SS | GPC1             | grizy                          | dmu0_PanSTARRS-3SS |     
| UKIDSS-LAS    | UKIRT WFCAM      | YJHK                              | dmu0_UKIDSS-LAS |     
| Legacy SUrvey    | BASS          | grz                             | dmu0_LegacySurvey |  


## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.


- [1.1_DECaLS.ipynb](1.1_DECaLS.ipynb) 
- [1.2_PanSTARRS-3SS.ipynb](1.3_PanSTARRS-3SS.ipynb) 
- [1.3_UKIDSS-LAS.ipynb](1.3_UKIDSS-LAS.ipynb) 
- [1.3_LegacySurvey.ipynb](1.3_LegacySurvey.ipynb) 

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
