Subaru/XMM-Newton Deep Survey (SXDS)
====================================

This product contains the Subaru B, V, r, i, and z catalogues from the
Subaru/XMM-Newtin Deep Survey (SXDS). There are 5 kinds of catalogues (one per
band of detection), each kind composed of 5 catalogues forming a cross with
a small overlapping area.

The catalogues are those of the DR1 ((web
page)[http://soaps.nao.ac.jp/SXDS/Public/DR1/index_dr1.html]).  They are
provided in Sextractor ASCII format.  They were converted to FITS files for easy
handling.  To convert them, the column names where slightly changed, the
`cat_headers.txt` file contains the headers for the ASCII catalogues.

We added `ra` and `dec` columns in decimal degrees.

The catalogue were not merged and should be merged in the processing of the
master list.  During the merge, a special care should be taken about the `FLAGS`
column that is 0 for clean sources, 1 for strong halo, and 2 for weak halo.

All the sources in the various catalogues fall in the HELP XMM-LSS field.
