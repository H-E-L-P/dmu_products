To make a test of our approach we used the best sample selected from COSMOS field  for which PACS  and SPIRE fluxes are available (marked with a good flag). We selected 1012 galaxies. We used photometric redshifts provided by HELP team. 
The measurements in the HELP-COSMOS catalog are not k-corrected but as the mean Galactic extinction  at the object position  is very low (mean value equal to 0.019$\pm$0.001, and median: 0.019) we used not corrected fluxes.

Our catalog contains the following bands:  FUV, NUV, CFHT u, SUBARU B,  SUBARU V, SUBARU r, SUBARU i, SUBARU z, yHSC, UKIRT WFCJ, CFHT H, CFHT wircam Ks, IRAC1, IRAC2, IRAC3, IRAC4, MIPS1, PACS green, PACS red,  PSW,  PMW and PLW.  We removed double bands (WFCAM Ks, WIRCAM Y, WFCAM H, z$++$), and narrow bands (IA484 SCam, IA527 SCam, IA624 SCam, IA679 SCam, IA738 SCam, IA773 SCam, IA427 SCam, IA464 SCam, IA505 SCam, IA574 SCam, IA709 SCam, IA827 SCam, NB717 and NB816) as it gave us very dense coverage of the optical passbands in comparison with the infrared part of the spectra. To pick one filter over two similar ones, we decided to check the number of measurements in the full catalog of 694478 HELP-COSMOS galaxies, the depth of which filter and the distribution of uncertainties. 


In order to	define the best modules to be used	within HELP we have run CIGALE with different modules and parameters:

* <strong>Star Formation History</strong>: delayed star formation history with an additional, almost flat, burst,
  * $\tau$ e-folding time of the main stellar population model [Myr] :  3000
  *	e-folding time of the late starburst population model [Myr] : 10 000
  * mass fract. of the late burst population : 0.0, 0.005, 0.01, 0.05, 0.1, 0.15,  0.20, 0.3
  * age [Myr] :   1000, 2000, 3000, 3500, 4000, 5000, 6500, 10000
  * age of the late burst [Myr] :  10.0, 30.0, 50., 70.
* <strong>Single Stellar Population</strong>: Bruzual & Charlot 2003
  * initial mass function : Chabrier 2003
  * metallicities (solar metallicity) : 0.2 
  * age of the separation between the young and the old star population [Myr] : 10 
* <strong>Dust attenuation</strong>: Charlot & Fall 2000,
  * V-band attenuation in the birth clouds (Av BC) : 0.12,0.25, 0.5, 0.8,1.2,1.7,2.3,2.8,3.3, 3.8, 4.0   
  * power law slope of the attenuation in the birth clouds : -0.7 
  * BC to ISM factor : 0.44 
  * power law slope of the attenuation in the ISM : -0.7 
* <strong>Dust emission</strong>:  Drain & Li 2007
  * mass fraction of PAH :  0.47, 1.12, 2.5, 3.9
  * minimum radiation field (umin) : 5.0, 10.0, 25.0
  * power law slope dU/dM  ($U^{\alpha}$) : 2.0, 2.8
  * fraction illuminated from Umin to Umax ($\gamma$) : 0.005, 0.02, 0.05
* <strong>AGN emission</strong>: Fritz 2006 
  * ratio of the maximum to minimum radius of the dust torus : 60 
  * optical depth at 9.7 microns : 1.0, 6.0
  * radial dust distribution in the torus : -0.5 
  * angular dust distribution in the torus : 0.0 
  * angular opening angle of the torus [deg] : 100.0 
  * angle between equatorial axis and the line of sight [deg] : 0.001  
  * fractional contribution of AGN: 0.0, 0.1, 0.15, 0.25, 0.4

The quality of the fitted SEDs is calculated making use of the $\chi^2$ value of the best model, marginalized over all parameters except the one assigned for the further physical analysis. The final output values of analyzed parameters are calculated as the mean  and standard deviation determined from the PDFs. 

Firstly CIGALE search for the best parameters for each modules from the given ones. At the end, based on the PDF analysis, final quanitities are computed.

Below we have attached a few examples how the best model for different galaxies is computed, and where analized galaxy is located in the global redshift -- stellar mass, redshift -- dust luminosity, and redshift -- star formation rate relations. 
reduced $\chi^2$ : 0.6773938902916605 
bayesian stellar mass 10.780886769559045 +/- 3.364478045074963 [M sun]:
bayesian dust luminosity: 11.232695851639296 +/- 2.843564187753497 [L sun]
bayesian SFR 16.215375774529605 +/- 2.5427437135289894 [M sun / yr]:
bayesian AGN fraction 1.3516930515065185e-05 +/- 0.001164416553238685:



<p>HELP_J095747.72+021353.48: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095747.72%2B021353.48.ipynb">z=0.7, log(Ldust)= 11.23, log(Mstar)=10.78, AGN component = 0</a>.</p>
<p>HELP_J095814.87+024145.31: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095814.87%2B024145.31.ipynb">z=1.8, log(Ldust)=12.62, log(Mstar)=11.46, AGN component = 0.25</a>.</p>
<p>HELP_J095747.72+021353.48: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095759.54%2B023009.11.ipynb">z=1.2, log(Ldust)= 11.79, log(Mstar)=10.58, AGN component = 0</a>.</p>
