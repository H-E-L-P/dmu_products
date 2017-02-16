# SpARCS data

This product contains the catalogue from the *Spitzer Adaptation of the
Red-sequence Cluster Survey* (SpARCS).  The indivudal catalogues where
downloaded from https://astro.uni-bonn.de/~tudorica/webpages/SpARCS/ and
processed with Mattia prescriptions:

- the catalogues from each field where joined together;
- the resulting catalogue was sorted by ``NBPZ_FILT`` (descending);
- the catalogue was crossmatched against itself within 1 arc-second keeping only
  one row in each group (the one with highest ``NBPZ_FILT``).

The file ``work-spacs-ugryz-bonn.src`` execute this prescription.

After this, we gathered all the catalogue in a single table (compared to other
fields, only XMM has columns for the y band, it's content is empty for the other
fields).  We processed the resulting table with our script to limit to HELP
coverage and add a ``field`` column.  Then we remove the ``ID`` column and
replaced it with an ``internal_id`` one containing an incrementing index after
having ordered the row by ``ALPHA_J2000`` and ``DELTA_J2000``.  Then we produced
one catalogue per field.

We contacted Hendrik Hildebrandt and Alexandru Tudorica to have more
informations. The magnitude/flux to use are those labelled with the band that
were extracted on the PDF-homogenised maps. The first flux / magnitudes without
a band in the name are the r values computed on the non-convolved images (the
catalogue seems to be r selected).
