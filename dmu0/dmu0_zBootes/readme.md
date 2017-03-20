z-band observations of the NOAO Deep Wide-Field Survey Boötes field
===================================================================

This product contains the zBootes catalogue: z-band observations of the NOAO
Deep Wide-Field Survey Boötes field.

These data were released and described in Cool, 2007 (ApJS, 169, 21). That paper
should be used as a reference for using any of the data products as several key
properties of the images and catalogues are described in that document.

The original web site is http://r2.sdm.noao.edu/nsa/zbootes.html

There are two versions:

- `zBootes_20160711.fits` is the main catalogue. We added an internal_id column
  to uniquely identify each sources, please use this identifier when
  cross-matching. Note that some columns of the catalogue are not described in
  the documentation. We used the Sextractor documentation but some units may not
  be accurate.

- `zBootes_MLselected_20160711.fits` is the masterlist selected version of the
  catalogue. It has been cleaned from duplicates and limited to the HELP field.
  The help_id column makes the link with the HELP masterlist. Please use this
  identifier while crossmatching.

