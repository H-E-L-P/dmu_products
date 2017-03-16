VISTA-VHS catalogues
====================

These catalogues where downloaded from the VISTA Science Archive using the
[Freeform SQL Query](http://horus.roe.ac.uk:8080/vdfs/VSQL_form.jsp). The VHSDR4
(VHSv20150407) database was queried, and the table *vhsSource* was used as it's
described in the schema as containing *merged sources from detections in
vhsDetection*.

The description of the columns (from the v20140402 version) is available
[there](http://horus.roe.ac.uk/vsa/www/VHSDR4/VHSDR4_TABLE_vhsSourceSchema.html)

We limited the queries to rows with `PRIORSEC = 0` to remove duplicated sources.

The SQL queries used are:

```sql
# AKARI-SEP
SELECT * FROM vhsSource WHERE priorsec=0 AND
ra BETWEEN 66.1 AND 75.5 AND dec BETWEEN -55.96 AND -51.61

# CDFS-SWIRE
SELECT * FROM vhsSource WHERE priorsec=0 AND
ra BETWEEN 50.7 AND 55.5 AND dec BETWEEN -30.50 AND -25.92

# ELAIS-S1
SELECT * FROM vhsSource WHERE priorsec=0 AND
ra BETWEEN 6.3 AND 11.3 AND dec BETWEEN -45.60 AND -41.53

# GAMA9
SELECT * FROM vhsSource WHERE priorsec=0 AND
ra BETWEEN 127.1 AND 142.2 AND dec BETWEEN -2.53 AND 3.55

# Herschel-Stripe-82
SELECT * FROM vhsSource WHERE priorsec=0 AND
ra >= 348.3 AND dec BETWEEN -9.5 AND 9.25

SELECT * FROM vhsSource WHERE priorsec=0 AND
ra <= 10. AND dec BETWEEN -9.5 AND 9.25

SELECT * FROM vhsSource WHERE priorsec=0 AND
(
  (ra between 10 AND 19.1 AND dec BETWEEN -9.5 AND 9.25)
  OR
  (ra BETWEEN 13.4 AND 36.3 AND dec BETWEEN -2.32 AND 2.49)
)

# SSDF
SELECT * FROM vhsSource WHERE priorsec=0 AND
ra BETWEEN 340.5 AND 350 AND dec BETWEEN -61.2 AND -48.6

SELECT * FROM vhsSource WHERE priorsec=0 AND
(ra >= 350 OR ra <= 2.8) AND dec BETWEEN -61.2 AND -48.6

# XMM-LSS
SELECT * FROM vhsSource WHERE priorsec=0 AND
ra BETWEEN 32.1 AND 38.2 AND dec BETWEEN -7.53 AND -1.52
```

The various result tables were then merged. In the catalogues, the position is
given in radians (but strangely the queries above succeed) so the columns were
renamed to `RA_radians` and `DEC_radians` and the columns `ra` and `dec` were
added with the position in decimal degrees.

The table was then processed with our `filterAndTag.sh` script to keep only the
sources within HELP coverage.  At last, we generated one table per field.

*Note: Eduardo used VHS data in the master lists on GAMA-09, and XMM-LSS fields,
but he used some private data.*
