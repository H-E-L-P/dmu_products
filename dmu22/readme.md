HELP DMU22 SPIRE blind catalogues

The `blind catalogues` contain all the SPIRE sources which are directly detected in the three SPIRE maps.

The final catalogues can be found on HeDaM:

- http://hedam.lam.fr/HELP/data/dmu_products/dmu22/
- dmu22_"name field"/data/dmu22_XID+SPIRE_"name field"_BLIND_Matched_MF.fits

This dmu contains all the SPIRE blind photometry. It contains a folder for each field for which we have blind photometry.
The blind sources are selected my finding peaks in the Matched Filtered (MF) maps (Chapin et al 2011, dmu19). We only save peaks above the 85 per cent completness level at every SPIRE wavelength indiuavidualy. This level for every field can be found in dmu22_"name field"/"name field"_SPIRE_lim.pdf. And the central pixel flux density, ra and dec of those peaks can be found in: dmu22_"name field"/data/"name field"_SPIRE"XXX"_cat.fits, with XXX 250, 350 or 500 for the three SPIRE bands.  The script to create these first step catalogues is: make_first_cat.py

The second step is to calculate the Pearson correlation coefficient on sub-pixel positions around the original detection. We calculate the correlation coefficient using all three SPIRE bands. We substract the flux denity on the location with the highest correlation coefficient using inverse variance weighting. The catalogues can be found at: dmu22_"name field"/"name field"_SPIRE"XXX"_MF_cat.fits, and we combine the three SPIRE catalogues by removing duplicates at 350um and 500um by using a 12 arcsec and 18 arcsec radius. The final MF catalogues are located at: dmu22_"name field"/data/"name field"_SPIRE_all.fits. The script to create these second step catalogues is: make_second_cat.py

The RA and Dec of the blindly deteced sources are used as an input for XID+ (Hurley et al. 2017). The output from XID+ is located at: dmu22_"name field"/dmu22_XID+SPIRE_"name field"-BLIND.fits. We merge the MF and XID+ catalogues using the dmu22_"name field"/data/XID+BLIND_"name field"_final_processing.ipynb notebook. This notebook adds a flag for sources which have >0.5 in the P-value map and a low SPIRE flux. It also adds the field name to the catalogues and show validation plots. Note that the MF cahthalogues use the nebulized filterd maps, and XID+ use the standard maps as it simultaneously fits for the background. The P-value maps are located at: dmu22_"name field"/data/dmu22_XID+SPIRE_psw_"name field"_Bayes_Pval.fits

The final merged catalogues that we recommend for usage is: dmu22_"name field"/data/dmu22_XID+SPIRE_"name field"_BLIND_Matched_MF.fits

* HELP_ID                    	-  ID
* RA                   			degrees  Right Ascension (J2000)
* Dec                  			degrees  Declination (J2000)
* F_SPIRE_250              		mJy  Flux density at 250 µm (Median)
* FErr_SPIRE_250_u         		mJy  Flux density at 250 µm (84th Percentile)
* FErr_SPIRE_250_l         		mJy  Flux density at 250 µm (16th Percentile)
* F_SPIRE_350              		mJy  Flux density at 350 µm (Median)
* FErr_SPIRE_350_u         		mJy  Flux density at 350 µm (84th Percentile)
* FErr_SPIRE_350_l         		mJy  Flux density at 350 µm (16th Percentile)
* F_SPIRE_500              		mJy  Flux density at 500 µm (Median)
* FErr_SPIRE_500_u         		mJy  Flux density at 500 µm (84th Percentile)
* FErr_SPIRE_500_l         		mJy  Flux density at 500 µm (16th Percentile)
* Bkg_SPIRE_250       			mJy/Beam  Fitted Background of 250 µm map (Median)
* Bkg_SPIRE_350       			mJy/Beam  Fitted Background of 350 µm map (Median)
* Bkg_SPIRE_500       			mJy/Beam  Fitted Background of 500 µm map (Median)
* Sig_conf_SPIRE_250  			mJy/Beam  Fitted residual noise component due to confusion (Median)
* Sig_conf_SPIRE_350  			mJy/Beam  Fitted residual noise component due to confusion (Median)
* Sig_conf_SPIRE_500  			mJy/Beam  Fitted residual noise component due to confusion (Median)
* Rhat_SPIRE_250             	-  Convergence Statistic (ideally <1.2)
* Rhat_SPIRE_350             	-  Convergence Statistic (ideally <1.2)
* Rhat_SPIRE_500             	-  Convergence Statistic (ideally <1.2)
* n_eff_SPIRE_250            	-  Number of effective samples (ideally >40)
* n_eff_SPIRE_350            	-  Number of effective samples (ideally >40)
* n_eff_SPIRE_500            	-  Number of effective samples (ideally >40)
* Pval_res_250		     		-	Local Goodness of fit measure: 0=good, 1=bad
* Pval_res_350		     		-	Local Goodness of fit measure: 0=good, 1=bad
* Pval_res_500		     		-	Local Goodness of fit measure: 0=good, 1=bad
* flag_spire_250         		-  combined flag, 0=good, 1=bad
* flag_spire_350         		-  combined flag, 0=good, 1=bad
* flag_spire_500         		-  combined flag, 0=good, 1=bad
* F_BLIND_MF_SPIRE_250 			mJy	 Flux density at 250 µm, using the MF	
* FErr_BLIND_MF_SPIRE_250		mJy  Flux Error at 250 µm, using the MF	
* F_BLIND_MF_SPIRE_350  		mJy  Flux density at 350 µm, using the MF	
* FErr_BLIND_MF_SPIRE_350 		mJy  Flux Error at 350 µm, using the MF	
* F_BLIND_MF_SPIRE_500 			mJy  Flux density at 500 µm, using the MF	
* FErr_BLIND_MF_SPIRE_500 		mJy  Flux Error at 500 µm, using the MF	
* r 							-  Pearson correlation coefficient
* P 							-  Completness level, all are above 85 per cent
* RA_pix 						degrees  Right Ascension (J2000) of original detection pixel
* Dec_pix 						degrees  Declination (J2000) of original detection pixel
* F_BLIND_pix_SPIRE 			mJy  Flux density of original detection pixel (see flag)
* FErr_BLIND_pix_SPIRE 			mJy  Flux Error of original detection pixel (see flag)
* flag 							- 0=F_BLIND_pix_SPIRE is at 250um, 1=at 350um, 2 at 500um
* field 						- Name of the HELP-field