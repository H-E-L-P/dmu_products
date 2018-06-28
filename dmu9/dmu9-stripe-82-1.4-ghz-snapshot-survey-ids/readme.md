# Stripe 82 1.4 GHz VLA Snapshot Survey Radio Source Component Catalogue.

This product contains the radio source component sample from Heywood et al. 2016. (http://adsabs.harvard.edu/abs/2016MNRAS.460.4433H)

The Very Large Array has been used to image ~100 deg2 of SDSS Stripe 82 at 1-2 GHz. The survey consists of 1026 snapshot observations
of 2.5 min duration, using the hybrid CnB configuration. The catalogue
produced using PyBDSF for this survey contains 11 782 point and Gaussian components.

The catalogue of optical counterparts of this survey can be found in dmu13 and described in Prescott et al. 2018. (https://arxiv.org/abs/1806.10140)

The catalogue will be available on dropbox. 

## Catalogue columns. 

The 21 columns in this catalogue are as follows: 

1. `ID` - Unique ID of radio source component 
2. `RA`- Right ascension of radio source component (J2000, degrees)
3. `DEC` - Declination of radio source component (J2000, degrees)
4. `RAERR` - Error on the right ascension (degrees)
5. `DECERR` - Error on the declination (degrees)
6. `INTFLUX`- Integrated flux of radio source component (mJy)
7. `INTFLUXERR`- 1 sigma error on intregated flux of radio source component (mJy)
8. `PEAKFLUX`- Peak flux of radio source component (mJy per beam)
9. `PEAKFLUXERR`- 1 sigma error on peak flux of radio source component (mJy per beam)
10. `LOCALRMS`- Local RMS noise (microJy per beam)
11. `SPECINDEX`-Spectral index of the radio component
12. `MAJAXIS`- Major axis size of a Gaussian fitted to the source component (arcseconds)
13. `MAJAXISERR` - 1 sigma error on the major axis size (arcseconds)
14. `MINAXIS`- Minor axis size of a Gaussian fitted to the source component (arcseconds)
15. `MINAXISERR`- 1 sigma error on the minor axis size (arcseconds)
16. `PA` - Position angle of the Gaussian fitted to the component (degrees)
17. `PAERR`- Position angle error (degrees)
18. `RESFLAG`- Boolean flag indicating whether or not the component is resolved.
19. `GCID`- Zero indexed unique identifier of the radio source component.
20  `SOURCEID` - Zero  indexed unique identifier of the radio source.
21. `ISLANDID`- Zero indexed unique identifier of the island.
