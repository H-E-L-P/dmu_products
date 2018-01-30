Dark Energy Survey - Public Data Release 1 (DR1)
====================================================================================

Downloaded from https://des.ncsa.illinois.edu/easyweb/db-access using SQL given below. HELP coverage then limited using filter_and_tag.sh.

## Columns in catalogue:

Column name            | Content
-----------------------|------------------------------------------
COADD_OBJECT_ID        | Unique identifier for the coadded objects
RA                     | Right ascension, with quantized precision for indexing (ALPHAWIN_J2000 has full precision but not indexed) [degrees]
DEC                    | Declination, with quantized precision for indexing (DELTAWIN_J2000 has full precision but not indexed) [degrees]
CLASS_STAR_$BAND       | $BAND-band simple morphological extended source classifier. Values between 0 (galaxies) and 1 (stars). SPREAD_MODEL exhibits better performance
MAG_AUTO_$BAND         | $BAND-band magnitude estimation, for an elliptical model based on the Kron radius [mag]
MAGERR_AUTO_$BAND      | $BAND-band uncertainty in magnitude estimation, for an elliptical model based on the Kron radius [mag]
MAG_APER_$AP_$BAND     | Aperture $AP equivalent to **See below** [pixel], g-band magnitude estimation for circular apertures [mag]
MAGERR_APER_4_$BAND    | Aperture 4 equivalent to 7.41 [pixel], $BAND-band uncertainty in magnitude estimation for circular apertures [mag]


### Apertures

Aperture number   | Size
------------------|------------------------------------------
1                 |  1.85  [pixel] = 0.49 arcsec
2                 |  3.7   [pixel] = 0.97 arcsec
3                 |  5.55  [pixel] = 1.46 arcsec
4                 |  7.41  [pixel] = 1.95 arcsec
5                 |  11.11 [pixel] = 2.92 arcsec
6                 |  14.81 [pixel] = 3.90 arcsec
7                 |  18.52 [pixel] = 4.87 arcsec
8                 |  22.22 [pixel] = 5.84 arcsec
9                 |  25.93 [pixel] = 6.82 arcsec
10                |  29.63 [pixel] = 7.79 arcsec
11                |  44.44 [pixel] = 11.69 arcsec

The catalogues were downloaded using the following SQL query and then filtered to HELP coverage using filter_and_tag.sh. 

## SQL QUERIES

Job 1a49d93e-9aec-4706-a6c2-aa72182825b3 submitted

1. SQL used to download raw unfiltered data on HELP coverage.

