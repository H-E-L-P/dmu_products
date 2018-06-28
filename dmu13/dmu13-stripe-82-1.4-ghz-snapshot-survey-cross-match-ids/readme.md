# Stripe 82 1.4 GHz VLA Snapshot Survey Cross Matches.

This product contains the cross-matched sample of radio/optical counterparts of Prescott et al. 2018 (Resubmitted to MNRAS) which can be found on astroph here: http://adsabs.harvard.edu/abs/2018arXiv180610140P 

Here we have combined spectrosopic and photometric data from the Sloan Digital Sky Survey (SDSS) with 1.4 GHz radio observations, conducted
as part of the Stripe 82 1-2 GHz Snapshot Survey using the Karl G. Jansky Very Large Array (VLA), which covers ~100 sq degrees, to a flux limit of 88 microJy rms. Cross-matching the 11768 radio source components with optical data via visual inspection results in a final sample of 4795 cross-matched
objects, of which 1996 have spectroscopic redshifts and 2799 objects have photometric redshifts.
The photometric redshifts are taken from Reis et al. 2012. The catalogue contains a mixture of radio-loud AGN, star-forming galaxies and QSOs.

The catalogue will be available on dropbox. 

## Catalogue columns. 

The 32 columns in this catalogue are as follows: 

1. `CATID` -  Source unique ID number 
2. `RADIOID`  -  RADIO ID of brightest radio component from the H16 catalogue.  
3. `RADIORA`   -  Right ascension of the radio source (J2000)
4. `RADIODEC`  -   Declination of the radio Source (J2000)
5. `INT_FLUX`  -  Integrated flux of radio source (mJy)
6. `INT_FLUXERR` - Error on the integrated flux (mJy)
7. `PEAK_FLUX` -   Peak Flux of radio source (mJy per beam)
8. `PEAK_FLUXERR` -  Error on the peak flux (mJy per beam) 
9. `RMS` -  local noise value (microJy)
10. `N_COMP` -  Number of components that make up the radio source
11. `SDSS_OBJID` -  SDSS OBJID of optical counterpart 
12. `RA` - SDSS Right Ascention of optical counterpart (J2000)
13. `DEC` - SDSS Declination of optical counterpart (J2000)
14. `dered_u` - SDSS dereddened u-band magnitude (mags)
15. `dered_g` - SDSS dereddened g-band magnitude (mags)
16. `dered_r ` - SDSS dereddened r-band magnitude (mags)
17. `dered_i ` - SDSS dereddened i-band magnitude (mags)
18. `dered_z` - SDSS dereddened z-band magnitude (mags)
19. `err_u`  - error on SDSS u-band magnitude
20. `err_g` - error on SDSS g-band magnitude
21. `err_r ` -  error on SDSS r-band magnitude
22. `err_i ` -  error on SDSS i-band magnitude
23. `err_z` -  error on SDSS z-band magnitude
24. `SPECFLAG` - SPECFLAG = 1 For spectroscopic redshift, = 0 For Photometric redshift 
25. `Z_PHOT` -  Photometric redshift from Reis et al. 2012 
26. `Z_PHOTERR` -  Error on the photometric redshift
27. `Z_SPEC` - SDSS Spectroscopic redshift 
28. `Z_SPECERR` - SDSS Spectroscopic redshift error
29. `Z_Warning` - SDSS Z_Warning (0 = A reliable redshift)
30. `SDSS_SURVEY` - SDSS Survey 
31. `SDSS_CLASS` - SDSS CLASS either QSO or GALAXY 
32. `SDSS_TYPE` - SDSS TYPE =3 for extended object, =6 for point like object. 
