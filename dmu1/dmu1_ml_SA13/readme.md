# Master list on SA-13
This folder contains the Jupyter notebooks used to create HELP mater list on
SA-13.

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_LegacySurvey.ipynb](1.1_LegacySurvey.ipynb) 
- [1.2_UHS.ipynb](1.2_UHS.ipynb) 


## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.



