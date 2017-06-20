# Master list on Herschel Stripe 82/HELMS

This folder contains the Jupyter notebooks used to create HELP mater list on
Herschel Stripe 82. *Note: The [0_main.ipynb](0_main.ipynb) contains the same thing than
this readme and is easier to read from within Jupyter.*

| Survey     | Telescope / Instrument      |      Filters (detection band in bold)      | Location                    |
|------------|-----------------------------|:------------------------------------------:|-----------------------------|
| HSC SSC PDR1 | Subaru/HSC                |                                            | dmu0_HSC                    |
| VIKING     | VISTA/VIRCAM                |                                            | dmu0_VISTA-VIKING           |
| VHS        | VISTA/VIRCAM                |                                            | dmu0_VISTA-VHS              |
| VICS82     | VISTA+CFHT/VIRCAM+WIRCA     |   J,K                                      | dmu0_VICS82                 |
| UKIDSS LAS | UKIRT/WFCAM                 |   Y,J,H,K                                  | dmu0_UKIDSS-LAS             | 
| PS1 3PSS   | Pan-STARRS1/Pan-STARRS1     |   grizy                                    | dmu0_PanSTARRS1-3SS         |
| SHELA      | Spitzer/IRAC                |   IRAC12                                   | dmu0_SHELA                  |
| SpIES      | Spitzer/IRAC                |   IRAC12                                   | dmu0_SpIES                  |

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_HSC-SSP.ipynb](1.1_HSC-SSP.ipynb) 
- [1.2_VIKING.ipynb](1.2_VIKING.ipynb)
- [1.3_VHS.ipynb](1.3_VHS.ipynb) 
- [1.4_VICS82.ipynb](1.4_VICS82.ipynb)
- [1.5_UKIDSS-LAS.ipynb](1.6_UKIDSS-LAS.ipynb) 
- [1.6_PanSTARRS-3SS.ipynb](1.7_PanSTARRS-3SS.ipynb) 
- [1.7_SHELA.ipynb](1.8_SHELA.ipynb)
- [1.8_SpIES.ipynb](1.9_SpIES.ipynb)

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
