To make a test of our approach we used the best sample selected from COSMOS field  for which PACS  and SPIRE fluxes are available (marked with a good flag). We selected 1012 galaxies. We used photometric redshifts provided by HELP team. 
The measurements in the HELP-COSMOS catalog are not k-corrected but as the mean Galactic extinction  at the object position  is very low (mean value equal to 0.019$\pm$0.001, and median: 0.019) we used not corrected fluxes.

Our catalog contains the following bands:  FUV, NUV, CFHT u, SUBARU B,  SUBARU V, SUBARU r, SUBARU i, SUBARU z, yHSC, UKIRT WFCJ, CFHT H, CFHT wircam Ks, IRAC1, IRAC2, IRAC3, IRAC4, MIPS1, PACS green, PACS red,  PSW,  PMW and PLW.  We removed double bands (WFCAM Ks, WIRCAM Y, WFCAM H, z$++$), and narrow bands (IA484 SCam, IA527 SCam, IA624 SCam, IA679 SCam, IA738 SCam, IA773 SCam, IA427 SCam, IA464 SCam, IA505 SCam, IA574 SCam, IA709 SCam, IA827 SCam, NB717 and NB816) as it gave us very dense coverage of the optical passbands in comparison with the infrared part of the spectra. To pick one filter over two similar ones, we decided to check the number of measurements in the full catalog of 694478 HELP-COSMOS galaxies, the depth of which filter and the distribution of uncertainties. 


In order to	define the best modules to be used	within HELP we have run CIGALE with different modules and parameters:

* <strong>Star Formation History</strong>: delayed star formation history with an additional, almost flat, burst,
  * $\tau$ e-folding time of the main stellar population model [Myr] :  3000
  *	e-folding time of the late starburst population model [Myr] : 10 000
  * mass fract. of the late burst population : 0.001, 0.010, 0.030, 0.100, 0.200, 0.300
  * age [Myr] :   11000, 2500,  4500, 6000, 7500, 10000
  * age of the late burst [Myr] :   10.0,  30, 60 , 90, 1  
* <strong>Single Stellar Population</strong>: Bruzual & Charlot 2003
  * initial mass function : Chabrier 2003
  * metallicities (solar metallicity) : 0.2 
  * age of the separation between the young and the old star population [Myr] : 10 
* <strong>Dust attenuation</strong>: Charlot & Fall 2000,
  * V-band attenuation in the birth clouds (Av BC) : 0.3, 0.8,1.2,1.7,2.3,2.8,3.3, 3.8
  * power law slope of the attenuation in the birth clouds : -0.7 
  * BC to ISM factor :  0.3, 0.5, 0.8, 1.0 
  * power law slope of the attenuation in the ISM : -0.7 
* <strong>Dust emission</strong>:  Drain & Li 2007
  * mass fraction of PAH :  0.47, 1.12, 2.5, 3.9
  * minimum radiation field (umin) : 5.0, 10.0, 25.0
  * power law slope dU/dM  ($U^{\alpha}$) : 2.0
  * fraction illuminated from Umin to Umax ($\gamma$) : 0.02
* <strong>AGN emission</strong>: Fritz 2006 (for our analysis we used templates built based on average parameters from previous studies: Hatziminaoglou+09,Buat+15,Ciesla+15,Malek+2017)
  * ratio of the maximum to minimum radius of the dust torus : 60 
  * optical depth at 9.7 microns : 1.0, 6.0
  * radial dust distribution in the torus : -0.5 
  * angular dust distribution in the torus : 0.0 
  * angular opening angle of the torus [deg] : 100.0 
  * angle between equatorial axis and the line of sight [deg] : 0.001  
  * fractional contribution of AGN: 0.0, 0.1, 0.25
  
We decided to run CIGALE with AGN module for all galaxies as it is almost impossible to find a sufficient criterion which includes errors. We build our conclusion based on the tests with four AGN selection criteria: Stern+2005,Donley+2012, Lacy+2007, and Lacy+2013. We have found that usage of different criteria results in large discrepancy between sample of AGN candidates. 

The quality of the fitted SEDs is calculated making use of the $\chi^2$ value of the best model, marginalized over all parameters except the one assigned for the further physical analysis. The final output values of analyzed parameters are calculated as the mean  and standard deviation determined from the PDFs. 

Firstly CIGALE search for the best parameters for each modules from the given ones. At the end, based on the PDF analysis, final quanitities are computed.

Below we have attached a few examples how the best model for different galaxies is computed, and where analized galaxy is located in the global redshift -- stellar mass, redshift -- dust luminosity, and redshift -- star formation rate relations. 

* redshift ~ 0.2
  * <p>HELP_J095753.05+014429.01: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095753.05%2B014429.01.ipynb">z=0.20, log(Ldust)= 10.94, log(Mstar)=11.05, AGN component = 0.0</a>.</p>
  * <p>HELP_J100135.92+024116.75: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J100135.92%2B024116.75.ipynb">z=0.20, log(Ldust)= 10.70, log(Mstar)=10.73, AGN component = 0.28</a>.</p>

* redshift ~ 0.6
  * <p>HELP_J095852.73+020248.24: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095852.73%2B020248.24.ipynb">z=0.60, log(Ldust)= 11.38, log(Mstar)=10.88, AGN component = 0.0</a>.</p>
  * <p>HELP_J095937.48+015501.93: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095937.48%2B015501.93.ipynb">z=0.61, log(Ldust)= 11.22, log(Mstar)=10.61, AGN component = 0.40</a>.</p>

* redshift ~ 1.5 
  * <p>HELP_J095741.77+022142.41: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095741.77%2B022142.41.ipynb">z=1.47, log(Ldust)= 12.31, log(Mstar)=11.41, AGN component = 0.0</a>.</p>
  * <p>HELP_J095741.11+020226.47: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095741.11%2B020226.47.ipynb">z=1.49, log(Ldust)= 12.33, log(Mstar)=10.95, AGN component = 0.32</a>.</p>


