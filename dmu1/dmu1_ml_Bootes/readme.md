# Master list on Bootes

Bootes is based on a catalogue produced by Michael Brown (currently unpublished). This is described in dmu_0_Bootes_Brown. We decided to also make a catalogue using the standard HELP process in order to check the Bootes Brown catalogue. After doing this we found that the aperture matched catalogue of Brown performed better in the photometric redshift pipeline. This may be due to the fact that there are no 5+ band surveys on Bootes so the extra constraints from aperture matching all the bands simultaneously yield a larger fraction of good redshifts.

| Survey | Telescope / Instrument  | Filters (detection band in bold)  | Location        |
|--------|-------------------------|:---------------------------------:|-----------------|
| DECaLS | Blanco/DECam            | g, r, z                           | dmu0_DECaLS     |
| DataFusion | Spitzer/IRAC        | IRAC1234                  | dmu0_DataFusion-Spitzer |
| IBIS   |                         | J, H, Ks                          | dmu0_IBIS       |
| Legacy Survey |  BASS            | g, r,  z                       | dmu0_LegacySurvey  |
| NDWFS  |                         | R, I, Bw, Ks                      | dmu0_NDWFS      |
| PanSTARRS-3SS | PanSTARRS/GPC1   | g, r, i, z, y                | dmu0_PanSTARRS1-3SS  |
| SDWFS  | Spitzer/IRAC            | IRAC1234                          | dmu0_SDWFS      |
| UHS    | UKIRT                   | J                                 | dmu0_UHS        |
| zBootes |                        | z                                 | dmu0_zBootes    |

Here all we do is astrometry correction and other things to make the catalogue into HELP format.


- [1.1_DECaLS.ipynb](1.1_DECaLS.ipynb)
- [1.2_DataFusion-Spitzer.ipynb](1.2_DataFusion-Spitzer.ipynb)
- [1.3_IBIS.ipynb](1.3_IBIS.ipynb)
- [1.4_LegacySurvey.ipynb](1.4_LegacySurvey.ipynb)
- [1.5_NDWFS.ipynb](1.5_NDWFS.ipynb)
- [1.6_PanSTARRS-3SS.ipynb](1.6_PanSTARRS-3SS.ipynb)
- [1.7_SDWFS.ipynb](1.7_SDWFS.ipynb)
- [1.8_UHS.ipynb](1.8_UHS.ipynb)
- [1.9_zBootes.ipynb](1.9_zBootes.ipynb)

## Merging

- [2.0_Brown_Reformatting.ipynb](2.0_Brown_Reformatting.ipynb) 
- [2.1_HELP_Merging.ipynb](2_HELP_Merging.ipynb) 

## Diagnostics
There are two diagnostics to allow comparisons between the HELP masterlist and Michael Brown's

-[3.0_Brown_Checks_and_diagnostics.ipynb](3.0_Brown_Checks_and_diagnostics.ipynb) 
-[3.1_HELP_Checks_and_diagnostics.ipynb](3.0_HELP_Checks_and_diagnostics.ipynb) 

## Depth map production

-[4_Selection_function.ipynb](4_Selection_function.ipynb) 

