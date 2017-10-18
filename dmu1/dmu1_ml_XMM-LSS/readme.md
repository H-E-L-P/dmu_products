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
| SpIES          | Spitzer | IRAC12                                | dmu0_SpIES          |
| SpUDS          | Spitzer | IRAC1234                              | dmu0_SpUDS          |
| UKIDSS-DXS     | UKIRT WFCAM      | YJHK?                  |  dmu0_UKIDSS-DXS_DR10plus |
| UKIDSS-UDS     | UKIRT WFCAM      | YJHK?                        |  dmu0_UKIDSS-UDS    |
| VIPERS         | ZYHJKs?                                         | dmu0_VIPERS-MLS     |
| VHS            | VISTA VIRCAM     | ZYHJKs?                      | dmu0_VISTA-VHS      |
| VIDEO          | VISTA VIRCAM     | ZYHJKs?                 | dmu0_VISTA-VIDEO-private |
| VIKING         | VISTA VIRCAM     | ZYHJKs                       | dmu0_VISTA-VIKING   |

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_](1.1_) 
- [1.2_](1.2) 
- [1.3_](1.3_ )
- [1.4_](1.4_) 
- [1.5_](1.5_) 
- [1.6_](1.6_) 
- [1.7_](1.7_) 
- [1.8_](1._) 
- [1.9_](1._) 
- [1.10_](1._) 
- [1.11_](1._) 
- [1.12_](1._) 
- [1.13_](1._) 
- [1.14_](1._) 
- [1.15_](1._) 
- [1.16_](1._) 
- [1.17_](1._) 
- [1.18_](1._) 
- [1.19_](1._) 
- [1.20_](1._) 

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.



