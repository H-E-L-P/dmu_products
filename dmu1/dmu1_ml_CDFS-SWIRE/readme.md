# Master list on CDFS-SWIRE

This folder contains the Jupyter notebooks used to create HELP mater list on
CDFS-SWIRE. The following table summarises the list of used catalogues.

| Survey    | Telescope / Instrument      |      Filters (detection band in bold)      | Location                    |
|-----------|-----------------------------|:------------------------------------------:|-----------------------------|
| VIDEO     | VISTA/VIRCAM                | **u**,**g**,**r**,**i**,**z** |dmu0_VISTA-VIDEO, dmu0_VISTA-VIDEO-private|
| SWIRE     | Spitzer / IRAC              | **IRAC1**,**IRAC2**,**IRAC3**,**IRAC4**    | dmu0_DataFusion-Spitzer     |
| SERVS     | Spitzer / IRAC              | **IRAC1**, **IRAC2**                       | dmu0_DataFusion-Spitzer     |
| PS1 3PSS  | Pan-STARRS1 / Pan-STARRS1   | grizy                                      | dmu0_PanSTARRS1-3SS         |
| PS1 MDS	| Pan-STARRS1 / Pan-STARRS1   |	grizy                                      | ...awaiting release         |
| VOICE	    | VST/OmegaCAM	              | u,g,r,i                                    | ...waiting for Mattia       |
| CTIO/CDFS | CTIO/MOSAIC	              | g,r,i                                      | ...waiting for Mattia       |
| DES-DEEP	| Blanco/DECAM	              | grizy                                      | ...awaiting release         |
| Fireworks	| HST	ACS	                  | U38, B435, B, V, V606, R, i775, I, z850, J, H, **Ks**, IRAC1, IRAC2, IRAC3, IRAC4   | dmu0_Fireworks              |
| COMBO-17	| ESO/MPG 	/WFI	          |                                            | dmu0_COMBO-17               |
| GOODS	    | Spitzer		              |                                            | ...unknown status           |



## Pristine catalogue preparations

For each pristine catalogue, a specific notebook is used for its preparation:
the selection of columns, the conversion of some magnitudes or fluxes when
needed, the removal of duplicated sources, the correction of astrometry using
Gaia as reference, and the flagging of possible Gaia objects.

- [1.1_VIDEO.ipynb](1.1_VIDEO.ipynb) for VISTA Telescope / VIRCAM
  Camera/ VIDEO survey data
- [1.2_SERVS.ipynb](1.2_SERVS.ipynb) for Spitzer datafusion SERVS data
- [1.3_SWIRE.ipynb](1.3_SWIRE.ipynb) for Spitzer datafusion SWIRE data
- [1.4_PanSTARRS.ipynb](1.4_PanSTARRS.ipynb) for PanSTARRS data
- [1.5_Fireworks.ipynb](1.5_Fireworks.ipynb) for Fireworks data
- [1.6_COMBO.ipynb](1.6_COMBO.ipynb) for COMBO data

## Catalogue merging

The [2_Merging.ipynb](2_Merging.ipynb) notebook performs the merging of the
pristine catalogues into the master list.

## Diagnostics

The [3_Checks_and_diagnostics.ipynb](3_Checks_and_diagnostics.ipynb) notebook
presents some checks and diagnostic plots on the final master list.
