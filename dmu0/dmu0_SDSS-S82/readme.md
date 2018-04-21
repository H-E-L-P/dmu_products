SDSS Stripe-82 (DR7)
====================

# November 2017 version

Mattia did a new extraction from the SDSS database (not with the SQL queries
below) trying to solve the problem of duplicated sources.

# Old version

**This is the description of the first extraction from the SDSS data which had
problems of duplicated sources.***

This product contains the catalogue from the Sloan Digital Sky Survey (SDSS)
Stripe-82 observations (part of the SDSS-DR7).  The data was obtained querying
http://skyserver.sdss.org/CasJobs/ with the following queries:

```sql
SELECT INTO [myscratch:default].s82_1
 objID, ra, dec, skyVersion, type, probPSF,insideMask, flags,
 psfMag_u,psfMag_g,psfMag_r,psfMag_i,psfMag_z,
 psfMagErr_u,psfMagErr_g,psfMagErr_r,psfMagErr_i,psfMagErr_z,
 fiberMag_u,fiberMag_g,fiberMag_r,fiberMag_i,fiberMag_z,
 fiberMagErr_u,fiberMagErr_g,fiberMagErr_r,fiberMagErr_i,fiberMagErr_z,
 petroMag_u,petroMag_g,petroMag_r,petroMag_i,petroMag_z,
 petroMagErr_u,petroMagErr_g,petroMagErr_r,petroMagErr_i,petroMagErr_z,
 modelMag_u,modelMag_g,modelMag_r,modelMag_i,modelMag_z,
 modelMagErr_u,modelMagErr_g,modelMagErr_r,modelMagErr_i,modelMagErr_z
FROM PhotoPrimary
WHERE
  (
    ((RA >= 348.3 OR RA <= 19.1) AND DEC BETWEEN -9.5 AND 9.25)
    OR
    RA BETWEEN 13.4 AND 36.3 AND DEC BETWEEN -2.32 AND 2.49
  )
  AND RA >= 348

SELECT INTO [myscratch:default].s82_2
 objID, ra, dec, skyVersion, type, probPSF,insideMask, flags,
 psfMag_u,psfMag_g,psfMag_r,psfMag_i,psfMag_z,
 psfMagErr_u,psfMagErr_g,psfMagErr_r,psfMagErr_i,psfMagErr_z,
 fiberMag_u,fiberMag_g,fiberMag_r,fiberMag_i,fiberMag_z,
 fiberMagErr_u,fiberMagErr_g,fiberMagErr_r,fiberMagErr_i,fiberMagErr_z,
 petroMag_u,petroMag_g,petroMag_r,petroMag_i,petroMag_z,
 petroMagErr_u,petroMagErr_g,petroMagErr_r,petroMagErr_i,petroMagErr_z,
 modelMag_u,modelMag_g,modelMag_r,modelMag_i,modelMag_z,
 modelMagErr_u,modelMagErr_g,modelMagErr_r,modelMagErr_i,modelMagErr_z
FROM PhotoPrimary
WHERE
  (
    ((RA >= 348.3 OR RA <= 19.1) AND DEC BETWEEN -9.5 AND 9.25)
    OR
    RA BETWEEN 13.4 AND 36.3 AND DEC BETWEEN -2.32 AND 2.49
  )
  AND RA >= 0 AND RA < 20

SELECT INTO [myscratch:default].s82_3
 objID, ra, dec, skyVersion, type, probPSF,insideMask, flags,
 psfMag_u,psfMag_g,psfMag_r,psfMag_i,psfMag_z,
 psfMagErr_u,psfMagErr_g,psfMagErr_r,psfMagErr_i,psfMagErr_z,
 fiberMag_u,fiberMag_g,fiberMag_r,fiberMag_i,fiberMag_z,
 fiberMagErr_u,fiberMagErr_g,fiberMagErr_r,fiberMagErr_i,fiberMagErr_z,
 petroMag_u,petroMag_g,petroMag_r,petroMag_i,petroMag_z,
 petroMagErr_u,petroMagErr_g,petroMagErr_r,petroMagErr_i,petroMagErr_z,
 modelMag_u,modelMag_g,modelMag_r,modelMag_i,modelMag_z,
 modelMagErr_u,modelMagErr_g,modelMagErr_r,modelMagErr_i,modelMagErr_z
FROM PhotoPrimary
WHERE
  (
    ((RA >= 348.3 OR RA <= 19.1) AND DEC BETWEEN -9.5 AND 9.25)
    OR
    RA BETWEEN 13.4 AND 36.3 AND DEC BETWEEN -2.32 AND 2.49
  )
  AND RA >= 20 AND RA < 37

```

We queried the `PhotoPrimary` view to get only the primary objects. We also
queried only a selection of columns described in the following table.

