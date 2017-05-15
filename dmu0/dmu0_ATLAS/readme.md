VST-ATLAS survey catalogues
===========================

These catalogues were downloaded from the OmegaCam Science Archive (OSA) using
the [Freeform SQL Query](http://osa.roe.ac.uk/#dbaccess_SQL_form_div).  The
ATLASDR3 database was queried and the table *atlasSource* was used as it is
described in the schema as containing *merged sources from detection in
atlasDetection*. We also limited to rows with `(priOrSec<=0 OR
priOrSec=frameSetID)` to remove duplicates.

The OSA web site provides Multi-Order Coverage maps (MOC) for the different
surveys. Using the one corresponding to the ATLAS database version
*20160425(Proprietary)* (no MOC is provided for DR3) and comparing it to the
HELP coverage gives these percentages of coverage for each field:

|      Field       |Coverage|
|------------------|-------:|
|            COSMOS|     0.0|
|           GAMA-15|     1.5|
|           XMM-LSS|     0.0|
|            Bootes|     0.0|
|        CDFS-SWIRE|   100.0|
|          ELAIS-N1|     0.0|
|           GAMA-12|    15.2|
|           GAMA-09|     0.0|
|     Lockman-SWIRE|     0.0|
|               EGS|     0.0|
|          ELAIS-S1|     0.0|
|         AKARI-NEP|     0.0|
|          ELAIS-N2|     0.0|
|              xFLS|     0.0|
|Herschel-Stripe-82|    0.02|
|               NGP|     0.0|
|               SGP|   100.0|
|         AKARI-SEP|     0.0|
|         SPIRE-NEP|     0.0|
|              SSDF|     0.0|
|             HDF-N|     0.0|
|              SA13|     0.0|
|          XMM-13hr|     0.0|
|           __ALL__|    25.1|

We will then only use ATLAS for CDFS-SWIRE and NGP. The SQL queries used are:

```sql
# CDFS-SWIRE
SELECT * FROM ATLASDR3.atlasSource
WHERE (priOrSec<=0 OR priOrSec=frameSetID) AND
ra BETWEEN 50.7 AND 53 AND dec BETWEEN -30.50 AND -25.92

SELECT * FROM ATLASDR3.atlasSource
WHERE (priOrSec<=0 OR priOrSec=frameSetID) AND
ra BETWEEN 53 AND 55.5 AND dec BETWEEN -30.50 AND -25.92

# HATLAS-SGP (queried by people at the Royal Observatory of Edinburgh)
SELECT * FROM ATLASDR3.atlasSource
WHERE (priOrSec<=0 OR priOrSec=frameSetID) AND
(ra >= 333.5 OR ra <= 28.2) AND dec BETWEEN -37.1 AND -26.0
```

The resulting files were then merged and processed by `filterAndTag.sh` to keep
only the sources on HELP coverage.

The description of the columns is available
[there](http://osa.roe.ac.uk/ATLASDR3/ATLASDR3_TABLE_atlasSourceSchema).
