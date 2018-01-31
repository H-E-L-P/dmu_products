# Master list on HDF-N

This folder contains the Jupyter notebooks used to create HELP mater list on
XMM-LSS. 

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|
| CANDELS-3D-HST | HST  | F140W, F160W, F606W, F814W, F125W        | dmu0_CANDELS-3D-HST |
| GOODS-ACS |                      |                                   | Not used        |
| Hawaii-HDFN | Subaru/Suprime     | BVRIZ Hk                          | dmu0_Hawai-HDFN |
| Ultradeep-Ks-GOODS-N | WIRCAM prior IRAC | K IRAC 1234     | dmu0_Ultradeep_Ks_GOODS-N |
| PanSTARRS-3SS | PanSTARRS/GPC1   | grizy                         | dmu0_PanSTARRS1-3SS |

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_CANDELS-3D-HST.ipynb](1.1_CANDELS-3D-HST.ipynb) 
- [1.2_GOODS-ACS.ipynb](1.2_GOODS-ACS.ipynb) 
- [1.3_Hawaii-HDFN.ipynb](1.3_Hawaii-HDFN.ipynb)
- [1.4_Ultradeep-Ks-GOODS-N.ipynb](1.4_Ultradeep-Ks-GOODS-N.ipynb) 
- [1.5_PanSTARRS1-3SS.ipynb](1.5_CFHTLenS.ipynb) 
- [1.6_DECaLS.ipynb](1.6_CANDELS-GOODS-N.ipynb) 


## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.



