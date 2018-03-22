# LOFAR Lockman Hole catalogue at 150 MHz

This product contains the radio catalogue generated in the Lockman Hole field using PyBDSF. The data reduction and analysis steps can be found in Mahony et al. 2016 (http://adsabs.harvard.edu/abs/2016MNRAS.463.2997M).

The following text describes the various columns in the catalogue:

1. `Source_id` - Radio source ID
2. `Isl_id` - Island ID assigned by the source extraction software PyBDSM
3. `RA` - Radio RA (J2000)
4. `E_RA` - Error on radio RA
5. `DEC` - Radio declination (J2000)
6. `E_DEC` - Error on radio declination
7. `Total_flux` - Total flux in Jy
8. `E_Total_flux`
9. `Peak_flux` - Peak flux in Jy
10. `E_Peak_flux`
11. `Maj` - Major axis of the source in degrees
12. `E_Maj`
13. `Min` - Minor axis of the source in degrees
14. `E_Min`
15. `PA` - Position angle of the source
16. `E_PA`
17. `Isl_Total_flux` - Total flux inside the island fitted by PyBDSM in Jy
18. `E_Isl_Total_flux`
19. `Isl_rms` - RMS value within the fitted island in Jy
20. `Isl_mean` - Mean flux within the island (values have been defaulted to 0)
21. `S_code` - Source morphology; S: single component, M: multiple components
