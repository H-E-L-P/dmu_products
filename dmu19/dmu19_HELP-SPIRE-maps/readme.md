HELP official SPIRE maps
========================

This product will contain the homogenised SPIRE maps of the Herschel
Extragalactic Legacy Project.

# Lists of Herschel Observation identifiers (ObsIDs)

## `HELP_ObsIDs_SPIRE.xls` and `HELP_ObsIDs_SPIRE.fits`

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

## `All_SPIRE_ObsIDs_on_HELP_coverage.fits`

This is the list of all the SPIRE ObsIDs queried from the Herschel Science
Archive (at the begining of October 2017) and limited to HELP coverage.

