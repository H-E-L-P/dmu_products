GALEX GCAT catalogues
=====================

This resource contains the GALEX GCAT catalogues: the GALEX All-Sky Source
Catalogue (GASC) and the GALEX Medium Imaging Survey Catalogue (GMSC).

More information on the GCAT is available on `the Caltech GALEX site`__. In
particular:

__ http://www.galex.caltech.edu/wiki/GCAT_Manual

  GALEX has been undertaking a number of surveys covering large areas of sky
  at a variety of depths. However making use of this large data set can be
  difficult because the standard GALEX database contains all of the detected
  sources which include many duplicate observations of the same sources as
  well as numerous spurious low signal-to-noise sources. At the same time,
  the sky footprint associated with GALEX observations has not been well
  defined or presented in an easily useable format. In order to remedy these
  problems, we have constructed two catalogues of GALEX measurements, namely
  the GALEX All-Sky Survey Source Catalog (GASC) and the GALEX Medium
  Imaging Survey Catalog (GMSC). Our intention is that these catalogues will
  provide the primary reference catalog useful for matching GALEX
  measurements with other large surveys of the sky at other wavelengths.
  Covering a total of 26,300 deg2 of sky, the GASC consists of all GALEX
  observations with exposure times below 800 sec and reaches a depth of NUV
  21 (AB mag). The GMSC covers a smaller region of 5000 deg2 with exposure
  times between 800 and 10,000 sec and reaches a depth of NUV 23 mag.
  There are a total of 40 million unique sources in the GASC and 22
  million in the GMSC. Each catalogues accompanied by exposure time,
  coverage and flag maps in FITS and Healpix formats.

  These catalogues do not contain the deepest images available for the GALEX
  deep fields. While the sky covered by these tiles is included, we have
  limited the total exposure time to 10,000 sec. Crowding becomes
  a significant issue for the depths reached in the deep fields and thus
  requires more careful treatment than what is possible using the standard
  GALEX pipeline source detection. Users interested in these regions can
  find the deepest co-adds from the MAST archive and complete their own an
  analysis. Currently these catalogues only include GALEX data up to the GR6
  data release.

To identify uniquely a source, one must use the name column.

These catalogues were limited to HELP coverage and a ``field`` column has
been added.


HELP field coverage
-------------------

Here is the number of GMSC and GASC sources per HELP field:

==================  =============== ===============
     Field            GMSC counts     GASC counts
==================  =============== ===============
         AKARI-NEP            6,142          14,563
         AKARI-SEP           12,356           7,756
            Bootes           61,748          20,059
        CDFS-SWIRE           49,905          34,889
            COSMOS           40,403          15,662
               EGS           21,564           6,259
          ELAIS-N1           60,774          28,561
          ELAIS-N2           46,681          27,889
          ELAIS-S1           39,405          26,354
           GAMA-09          262,123         104,706
           GAMA-12          219,450          80,206
           GAMA-15          269,669          97,722
             HDF-N            3,321           1,872
Herschel-Stripe-82        1,318,546         468,385
     Lockman-SWIRE           97,661          26,865
               NGP          185,199         217,288
              SA13                              401
               SGP          265,261         464,442
         SPIRE-NEP                              346
              SSDF           94,053         227,424
              xFLS           36,163          15,790
          XMM-13hr                              166
           XMM-LSS           72,816          36,467
==================  =============== ===============


History
-------

======== =============================================================
20160426 Addition of the GASC catalogue retrieved from STSCI GALEX
         CasJobs.
20160303 Catalogue retrieved from STSCI GALEX CasJobs and ingested.
======== =============================================================

