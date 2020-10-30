# All Sky summary catalogues

The catalogues made on each field are often very large. This is both due to the large sumber of galaxies (rows) and measurements (columns). Here we make a number of reduced data products which are easier to deal with. We make both reduced lists and cut the photometry columns down to the 'best' photometry. Firstly we remove all the individual measurements in a given camera band and replace them with the lowest error total flux measurement in all of the general broadband filters ugrizyJHKKs and the infrared irac/mips/pacs/spire fluxes. We then further reduce the number of galaxies to the XID+ prior list and the final A-list.


- './data/$FIELD_best_phot_$DATEMADE.fits', the best photometry for all objects on a field
- './data/$FIELD_best_phot_sources_$DATEMADE.fits', the camera source of each lowest error measurement
- [./data/HELP_xid_prior_20201029.fits](./data/HELP_xid_prior_20201029.fits), the xid prior list with the best photometry
- [./data/HELP_A-list_20201029.fits](./data/HELP_A-list_20201029.fits), the list of CIGALE objects with best photometry
