Pan-STARRS1 - 3pi Steradian Survey DR1
======================================

This product contains the DR1 catalogue of the *Pan-STARRS1 3pi Steradian
Survey* made with the first telescope (PS1) of the *Panoramic Survey Telescope
and Rapid Response System* (Pan-STARRS).

# November 2017 update

On November 2017, the catalogue were updated with a new extraction aimed at
removing duplicate sources found in the PanSTARRS catalogue.  The new files are
named `v2` and the previous files will eventually migrate to an `old` folder and
be removed when we stop using them.

# *Notes for the ingestion*

Mattia and Lucia queried the PanSTARRS database on several fields using min-max
limits on RA and Dec to produce several catalogues.  We merged everything in
a single table and used the `filterAndTag.sh` script to limit to the sources on
HELP coverage.  Also, because the various queried fields overlap, we removed the
duplicated rows unique the `objID` column:

```shell
$ stilts tmatch1 matcher=exact values="objID" action=keep1 in=merged_cat.fits out=cleaned_cat.fits
```
We then created one catalogue per field.

# Readme

The available catalogues and quantities are described here
[here](https://confluence.stsci.edu/display/PANSTARRS/Pan-STARRS1+data+archive+home+page).
We downloaded the required photometry using the [Freeform SQL
Query](http://mastweb.stsci.edu/ps1casjobs) and the query we used is shown
below.

##NOTES

We downloaded only the photometry contained in the *ForcedMeanObject* table
described [here]
(https://confluence.stsci.edu/display/PANSTARRS/PS1+ForcedMeanObject+table+fields).
To recover the positions of the sources we joined this catalogue with the
*ObjectThin* catalogue described [here]
(https://confluence.stsci.edu/display/PANSTARRS/PS1+ObjectThin+table+fields) and
we selected only sources with `nDetections > 1`. Ideally we would have included
also the stack photometry in our catalogue, but at the moment we dediced to not
include this for the following reason: there is a known issue in the PS1 DR1
with duplicates sources in the [StackObjectThin]
(https://confluence.stsci.edu/display/PANSTARRS/PS1+StackObjectThin+table+fields)
catalogue which will not be resolved by the PS1 team before the next data
release.  For this reason we did not query the *StackObjectThin* catalogue for
the moment, resulting in a potential loss of ~8% of the sources, but with
a greater efficiency in avoiding duplicate sources. The user is encouraged to
check the Pan-STARRS web page and data archive for the latest updates.

##SQL QUERIES

*EXAMPLE FOR ELAIS-N1 field (to download other fields the user has to change the
RA and Dec limits of the query below)*

```sql
SELECT o.objID, o.objName, o.objPopularName, o.processingVersion, o.raMean, o.raMeanErr, o.decMean, o.decMeanErr, o.nDetections,
o.ng, o.nr, o.ni, o.nz, o.ny,
m.gFApFlux, m.gFApFluxErr, m.gFApMag, m.gFApMagErr, m.gFlags,
m.rFApFlux, m.rFApFluxErr, m.rFApMag, m.rFApMagErr, m.rFlags,
m.iFApFlux, m.iFApFluxErr, m.iFApMag, m.iFApMagErr, m.iFlags,
m.zFApFlux, m.zFApFluxErr, m.zFApMag, m.zFApMagErr, m.zFlags,
m.yFApFlux, m.yFApFluxErr, m.yFApMag, m.yFApMagErr, m.yFlags,
m.gFPSFMag, m.gFPSFMagErr,
m.rFPSFMag, m.rFPSFMagErr,
m.iFPSFMag, m.iFPSFMagErr,
m.zFPSFMag, m.zFPSFMagErr,
m.yFPSFMag, m.yFPSFMagErr,
m.gFKronFlux, m.gFKronFluxErr, m.gFKronMag, m.gFKronMagErr,
m.rFKronFlux, m.rFKronFluxErr, m.rFKronMag, m.rFKronMagErr,
m.iFKronFlux, m.iFKronFluxErr, m.iFKronMag, m.iFKronMagErr,
m.zFKronFlux, m.zFKronFluxErr, m.zFKronMag, m.zFKronMagErr,
m.yFKronFlux, m.yFKronFluxErr, m.yFKronMag, m.yFKronMagErr
FROM ObjectThin o
INNER JOIN ForcedMeanObject m ON o.objID=m.objID
WHERE
o.raMean between 239. and  247. and o.decMean between 52. and 58. and o.nDetections>1 into mydb.en1_ps1_dr1
```

