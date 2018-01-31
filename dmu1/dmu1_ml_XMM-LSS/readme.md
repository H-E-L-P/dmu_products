# Master list on XMM-LSS

This folder contains the Jupyter notebooks used to create HELP mater list on
XMM-LSS. 

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|
| CANDELS-3D-HST | HST  | F140W, F160W, F606W, F814W, F125W        | dmu0_CANDELS-3D-HST |
| CANDELS-UDS    | HST  | ACS_F435W, ACS_F606W, ACS_F775W, ACS_F814W, ACS_F850LP, WFC3_F098M, WFC3_F105W, WFC3_F125W, WFC3_F140W, WFC3_F160W         | dmu0_CANDELS-UDS    |
| CFHT-WIRDS     | CFHT | J, H, Ks                                 | dmu0_CFHT-WIRDS     |
| CFHTLS         | CFHT | u*, g', r', i', z'                       | dmu0_CFHTLS         |
| CFHTLenS       | CFHT | u, g, r, i, z                            | dmu0_CFHTLenS       |
| DECaLS         | DEC  | ugrizY                                   | dmu0_DECaLS         |
| SERVS          | Spitzer | IRAC1234, MIPS123                   |mu0_DataFusion-Spitzer |
| SWIRE          | Spitzer | IRAC1234, MIPS123                   |mu0_DataFusion-Spitzer |
| HSC-SSP        | Subaru/Suprime  | grizy                         | dmu0_HSC            |
| PanSTARRS-3SS  | GPC1             | grizy                        | dmu0_PanSTARRS1-3SS |
| SXDS           | Subaru/Suprime | B, V, r, i, z                  | dmu0_SXDS           |
| SpARCS         | CFHT  | u, g, r, y, z                           | dmu0_SpARCS         |
| UKIDSS-DXS     | UKIRT WFCAM      | YJHK?                  |  dmu0_UKIDSS-DXS_DR10plus |
| UKIDSS-UDS     | UKIRT WFCAM      | YJHK?                        |  dmu0_UKIDSS-UDS    |
| VIPERS         | ZYHJKs?                                         | dmu0_VIPERS-MLS     |
| VHS            | VISTA VIRCAM     | ZYHJKs?                      | dmu0_VISTA-VHS      |
| VIDEO          | VISTA VIRCAM     | ZYHJKs?                 | dmu0_VISTA-VIDEO-private |
| VIKING         | VISTA VIRCAM     | ZYHJKs                       | dmu0_VISTA-VIKING   |
| DES            | Blanco/DECam     | grizy                        | dmu0_DES            |

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_CANDELS-3D-HST.ipynb](1.1_CANDELS-3D-HST.ipynb) 
- [1.2_CANDELS-UDS.ipynb](1.2) 
- [1.3_CFHT-WIRDS.ipynb](1.3_CFHT-WIRDS.ipynb)
- [1.4.1_CFHTLS-WIDE.ipynb](1.4.1_CFHTLS-WIDE.ipynb) 
- [1.4.2_CFHTLS-WIDE.ipynb](1.4.2_CFHTLS-WIDE.ipynb) 
- [1.5_CFHTLenS.ipynb](1.5_CFHTLenS.ipynb) 
- [1.6.1_DECaLS.ipynb](1.6.1_DECaLS.ipynb) 
- [1.6.2_DES.ipynb](1.6.2_DES.ipynb) 
- [1.7_SWIRE.ipynb](1.7_SWIRE.ipynb) 
- [1.8_SERVS.ipynb](1.8_SERVS.ipynb) 
- [1.9.1_HSC-WIDE.ipynb](1.9.1_HSC-WIDE.ipynb) 
- [1.9.2_HSC-DEEP.ipynb](1.9.2_HSC-DEEP.ipynb) 
- [1.9.3_HSC-UDEEP.ipynb](1.9.3_HSC-UDEEP.ipynb) 
- [1.10_PanSTARRS1-3SS.ipynb](1.10_PanSTARRS1-3SS.ipynb) 
- [1.11_SXDS.ipynb](1.11_) 
- [1.12_SpARCS.ipynb](1.12_SpARCS.ipynb) 
- [1.13_UKIDSS-DXS.ipynb](1.13_UKIDSS-DXS.ipynb) 
- [1.14_UKIDSS-UDS.ipynb](1.14_UKIDSS-UDS.ipynb) 
- [1.15_VIPERS.ipynb](1.15_VIPERS.ipynb) 
- [1.17_VISTA-VIDEO.ipynb](1.17_VISTA-VIDEO.ipynb) 
- [1.18_VISTA-VIKING.ipynb](1.18_VISTA-VIKING.ipynb) 


## Catalogue merging

The merging notebooks performs the merging of the pristine catalogues into the master list. Because XMM-LSS has so much data we must merge the similar bands first and then do the final merge on tiles as for HS82 and SGP. THe final stage is then to concatenate the tables using Stilts.

- [2.1_Megacam_merge.ipynb](2.1_Megacam_merge.ipynb)
- [2.2_UKIDSS_merge.ipynb](2.2_UKIDSS_merge.ipynb)
- [2.3_HSC_merge.ipynb](2.3_HSC_merge.ipynb)
- [2.4_VIRCAM_merge.ipynb](2.4_VIRCAM_merge.ipynb)
- [2.5_IRAC_merge.ipynb](2.5_IRAC_merge.ipynb)
- [2.6_DECAM_merging.ipynb](2.6_DECAM_merging.ipynb)
- [2.7_Merging.ipynb](2.7_Merging.ipynb)


## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.



