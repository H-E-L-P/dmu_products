Pan-STARRS1 - 3pi Steradian Survey
==================================

This product contains the catalogue from the *PanSTARRS1 3pi Steradian Survey*
made with the first telescope (PS1) of the *Panoramic Survey Telescope and Rapid
Response System* (Pan-STARRS).

Mattia queried the PS1 database en sent us several files that we merged in
a single table.  Because of overlaps between the query coverages, we removed the
duplicated rows using the `uniquePspsSTid` column:

```shell
$ stilts tmatch1 matcher=exact values="uniquePspsSTid" action=keep1 in=merged_cat.fits out=cleaned_cat.fits
```

The resulting table was then processed with our `filterAndTag.sh` script to
limit the catalogue to HELP coverage. The catalogue contains one set of
coordinate columns per band.  Only the r coordinates (`rra` and `rdec`) are
available for all the sources and we used them.  We then divided the table in
one catalogue per HELP field.

It seems that Mattia queried the StackObjectThin table that is [described
there](https://confluence.stsci.edu/display/PANSTARRS/PS1+StackObjectThin+table+fields).

## Coverage per field

|      Field       |Coverage (%)|
|------------------|-----------:|
|            COSMOS|    100.0   |
|           GAMA-15|      0.0   |
|           XMM-LSS|    100.0   |
|            Bootes|    100.0   |
|        CDFS-SWIRE|     98.4   |
|          ELAIS-N1|     99.1   |
|           GAMA-12|    100.0   |
|           GAMA-09|    100.0   |
|     Lockman-SWIRE|     95.7   |
|               EGS|     96.4   |
|          ELAIS-S1|      0.0   |
|         AKARI-NEP|    100.0   |
|          ELAIS-N2|     99.8   |
|              xFLS|    100.0   |
|Herschel-Stripe-82|     99.6   |
|               NGP|    100.0   |
|               SGP|      0.0   |
|         AKARI-SEP|      0.0   |
|         SPIRE-NEP|    100.0   |
|              SSDF|      0.0   |
|             HDF-N|    100.0   |
|              SA13|      0.0   |
|          XMM-13hr|      0.0   |
|           __ALL__|     61.5   |