```sql
-- Get HELP fields with apertures for curev of growth --
SELECT 
DR1_MAIN.COADD_OBJECT_ID, DR1_MAIN.RA, DR1_MAIN.DEC,  DR1_MAIN.CLASS_STAR_G, DR1_MAIN.CLASS_STAR_R, DR1_MAIN.CLASS_STAR_I, DR1_MAIN.CLASS_STAR_Z, DR1_MAIN.CLASS_STAR_Y, 

DR1_MAIN.MAG_AUTO_G, DR1_MAIN.MAGERR_AUTO_G,  DR1_MAGNITUDE.MAG_APER_1_G, DR1_MAGNITUDE.MAG_APER_2_G, DR1_MAGNITUDE.MAG_APER_3_G, DR1_MAGNITUDE.MAG_APER_4_G, DR1_MAGNITUDE.MAG_APER_5_G, DR1_MAGNITUDE.MAG_APER_6_G, DR1_MAGNITUDE.MAG_APER_7_G, DR1_MAGNITUDE.MAG_APER_8_G, DR1_MAGNITUDE.MAG_APER_9_G, DR1_MAGNITUDE.MAG_APER_10_G, DR1_MAGNITUDE.MAG_APER_11_G, 
DR1_MAGNITUDE.MAGERR_APER_4_G, 

DR1_MAIN.MAG_AUTO_R, DR1_MAIN.MAGERR_AUTO_R,  DR1_MAGNITUDE.MAG_APER_1_R, DR1_MAGNITUDE.MAG_APER_2_R, DR1_MAGNITUDE.MAG_APER_3_R, DR1_MAGNITUDE.MAG_APER_4_R, DR1_MAGNITUDE.MAG_APER_5_R, DR1_MAGNITUDE.MAG_APER_6_R, DR1_MAGNITUDE.MAG_APER_7_R, DR1_MAGNITUDE.MAG_APER_8_R, DR1_MAGNITUDE.MAG_APER_9_R, DR1_MAGNITUDE.MAG_APER_10_R, DR1_MAGNITUDE.MAG_APER_11_R, 
DR1_MAGNITUDE.MAGERR_APER_4_R, 

DR1_MAIN.MAG_AUTO_I, DR1_MAIN.MAGERR_AUTO_I,  DR1_MAGNITUDE.MAG_APER_1_I, DR1_MAGNITUDE.MAG_APER_2_I, DR1_MAGNITUDE.MAG_APER_3_I, DR1_MAGNITUDE.MAG_APER_4_I, DR1_MAGNITUDE.MAG_APER_5_I, DR1_MAGNITUDE.MAG_APER_6_I, DR1_MAGNITUDE.MAG_APER_7_I, DR1_MAGNITUDE.MAG_APER_8_I, DR1_MAGNITUDE.MAG_APER_9_I, DR1_MAGNITUDE.MAG_APER_10_I, DR1_MAGNITUDE.MAG_APER_11_I, 
DR1_MAGNITUDE.MAGERR_APER_4_I, 

DR1_MAIN.MAG_AUTO_Z, DR1_MAIN.MAGERR_AUTO_Z,  DR1_MAGNITUDE.MAG_APER_1_Z, DR1_MAGNITUDE.MAG_APER_2_Z, DR1_MAGNITUDE.MAG_APER_3_Z, DR1_MAGNITUDE.MAG_APER_4_Z, DR1_MAGNITUDE.MAG_APER_5_Z, DR1_MAGNITUDE.MAG_APER_6_Z, DR1_MAGNITUDE.MAG_APER_7_Z, DR1_MAGNITUDE.MAG_APER_8_Z, DR1_MAGNITUDE.MAG_APER_9_Z, DR1_MAGNITUDE.MAG_APER_10_Z, DR1_MAGNITUDE.MAG_APER_11_Z, 
DR1_MAGNITUDE.MAGERR_APER_4_Z, 

DR1_MAIN.MAG_AUTO_Y, DR1_MAIN.MAGERR_AUTO_Y, DR1_MAGNITUDE.MAG_APER_1_Y, DR1_MAGNITUDE.MAG_APER_2_Y, DR1_MAGNITUDE.MAG_APER_3_Y, DR1_MAGNITUDE.MAG_APER_4_Y, DR1_MAGNITUDE.MAG_APER_5_Y, DR1_MAGNITUDE.MAG_APER_6_Y, DR1_MAGNITUDE.MAG_APER_7_Y, DR1_MAGNITUDE.MAG_APER_8_Y, DR1_MAGNITUDE.MAG_APER_9_Y, DR1_MAGNITUDE.MAG_APER_10_Y, DR1_MAGNITUDE.MAG_APER_11_Y,
DR1_MAGNITUDE.MAGERR_APER_4_Y 
FROM DR1_MAIN, DR1_MAGNITUDE 
WHERE 
(DR1_MAIN.COADD_OBJECT_ID = DR1_MAGNITUDE.COADD_OBJECT_ID) AND
(
( DR1_MAIN.RA BETWEEN 209.9 AND 225.3 AND DR1_MAIN.DEC BETWEEN -2.57 AND 3.5 ) OR 
( DR1_MAIN.RA BETWEEN 32.1 AND 38.2 AND DR1_MAIN.DEC BETWEEN -7.53 AND -1.52 ) OR 
( DR1_MAIN.RA BETWEEN 50.7 AND 55.5 AND DR1_MAIN.DEC BETWEEN -30.50 AND -25.92 ) OR 
( DR1_MAIN.RA BETWEEN 172.2 AND 187.4 AND DR1_MAIN.DEC BETWEEN -3.54 AND 2.59 ) OR 
( DR1_MAIN.RA BETWEEN 127.1 AND 142.2 AND DR1_MAIN.DEC BETWEEN -2.53 AND 3.55 ) OR 
( DR1_MAIN.RA BETWEEN 6.3 AND 11.3 AND DR1_MAIN.DEC BETWEEN -45.60 AND -41.53 ) OR 
( (DR1_MAIN.RA >= 348.3 OR DR1_MAIN.RA <= 19.1) AND DR1_MAIN.DEC BETWEEN -9.5 AND 9.25 ) OR 
( DR1_MAIN.RA BETWEEN 13.4 AND 36.3 AND DR1_MAIN.DEC BETWEEN -2.32 AND 2.49 ) OR 
( (DR1_MAIN.RA >= 333.5 OR DR1_MAIN.RA <= 28.2) AND DR1_MAIN.DEC BETWEEN -37.1 AND -26.0 ) OR 
( DR1_MAIN.RA BETWEEN 66.1 AND 75.5 AND DR1_MAIN.DEC BETWEEN -55.96 AND -51.61 ) OR 
( (DR1_MAIN.RA >= 340.5 OR DR1_MAIN.RA <= 2.8) AND DR1_MAIN.DEC BETWEEN -61.2 AND -48.6 ))
```