| Name          | Type     | Size | Unit | Summary                                                                                           |
|---------------|----------|------|------|---------------------------------------------------------------------------------------------------|
| objID         | bigint   | 8    |      | Unique SDSS identifier composed from [skyVersion, rerun, run, camcol, field, obj].                |
| ra            | float    | 8    | deg  | J2000 right ascension (r')                                                                        |
| dec           | float    | 8    | deg  | J2000 declination (r')                                                                            |
| skyVersion    | tinyint  | 1    |      | 0 = OPDB target,  1 = OPDB best                                                                   |
| type          | smallint | 2    |      | Morphological type classification of the object.                                                  |
| probPSF       | real     | 4    |      | Probability that the object is a star. Currently 0 if type == 3 (galaxy),  1 if type == 6 (star). |
| insideMask    | tinyint  | 1    |      | Flag to indicate whether object is inside a mask and why                                          |
| flags         | bigint   | 8    |      | Photo Object Attribute Flags                                                                      |
| psfMag_u      | real     | 4    | mag  | PSF flux                                                                                          |
| psfMag_g      | real     | 4    | mag  | PSF flux                                                                                          |
| psfMag_r      | real     | 4    | mag  | PSF flux                                                                                          |
| psfMag_i      | real     | 4    | mag  | PSF flux                                                                                          |
| psfMag_z      | real     | 4    | mag  | PSF flux                                                                                          |
| psfMagErr_u   | real     | 4    | mag  | PSF flux error                                                                                    |
| psfMagErr_g   | real     | 4    | mag  | PSF flux error                                                                                    |
| psfMagErr_r   | real     | 4    | mag  | PSF flux error                                                                                    |
| psfMagErr_i   | real     | 4    | mag  | PSF flux error                                                                                    |
| psfMagErr_z   | real     | 4    | mag  | PSF flux error                                                                                    |
| fiberMag_u    | real     | 4    | mag  | Flux in 3 arcsec diameter                                                                         |
| fiberMag_g    | real     | 4    | mag  | Flux in 3 arcsec diameter                                                                         |
| fiberMag_r    | real     | 4    | mag  | Flux in 3 arcsec diameter                                                                         |
| fiberMag_i    | real     | 4    | mag  | Flux in 3 arcsec diameter                                                                         |
| fiberMag_z    | real     | 4    | mag  | Flux in 3 arcsec diameter                                                                         |
| fiberMagErr_u | real     | 4    | mag  | Flux in 3 arcsec diameter error                                                                   |
| fiberMagErr_g | real     | 4    | mag  | Flux in 3 arcsec diameter error                                                                   |
| fiberMagErr_r | real     | 4    | mag  | Flux in 3 arcsec diameter error                                                                   |
| fiberMagErr_i | real     | 4    | mag  | Flux in 3 arcsec diameter error                                                                   |
| fiberMagErr_z | real     | 4    | mag  | Flux in 3 arcsec diameter error                                                                   |
| petroMag_u    | real     | 4    | mag  | Petrosian flux                                                                                    |
| petroMag_g    | real     | 4    | mag  | Petrosian flux                                                                                    |
| petroMag_r    | real     | 4    | mag  | Petrosian flux                                                                                    |
| petroMag_i    | real     | 4    | mag  | Petrosian flux                                                                                    |
| petroMag_z    | real     | 4    | mag  | Petrosian flux                                                                                    |
| petroMagErr_u | real     | 4    | mag  | Petrosian flux error                                                                              |
| petroMagErr_g | real     | 4    | mag  | Petrosian flux error                                                                              |
| petroMagErr_r | real     | 4    | mag  | Petrosian flux error                                                                              |
| petroMagErr_i | real     | 4    | mag  | Petrosian flux error                                                                              |
| petroMagErr_z | real     | 4    | mag  | Petrosian flux error                                                                              |
| modelMag_u    | real     | 4    | mag  | better of DeV/Exp magnitude fit                                                                   |
| modelMag_g    | real     | 4    | mag  | better of DeV/Exp magnitude fit                                                                   |
| modelMag_r    | real     | 4    | mag  | better of DeV/Exp magnitude fit                                                                   |
| modelMag_i    | real     | 4    | mag  | better of DeV/Exp magnitude fit                                                                   |
| modelMag_z    | real     | 4    | mag  | better of DeV/Exp magnitude fit                                                                   |
| modelMagErr_u | real     | 4    | mag  | better of DeV/Exp magnitude fit error                                                             |
| modelMagErr_g | real     | 4    | mag  | better of DeV/Exp magnitude fit error                                                             |
| modelMagErr_r | real     | 4    | mag  | better of DeV/Exp magnitude fit error                                                             |
| modelMagErr_i | real     | 4    | mag  | better of DeV/Exp magnitude fit error                                                             |
| modelMagErr_z | real     | 4    | mag  | better of DeV/Exp magnitude fit error                                                             |

The resulting tables were joined and limited to HELP coverage. All the catalogue
fall over Herschel-Stripe-82 field.

## Notes

- There is no Kron magnitude. Check with science team to decide which one to use
    as total magnitude.
- The magnitudes should be AB, but to check.
- There is only one aperture magnitude provided.  Check with science team to
    establish if it is aperture corrected and to find a way to correct it if
    not.
