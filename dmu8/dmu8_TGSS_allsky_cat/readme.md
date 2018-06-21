# TGSS-ADR1 All-sky 7-sigma catalogue
This catalogue contains all sources detected in the TIFR GMRT Sky Survey Alternate Data Release 1 (Intema et al. 2017; Homepage: http://tgssadr.strw.leidenuniv.nl/doku.php). The data release covers all of the radio sky at 150 MHz above a declination of -53 DEC (3.6π sr, or 90 percent of the full sky) at a resolution of 25“ x 25” north of 19° DEC and 25“ x 25” / cos(DEC-19°) south of 19°, and a median noise of 3.5 mJy/beam.

The catalogue has been generated using standard PyBDSF parameters. The following text describes the various columns in the catalogue:

1. `Source_id` - Radio source ID
2. `RA` - Radio RA (J2000)
3. `E_RA` - Error on radio RA
4. `DEC` - Radio declination (J2000)
5. `E_DEC` - Error on radio declination
6. `Total_flux` - Total flux in Jy
7. `E_Total_flux`
8. `Peak_flux` - Peak flux in Jy
9. `E_Peak_flux`
10. `Maj` - Major axis of the source in degrees
11. `E_Maj`
12. `Min` - Minor axis of the source in degrees
13. `E_Min`
14. `PA` - Position angle of the source
15. `E_PA`
16. `Source_code` - Source morphology; S: single component, M: multiple components
17. `Mosaic_name` - Relevant image mosaic where the source was detected
