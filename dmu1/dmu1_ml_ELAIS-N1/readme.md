# Master list on ELAIS-N1

This folder contains the Jupyter notebooks used to create HELP mater list on
ELAIS-N1. *Note: The [0_main.ipynb](0_main.ipynb) contains the same thing than
this readme and is easier to read from within Jupyter.*

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_INT-WFC.ipynb](1.1_INT-WFC.ipynb) for Isaac Newton Telescope / Wide Field
  Camera (INT/WFC) data
- [1.2_UKIDSS-DXS.ipynb](1.2_UKIDSS-DXS.ipynb) for UKIRT Infrared Deep Sky
  Survey / Deep Extragalactic Survey (UKIDSS/DXS) data -
- [1.3_HSC-SSP.ipynb](1.3_HSC-SSP.ipynb) for Hyper Suprime-Cam Subaru Strategic
  Program Catalogues (HSC-SSP) data -
- [1.4_PanSTARRS-3SS.ipynb](1.4_PanSTARRS-3SS.ipynb) for Pan-STARRS1 - 3pi
  Steradian Survey (3SS) data
- [1.5_SpARCS.ipynb](1.5_SpARCS.ipynb) for Spitzer Adaptation of the
  Red-sequence Cluster Survey (SpARCS) data
- [1.6_SERVS.ipynb](1.6_SERVS.ipynb) for Spitzer datafusion SERVS data
- [1.7_SWIRE.ipynb](1.7_SWIRE.ipynb) for Spitzer datafusion SWIRE data

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
