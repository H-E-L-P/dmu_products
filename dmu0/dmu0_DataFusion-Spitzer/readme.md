DataFusion-Spitzer Catalogues
=============================

This product contains Spitzer catalogues originating from Vaccari *et al.* “Data
Fusion” work and described in:

Vaccari et al. 2010, A&A, 518, L20 and Vaccari 2015, PoS, 267, 27
(http://www.mattiavaccari.net/df)

# SERVS Band-Merged Catalogues

SERVS-IRAC12 "Bandmerge" - Mattia Vaccari (UWC) & Lucia Marchetti (OU)
& Eduardo Gonzalez-Solares (IoA)

We produced single-band IRAC1 and IRAC2 catalogs, measured aperture and
integrated fluxes/magnitudes and corrected aperture fluxes/magnitudes
using the correction factors adopted by SWIRE DR2/3 by Surace+ 2005

http://irsa.ipac.caltech.edu/data/SPITZER/SWIRE/docs/delivery_doc_r2_v2.pdf

We did merge single-band IRAC1 and IRAC2 catalogs into an IRAC12 catalog
using a search radius of 1.0 arcsec

We did add three columns at the beginning of the catalog

- ID_12 index to track sources (single-band indices are NUMBER_1 and
  NUMBER_2)
- RA_12 and DEC_12 which are average values for sources detected in both
  IRAC1 and IRAC2

# Spitzer-SWIRE Catalogues

In SWIRE fields, IRAC and MIPS source extraction was carried out using the
techniques developed by Surace+ (2005), Shupe+ (2008) and Frayer+ (2006).
The catalogue reports all 'IRAC 3.6 micron or IRAC 4.5 micron' detections,
and aperture fluxes are aperture corrected.

# Spitzer Boötes and xFLS Catalogues

In Boötes and xFLS, RAC and MIPS catalogues were extracted by the Data Fusion team
following the best practices developed and used for the Spitzer-SWIRE catalogues.
