# Lockman Hole Project 1.4GHz catalogue

This product contains the 1.4-GHz Lockman Hole Project
catalogue of Prandoni et al. 2017, which is fully described in
the paper. 

The Lockman Hole Project is aimed at improving the extensive multi-band coverage available in the Lockman Hole region, through novel deep, wide-area, multi-frequency (60, 150, 350 MHz and 1.4 GHz) radio surveys. This multi-frequency, multi-band information will be exploited to get a comprehensive view of star formation and AGN activities  in  the  high  redshift  Universe  from  a  radio  perspective. 1.4GHz observations are obtained with the Westerbork Synthesis Radio Telescope(WSRT). This is he largest microJy surveys available so far, covering an area of 6.6 sq deg, down to a rms noise of 11Jy/b. This catalogue contains(6000+ sources with flux densities >55Jy).

This is available as: dmu13-lockman-hole-1.4-ghz-cat.fits

## Catalogue columns.

The 16 columns of the catalogue are as follows: 

1. `ID` - Source unique ID number
2. `CAT_FLAG` - Catalogue flag (S=Single-component source; A,B,C,..= indicate a specific component of a multi-component source; T=global parameters of multi-component source)
3. `NAME` - Source name
4. `RA` - Right ascension (J2000) of the radio source.
5. `DEC` - Declination (J2000) of the radio source.
6. `PEAK_FLUX` - Peak flux density of source (mJy)
7. `INT_FLUX` - Integrated flux density of source (mJy). 
8. `FIT_MAJ`- Fitted source Major axis (arcsec).
9. `FIT_MIN` - Fitted source Minor axis (arcsec).
10. `FIT_PA` - Position Angle (degrees)
11. `DECON_MAJ` - Deconvolved source major axis (arcsec)(0s when deconvolution not possible, point source).
12. `DECON_MIN` - Deconvolved source minor axes (arcsec)(0s when deconvolution not possible, point source).
13. `DECON_PA` - Deconvolved PA (degrees) (0s when deconvolution not possible, point source).
14. `RMS` - local rms noise value (mJy).
15. `FIT_FLAG` - fitting flag (G=Gaussian fitting ok,  E=non-Gaussian source; M=multiple-source global parameters).
16. `MOR_FLAG` - morphology flag (*= poor determination of integrated flux; c=complex source, morphology shows deviations from Gaussianity;
m=multiple source, morphology shows indications this may be a multi-component source; n=most probably spurious source due to noise artefact).
