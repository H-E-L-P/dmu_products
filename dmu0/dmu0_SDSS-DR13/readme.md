Sloan Digital Sky Survey - 13<sup>th</sup> Data Release
=======================================================

This product contains the catalogues from the 13<sup>th</sup> data release of
the Sload Digital Sky Survey (SDSS-DR13).  Mattia queried the SDSS database and
sent us several files.

Because of overlaps between query coverages, we removed the duplicated rows
using the `objID` column:

```shell
$ stilts tmatch1 matcher=exact values="objID" action=keep1 in=merged_cat.fits out=cleaned_cat.fits
```

We also renamed the `field` column to `sdss_field` because the former name is
used in our workflow.

The resulting table was then processed with our `filterAndTag.sh` script and the
resulting catalogue was divided into one catalogue per field.

## Coverage per field

|      Field       |Coverage (%)|
|------------------|-----------:|
|            COSMOS|   100.0    |
|           GAMA-15|    99.9    |
|           XMM-LSS|    99.7    |
|            Bootes|   100.0    |
|        CDFS-SWIRE|     0.0    |
|          ELAIS-N1|    99.2    |
|           GAMA-12|   100.0    |
|           GAMA-09|    99.9    |
|     Lockman-SWIRE|    95.9    |
|               EGS|    96.9    |
|          ELAIS-S1|     0.0    |
|         AKARI-NEP|    28.4    |
|          ELAIS-N2|    99.8    |
|              xFLS|    99.8    |
|Herschel-Stripe-82|    99.9    |
|               NGP|     0.0    |
|               SGP|     0.0    |
|         AKARI-SEP|     0.0    |
|         SPIRE-NEP|    69.1    |
|              SSDF|     0.0    |
|             HDF-N|   100.0    |
|              SA13|     0.0    |
|          XMM-13hr|     0.0    |
|           __ALL__|    50.9    |
