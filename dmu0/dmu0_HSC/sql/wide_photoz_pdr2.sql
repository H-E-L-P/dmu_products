-- Queries for files /dmu_products/dmu0/dmu0_HSC/data/HSC-PDR2_wide_W0$field.csv.gz
-- Get everything from wide with a photoz
-- This is a query for the SGLF for field W01
-- They are named W01 - W07.
--   W01 = WIDE01H
--   W02 = XMM
--   W03 = GAMA09H
--   W04 = WIDE12H+GAMA15H
--   W05 = VVDS
--   W06 = HECTOMAP
--   W07 = AEGIS
SELECT 
    object_id, 
    ra, 
    dec,
    g_cmodel_mag,
    g_cmodel_magsigma,
    r_cmodel_mag,
    r_cmodel_magsigma,
    i_cmodel_mag,
    i_cmodel_magsigma,
    z_cmodel_mag,
    z_cmodel_magsigma,
    y_cmodel_mag,
    y_cmodel_magsigma,
    photoz_best,
    photoz_std_best,
    stellar_mass,
    stellar_mass_err68_min,
    stellar_mass_err68_max,
    sfr,
    sfr_err68_min,
    sfr_err68_max
    FROM 
        pdr2_wide.forced
        JOIN pdr2_wide.photoz_mizuki USING (object_id)
    WHERE 
        pdr2_wide.search_W01(object_id)
        AND isprimary
;