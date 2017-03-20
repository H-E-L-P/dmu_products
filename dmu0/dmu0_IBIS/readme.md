Infrared Bootes Imaging Survey catalogue
========================================

The Infrared Bootes Imaging Survey (IBIS) is a near-infrared imaging survey
covering the entire Spitzer Deep Wide-Field Survey (SDWFS) region, which
corresponds to the Boötes field of the NOAO Deep Wide-Field Survey region. The
full documentation is available at
http://r2.sdm.noao.edu/nsa/NEWFIRM_NDWFS.html.

The IBIS provide J, H, and Ks catalogues for J selected sources over 52
overlapping subfields. The typical field reaches a 5σ depth of roughly J=22
within a 3 arc-second diameter aperture.

Magnitudes are Vega and not aperture corrected. To obtain true Vega magnitudes
with m=0 for Vega in all bands requires subtraction of 0.056 mag in J and 0.007
mag in H (Ks is unchanged).

# Catalogue concatenation

We concatenated the 3x52 catalogues in the single table. On each subfield, the
three per-band catalogues are made of the same (J selected) sources. We
concatenated them prefixing the columns with j_, h_, and k_; with these
exceptions:

- The position (alpha_j2000 and delta_j2000) comes from the J band, thus there
  is only two columns not prefixed.

- Some other columns are the same for each band and must come from the
  J processing. We kept the j_ prefix but we did not include the columns from
  the H and Ks catalogues: j_x_image, j_y_image, j_imaflags_iso,
  j_nimaflags_iso, j_threshold, j_x2_image, j_y2_image, j_xy_image, j_x2_world,
  j_y2_world, j_xy_world, j_cxx_image, j_cyy_image, j_cxy_image, j_cxx_world,
  j_cyy_world, j_cxy_world, j_errcxx_image, j_errcyy_image, j_errcxy_image,
  j_errcxx_world, j_errcyy_world, j_errcxy_world, j_a_world, j_b_world,
  j_erra_world, j_errb_world, j_theta_world, j_theta_j2000, j_errtheta_world,
  j_errtheta_j2000, j_elongation, j_ellipticity.

As we concatenated vertically the catalogues, there are duplicated sources in
the overlapping areas between field. We added a subfield column containing the
name of the subfield associated to each source. As we kept the number column (a
sequential identifier in each subfield) it's easy to go back to the original
catalogue.

To uniquely identify each source, we added an internal_id column (made
concatenating subfield and number).

# Files

There are two versions of the catalogue:

- `IBIS_20160720.fits` is the main catalogue.

- `IBIS_MLselected_20160801.fits` is the masterlist selected version of the
  catalogue. It has been cleaned from duplicates and limited to the HELP field.
  The help_id column makes the link with the HELP masterlist. Please use this
  identifier while crossmatching.

