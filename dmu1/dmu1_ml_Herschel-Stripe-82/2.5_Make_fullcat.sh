ls ./data/tiles/sub_catalogue_herschel-stripe-82_20190205*.fits > ./data/tiles/fits_list_20190205.lis

stilts tcat in=@./data/tiles/fits_list_20190205.lis out=./data/master_catalogue_herschel-stripe-82_20190205.fits

stilts tpipe cmd='keepcols "ra dec ferr_ap_suprime_g f_ap_suprime_g ferr_suprime_g f_suprime_g ferr_ap_suprime_r f_ap_suprime_r ferr_suprime_r f_suprime_r ferr_ap_suprime_i f_ap_suprime_i ferr_suprime_i f_suprime_i ferr_ap_suprime_z f_ap_suprime_z ferr_suprime_z f_suprime_z ferr_ap_suprime_y f_ap_suprime_y ferr_suprime_y f_suprime_y ferr_ap_suprime_n921 f_ap_suprime_n921 ferr_suprime_n921 f_suprime_n921 ferr_ap_suprime_n816 f_ap_suprime_n816 ferr_suprime_n816 f_suprime_n816 ferr_ap_vista_y f_ap_vista_y ferr_vista_y f_vista_y ferr_ap_vista_h f_ap_vista_h ferr_vista_h f_vista_h ferr_ap_wircam_j f_ap_wircam_j ferr_wircam_j f_wircam_j ferr_ap_vista_j f_ap_vista_j ferr_vista_j f_vista_j ferr_ap_wircam_ks f_ap_wircam_ks ferr_wircam_ks f_wircam_ks ferr_ap_vista_ks f_ap_vista_ks ferr_vista_ks f_vista_ks ferr_ukidss_y f_ukidss_y ferr_ap_ukidss_y f_ap_ukidss_y ferr_ukidss_j f_ukidss_j ferr_ap_ukidss_j f_ap_ukidss_j ferr_ap_ukidss_h f_ap_ukidss_h ferr_ukidss_h f_ukidss_h ferr_ap_ukidss_k f_ap_ukidss_k ferr_ukidss_k f_ukidss_k ferr_ap_gpc1_g f_ap_gpc1_g ferr_gpc1_g f_gpc1_g ferr_ap_gpc1_r f_ap_gpc1_r ferr_gpc1_r f_gpc1_r ferr_ap_gpc1_i f_ap_gpc1_i ferr_gpc1_i f_gpc1_i ferr_ap_gpc1_z f_ap_gpc1_z ferr_gpc1_z f_gpc1_z ferr_ap_gpc1_y f_ap_gpc1_y ferr_gpc1_y f_gpc1_y ferr_ap_irac_i1 f_ap_irac_i1 ferr_irac_i1 f_irac_i1 ferr_ap_irac_i2 f_ap_irac_i2 ferr_irac_i2 f_irac_i2 ferr_ap_decam_i f_ap_decam_i ferr_decam_i f_decam_i ferr_ap_decam_y f_ap_decam_y ferr_decam_y f_decam_y ferr_ap_decam_g f_ap_decam_g ferr_decam_g f_decam_g ferr_ap_decam_r f_ap_decam_r ferr_decam_r f_decam_r ferr_ap_decam_z f_ap_decam_z ferr_decam_z f_decam_z ferr_megacam_g f_megacam_g ferr_megacam_r f_megacam_r ferr_megacam_i f_megacam_i ferr_megacam_z f_megacam_z ferr_megacam_y f_megacam_y ferr_sdss_u f_sdss_u ferr_sdss_g f_sdss_g ferr_sdss_r f_sdss_r ferr_sdss_i f_sdss_i ferr_sdss_z f_sdss_z ferr_ap_sdss_u f_ap_sdss_u ferr_ap_sdss_g f_ap_sdss_g ferr_ap_sdss_r f_ap_sdss_r ferr_ap_sdss_i f_ap_sdss_i ferr_ap_sdss_z f_ap_sdss_z"' ./data/master_catalogue_herschel-stripe-82_20190205.fits omode=out out=./data/master_catalogue_herschel-stripe-82_20190205_for_depths.fits
