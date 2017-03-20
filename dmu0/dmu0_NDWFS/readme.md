NOAO Deep Wide-field Survey catalogue
=====================================

This product contains the optical to near-infrared catalogue of the National
Optical Astronomy Observatory (NOAO) Deep Wide-Field Survey (NDWFS).

The full documentation as available at http://r2.sdm.noao.edu/ndwfs/

The magnitudes are Vega magnitudes and are not aperture corrected.

There are two versions:

- `NDWFS_20160708.fits` is the main catalogue (note that a small part of the
  sources falls outside of HELP coverage). We added an internal_id column to
  uniquely identify each sources (NDWFS_name is not unique), please use this
  identifier when cross-matching.

- `NDWFS_MLselected_20160801.fits` is the masterlist selected version of the
  catalogue. It has been cleaned from duplicates and limited to the HELP field.
  The help_id column makes the link with the HELP masterlist. Please use this
  identifier while crossmatching.

# Filters

- R: http://www.noao.edu/kpno/mosaic/filters/k1004.html
- I: http://www.noao.edu/kpno/mosaic/filters/k1005.html
- Bw: http://www.noao.edu/kpno/mosaic/filters/k1025.html
  (transmission here : http://www.noao.edu/noao/noaodeep/BWfilter.dat)
- Ks: http://www.noao.edu/kpno/manuals/onis/ksfilt.txt
