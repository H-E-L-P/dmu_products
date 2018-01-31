# Master list on ELAIS S1

This folder contains the Jupyter notebooks used to create the HELP masterlist on
ELAIS S1. 

| Survey     | Telescope / Instrument      |      Filters (detection band in bold)      | Location                    |
|------------|-----------------------------|:------------------------------------------:|-----------------------------|
| VIDEO      | VISTA/VIRCAM	               | Y,J,H,Ks	                                | dmu0_VISTA-VIDEO            | 
| VHS        | VISTA/VIRCAM	               | Y,J,H,Ks	                                | dmu0_VISTA-VHS              |
| ESIS       | ESO 2.2/WFI                 | BVR                                        | dmu0_ESIS-VOICE             |
| SWIRE      | Spitzer/IRAC MIPS           | IRAC1234 & MIPS123                         | dmu0_DataFusion-Spitzer	  | 
| SERVS      | Spitzer/IRAC                | IRAC12                                     | dmu0_DataFusion-Spitzer	  | 
| DES-DEEP   | Blanco/DECAM	               | grizy                                      | dmu0_DES	      |        | 



## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_VISTA-VIDEO.ipynb](1.1_VISTA-VIDEO.ipynb) 
- [1.2_VISTA-VHS.ipynb](1.2_VISTA-VHS.ipynb) 
- [1.3_ESIS-VOICE.ipynb](1.3_ESIS-VOICE.ipynb) 
- [1.4_SWIRE.ipynb](1.4_SWIRE.ipynb) 
- [1.5_SERVS.ipynb](1.5_SERVS.ipynb)
- [1.5_DES.ipynb](1.5_DES.ipynb)

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.


