# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP official SPIRE maps (dmu19)

This is a data product of the Herschel Extragalactic Legacy Project ([HELP](http://www.herschel.sussex.ac.uk))

This product contains the homogenised SPIRE maps of the Herschel Extragalactic
Legacy Project.

The full files which are not stored in the Git repository can be downloaded from HeDaM:

- [http://hedam.lam.fr/HELP/data/dmu_products/](http://hedam.lam.fr/HELP/data/dmu_products/)

## File structure

The FITS files have all the same structure with the Header Data Units (HDU)
listed below. 

1. Primary HDU.
2. **IMAGE**: The signal map in *Jy/beam*.
3. **NEBFILT**: The signal map filtered for nebular emission by the *nebular*
    software from Casutools (see *dmu19_nebular_filtered_maps*).
4. **ERROR**: The error map in *Jy/beam*.
5. **EXPOSURE**: The exposure map in *seconds*.
6. **MASK**: The mask map with the following values:
    - 0: no mask (*i.e.* good data);
    - 1: regions with low depth relative to the rest of the map.
7. **MFILT** Matched Filtered map *Jy/beam* (Chapin et al. 2011)
8. **MFILT_ERROR** The error map for the Matched Filtered map *Jy/beam*
9. **Matchedfilter** The Matched Filter used for the filtering

The maps were put in this structure using gen_maps_SD.py

### Fixme

The `hers-helms-xmm_itermap_20160623_PSW.fits` is corrupted and we can only
access the first HDU with the image map. I checked with Marco and the file is
also corrupted on Caltech servers. Someone should recreate the maps with only
the Herschel-Stripe-82 ObsIDs (i.e. without XMM-LSS, to get smaller files).

### Notes

- Some original maps does not contain exposure information but coverage maps
  expressed in number of hits.  These coverage maps where converted to exposure
  multiplying the hit value by 1/10 s for parallel mode and 1/18.6 s for
  standard observations.
- The mask definition is not exactly the same between surveys. For H-ATLAS, it
  only which pixels were observed or not. AKARI-NEP does not provide masks.
  For fields without a mask we create a mask, using EXPOSURE = 0 -> MASK = 1 
- The Matchedfilter header contains the information about the confusion noise,
  instumental noise and pixel size in arcsec used for the filter.    

## Lists of Herschel Observation identifiers (ObsIDs)

The Herschel observation identifiers (ObsIDs) used in each map are provided in
the headers of the primary HDU.  We also provide to list of ObsIDs relevant for
HELP.

### `HELP_ObsIDs_SPIRE.xls`

This files contains the list of the ObsIDs associated to HELP.  It is based on
the list produced by Seb, with a addition of the ObsIDs for AKARI-NEP and
SPIRE-NEP given by Chris.

- Some observation have a “failed” QC_status (in red in the spreadsheet) and are
    not available.
- The observation for *COSMOS_CANDELS* and *CANDELS_UDS-1* (in orange) are in
    the primary list of ObsIDs but are not used in HELP data products.
- We have to check with H-ATLAS to be sure they used all the ObsIDs in this
    list.
- There is a column “In_HELP” set to true for the ObsIDs actually used for HELP
    maps.
- When producing the big Herschel-Stripe-82 + XMM-LSS map, some observations
    were forgotten, the column “Missing_from_HS82_XMM” is true for them.

### `All_SPIRE_ObsIDs_on_HELP_coverage.fits`

This is the list of all the SPIRE ObsIDs queried from the Herschel Science
Archive (at the begining of October 2017) and limited to HELP coverage.

-------------------------------------------------------------------------------

**Authors**: Steven Duivenvoorden, Yannick Rohelly

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)

