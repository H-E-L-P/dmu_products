# Master list on Lockman-SWIRE

This folder contains the Jupyter notebooks used to create HELP mater list on
Lockman-SWIRE. The following table summarises the list of used catalogues.

| Survey     | Telescope / Instrument      |      Filters (detection band in bold)      | Location                    |
|------------|-----------------------------|:------------------------------------------:|-----------------------------|
| INT        | WFC	                       | ugriz	                                    | dmu0_INTWFC	              | 
| RCSLenS    | CFHT/MegaPrime/MegaCam      | grizy                                      | dmu0_RCSLenS                |
| PS1 3PSS   | Pan-STARRS1	               | grizy                                      | dmu0_PanSTARRS1-3SS	      | 
| SpARCS     | CFHT/MegaCam	               | ugrzy                                      | dmu0_SpARCS	              | 
| UKIDSS DXS | UKIRT/WFCAM                 | J,K                                        | dmu0_UKIDSS-DXS	          | 
| SWIRE      | Spitzer/IRAC MIPS           | IRAC1234 & MIPS123                         | dmu0_DataFusion-Spitzer	  | 
| SERVS      | Spitzer/IRAC                | IRAC12                                     | dmu0_DataFusion-Spitzer	  | 
| PS1 MDS    | Pan-STARRS1	               | grizy	                                    | Awaiting release...         |
[Relevant surveys]

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_INT.ipynb](1.1_INT.ipynb) 
- [1.2_RCSLenS.ipynb](1.2_RCSLenS.ipynb) 
- [1.3_PanSTARRS.ipynb](1.3_PanSTARRS.ipynb) 
- [1.4_SpARCS.ipynb](1.4_SpARCS.ipynb) 
- [1.5_UKIDSS-DXS.ipynb](1.5_UKIDSS-DXS.ipynb) 
- [1.6_SWIRE.ipynb](1.6_SWIRE.ipynb) 
- [1.7_SERVS.ipynb](1.7_SERVS.ipynb) 


## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
