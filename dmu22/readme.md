HELP DMU22 SPIRE blind catalogues

The `blind catalogues`, containing all the SPIRE sources which are directly detected in the three SPIRE maps can be found on HeDaM:

- http://hedam.lam.fr/HELP/data/dmu_products/dmu22/
# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP Blind catalogues (dmu19)

This is a data product of the Herschel Extragalactic Legacy Project ([HELP](http://www.herschel.sussex.ac.uk))

The full files which are not stored in the Git repository can be downloaded from HeDaM:

- [http://hedam.lam.fr/HELP/data/dmu_products/](http://hedam.lam.fr/HELP/data/dmu_products/)

This DMU contains all the blind SPIRE photometry. The directory above contains folders for each field for which we have blind photometry. The blind catalogue for each field is located at places like:

- dmu22_"name field"/data/`dmu22_XID+SPIRE_"name field"_BLIND_Matched_MF.fits`

Where "name field" can be e.g. "ELAIS-N1". The blind sources are selected my finding peaks in the Matched Filtered (MF) maps (Chapin et al 2011, dmu19). We only save peaks with flux density above the 85 per cent completeness level at every SPIRE wavelength individually. The 85% completeness level in each field can be found in dmu22_"name field"/`"name field"_SPIRE_lim.pdf`. The central pixel flux density, RA and Dec for each peak can be found in: dmu22_"name field"/data/`"name field"_SPIRE"XXX"_cat.fits`, with XXX 250, 350 or 500 for the three SPIRE bands. The script used to create these first step catalogues is: `make_first_cat.py` (which can be found at http://hedam.lam.fr/HELP/data/dmu_products/dmu22/)

The second step is to determine accurate centres for each source in the blind catalogue. To do this, we calculate the Pearson correlation coefficient on sub-pixel positions around the original detection. We calculate the correlation coefficient using all three SPIRE bands, and determine the best-fit flux density for that source at the updated position using inverse variance weighting. The resulting catalogues for each SPIRE band can be found at: dmu22_"name field"/`"name field"_SPIRE"XXX"_MF_cat.fits`, and we combine the three SPIRE catalogues by removing duplicates at 350um and 500um using a nearest neighbour matching algorithm with 12 arcsec and 18 arcsec radius, respectively, adopting the position in the shortest wavelength available for each merged source (`rn_merge.ipynb`). The resulting merged MF catalogues are located at: dmu22_"name field"/data/`"name field"_SPIRE_all.fits`. The script to create these catalogues is: `make_second_cat.py` (found at the same location as above).

The RA and Dec of the blindly detected sources are used as an input for XID+ (Hurley et al. 2017,`xid_spire_prior.ipynb`). The output from XID+ is located at: dmu22_"name field"/`dmu22_XID+SPIRE_"name field"-BLIND.fits`. We merge the MF and XID+ catalogues using the dmu22_"name field"/data/`XID+BLIND_"name field"_final_processing.ipynb` notebook. This notebook adds a flag for sources which have >0.5 in the P-value map (http://herschel.sussex.ac.uk/XID_plus/build/html/notebooks/examples/XID+posterior_analysis_validation.html#Posterior-Predictive-checking-and-Bayesian-P-value-maps) and a low (less than ~6mJy) SPIRE flux. It also adds the field name to the catalogues and shows validation plots. Note that the MF catalogues use the nebulized filtered Herschel maps (http://casu.ast.cam.ac.uk/publications/nebulosity-filter), whereas XID+ uses the standard maps, since it simultaneously fits for the background alongside the individual sources. The P-value maps are located at: dmu22_"name field"/data/`dmu22_XID+SPIRE_psw_"name field"_Bayes_Pval.fits`

The final merged catalogues that we recommend for usage are those named: dmu22_"name field"/data/`dmu22_XID+SPIRE_"name field"_BLIND_Matched_MF.fits`

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
* flag 							- 0=F_BLIND_pix_SPIRE is at 250um, 1=at 350um, 2= at 500um
* field 						- Name of the HELP-field

-------------------------------------------------------------------------------

In addition to the standard blind catalogues we produced red catalogues based on the method described in Asboth et al. 2016. The red sourcefiles and notebooks can be found in: [http://hedam.lam.fr/HELP/data/dmu_products/dmu22/dmu22_red_source/](http://hedam.lam.fr/HELP/data/dmu_products/)

**Authors**: Steven Duivenvoorden

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)
