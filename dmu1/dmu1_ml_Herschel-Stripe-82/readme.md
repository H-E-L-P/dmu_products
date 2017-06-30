# Master list on Herschel Stripe 82/HELMS

This folder contains the Jupyter notebooks used to create the HELP masterlist on
Herschel Stripe 82. 

| Survey     | Telescope / Instrument      |      Filters (detection band in bold)      | Location                    |
|------------|-----------------------------|:------------------------------------------:|-----------------------------|
| HSC SSC PDR1 | Subaru/HSC                |   grizy,N921,N816                          | dmu0_HSC                    |
| PS1 3PSS   | Pan-STARRS1/Pan-STARRS1     |   grizy                                    | dmu0_PanSTARRS1-3SS         |
| DECaLS     | Blanco Telescope/Dark Energy Camera| ugrizY                              | dmu0_DECaLS                 |
| RCSLenS    | CFHT/MegaPrime/MegaCam      |   grizy                                    | dmu0_RCSLenS                |
| VHS        | VISTA/VIRCAM                |   Y,J,H,K                                  | dmu0_VISTA-VHS              |
| VICS82     | VISTA+CFHT/VIRCAM+WIRCA     |   J,K                                      | dmu0_VICS82                 |
| UKIDSS LAS | UKIRT/WFCAM                 |   Y,J,H,K                                  | dmu0_UKIDSS-LAS             | 
| SHELA      | Spitzer/IRAC                |   IRAC12                                   | dmu0_SHELA                  |
| SpIES      | Spitzer/IRAC                |   IRAC12                                   | dmu0_SpIES                  |

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_HSC-SSP.ipynb](1.1_HSC-SSP.ipynb) 
- [1.2_VHS.ipynb](1.2_VHS.ipynb) 
- [1.3_VICS82.ipynb](1.3_VICS82.ipynb)
- [1.4_UKIDSS-LAS.ipynb](1.4_UKIDSS-LAS.ipynb) 
- [1.5_PanSTARRS-3SS.ipynb](1.5_PanSTARRS-3SS.ipynb) 
- [1.6_SHELA.ipynb](1.6_SHELA.ipynb)
- [1.7_SpIES.ipynb](1.7_SpIES.ipynb)
- [1.8_DECaLS.ipynb](1.8_DECaLS.ipynb)
- [1.9_RCSLenS.ipynb](1.9_RCSLenS.ipynb)


## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
