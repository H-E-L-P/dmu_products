HELP DMU26 XID+ photometry repository
===========================

This repository contains all the photometry produced for HELP using XID+. 

XID+ Overview
-------------
XID+ is developed using a probabilistic Bayesian framework which provides
  a natural framework in which to include prior information, and uses the
  Bayesian inference tool Stan to obtain the full posterior probability
  distribution on flux estimates (see [Hurley et al. 2017](http://adsabs.harvard.edu/cgi-bin/bib_query?arXiv:1606.05770) for more details).
  
  The XID+ data products for HELP, are created using the HPC design of the code, which splits the map into overlapping tiles, which are independently fit.

Repository Structure
---------------
The repository is organised such that there is a folder per field and band.
 For example, for the ELAIS-N1 field, there are:

* [dmu26_XID+MIPS_ELAIS_N1](dmu26_XID+MIPS_ELAIS_N1)
* [dmu26_XID+PACS_ELAIS_N1](dmu26_XID+PACS_ELAIS_N1)
* [dmu26_XID+SPIRE_ELAIS_N1](dmu26_XID+SPIRE_ELAIS_N1)

The final XID+ data products can be found on HeDaM at:

- http://hedam.lam.fr/HELP/data/dmu_products/dmu26/dmu26_XID+{BAND}_{FIELD}/data/

Each XID+ folder contains:
* a readme.md describing the commands used to run the field
* a `prior` notebook, used to read in maps, psf and catalogues and used to create the prior files (`Master_prior.pkl`, `Tiles.pkl`) for XID+
* a `XID_plus_hier.sh` shell script to submit an HPC job which breaks down the `Master_prior.pkl` into smaller hierarchical tiles used in the tiling scheme
* a `XID_plus_tile.sh` shell script to submit an HPC job to run the XID+ fit on each tile
* a `XIDp_run_script.py` python file, used by `XID_plus_tile.sh`, which fits the tiles
* a `'make_combined_map.py` python file used to combine all the Bayesian P value maps and check for any failed tiles
* a `final_processing` notebook to read in output catalogue, validate, assign level of detection and add flags to catalogue
* `*.yml` files, documenting the input files used to produce the data products.