# Master list on EGS

This folder contains the Jupyter notebooks used to create HELP mater list on
EGS. 

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|
| AEGIS   |                       | 	J,H,K                 |    	dmu0_AEGIS	   |
| HSC    | Subaru/Hypersuprime     |  grizy                            | dmu0_HSC        |                              			
| PS1 3PS | Pan-STARRS1            |  grizy                            |                 | 
| PS1 MDS | Pan-STARRS1            |  grizy		                       |                 |
| CFHTLS Wide | CFHT MegaCam	   |u, g', r', z' and either i' or y	| dmu0_CFHTLS	|
| CFHTLS Deep | CFHT/MegaCam	   |u, g', r', z' and either i' or y	| dmu0_CFHTLS	|
| CFHTLenS | CFHT/MegaCam	       | u,g,r,i,z	                |      dmu0_CFHTLenS	|
| CFHT/DEEP2		|||	
| NICMOS			|||	
| EGS-ACS/HST/ACS	V,I		|||	
| EGS-IRAC	Spitzer		|||	
| CANDELS/3D-HST			|||	

## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_AEGIS.ipynb](1.1_AEGIS.ipynb) 
- [1.2_CANDELS-3D-HST.ipynb](1.2_CANDELS-3D-HST.ipynb) 
- [1.3_CFHT-WIRDS.ipynb](1.3_CFHT-WIRDS.ipynb) 
- [1.4_CFHTLS.ipynb](1.4_CFHTLS.ipynb) 
- [1.5_CFHTLenS.ipynb](1.5_CFHTLenS.ipynb) 
- [1.6_CANDELS-EGS.ipynb](1.6_CANDELS-EGS.ipynb) 
- [1.7_DEEP2.ipynb](1.7_DEEP2.ipynb) 
- [1.8_IRAC-EGS.ipynb](1.8_IRAC-EGS.ipynb)
- [1.9_HSC.ipynb](1.9_HSC.ipynb)
- [1.10_PanSTARRS1-3SS.ipynb](1.10_PanSTARRS1-3SS.ipynb)
- [1.11_LegacySurvey.ipynb](1.11_LegacySurvey.ipynb)
- [1.12_UHS.ipynb](1.12_UHS.ipynb)


## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.



