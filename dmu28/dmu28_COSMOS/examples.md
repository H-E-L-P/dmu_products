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


<p>HELP_J095747.72+021353.48: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095747.72%2B021353.48_z%3D0.7_without_AGN_component.ipynb">redshift=0.7, without AGN component</a>.</p>
<p>HELP_J095814.87+024145.31: <a href="https://github.com/H-E-L-P/dmu_products/blob/master/dmu28/dmu28_COSMOS/SEDs_HELP_J095814.87%2B024145.31_z%3D1.8_with_AGN_component.ipynb">redshift=1.8, with AGN component</a>.</p>
