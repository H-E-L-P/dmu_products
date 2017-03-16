VISTA-VIKING catalogues
=======================

These catalogues where downloaded from the VISTA Science Archive using the
[Freeform SQL Query](http://horus.roe.ac.uk:8080/vdfs/VSQL_form.jsp). The
VIKINGDR4 (VIKINGv20140530) database was queried, and the table *vikingSource*
was used as it's described in the schema as containing *merged sources from
detections in vikingDetection*.

The description of the columns (from the v20140402 version) is available
[there](http://horus.roe.ac.uk/vsa/www/VIKINGv20140402/VIKINGv20140402_TABLE_vikingDetectionSchema.html)

We limited the queries to rows with `PRIORSEC = 0` to remove duplicated sources.

The SQL queries used are:

```sql
# CDFS-SWIRE
SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 50.7 AND 55.5 AND dec BETWEEN -30.50 AND -25.92

# GAMA9
SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 127.1 AND 130 AND dec BETWEEN -2.53 AND 3.55

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 130 AND 135 AND dec BETWEEN -2.53 AND 3.55

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 135 AND 140 AND dec BETWEEN -2.53 AND 3.55

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 140 AND 142.2 AND dec BETWEEN -2.53 AND 3.55

# GAMA12
SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 172.2 AND 175 AND dec BETWEEN -3.54 AND 2.59

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 175 AND 180 AND dec BETWEEN -3.54 AND 2.59

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 180 AND 185 AND dec BETWEEN -3.54 AND 2.59

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 185 AND 187.4 AND dec BETWEEN -3.54 AND 2.59

# GAMA15
SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 209.9 AND 215 AND dec BETWEEN -2.57 AND 3.5

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 215 AND 220 AND dec BETWEEN -2.57 AND 3.5

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 220 AND 225.3 AND dec BETWEEN -2.57 AND 3.5

# HATLAS-SGP
SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 333.5 AND 340 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 340 AND 345 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 345 AND 350 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 350 AND 355 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 355 AND 360 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 0 AND 5 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 5 AND 10 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 10 AND 15 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 15 AND 20 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 20 AND 25 AND DEC BETWEEN -37.1 AND -26

SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 25 AND 28.2 AND DEC BETWEEN -37.1 AND -26

# XMM-LSS
SELECT * FROM vikingSource WHERE priorsec=0 AND
ra BETWEEN 32.1 AND 38.2 AND dec BETWEEN -7.53 AND -1.52
```

The various result tables were then merged. In the catalogues, the position is
given in radians (but strangely the queries above succeed) so the columns were
renamed to `RA_radians` and `DEC_radians` and the columns `ra` and `dec` were
added with the position in decimal degrees.

The table was then processed with our `filterAndTag.sh` script to keep only the
sources within HELP coverage.  At last, we generated one table per field.

*Note: Eduardo used VIKING data in the master lists on XMM-LSS, GAMA-09, GAMA-12
and GAMA-15 fields, but he used some private data.*
