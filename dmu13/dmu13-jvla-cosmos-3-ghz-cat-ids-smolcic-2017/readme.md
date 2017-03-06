# VLA-COSMOS 3GHz LARGE PROJECT catalogue

This product contains the VLA-COSMOS 3GHz Large multiwavelength
catalogue of Smolcic et al. 2017b (in prep), which is fully described in
the paper. 

The survey covers a 2.6 square degree area with a mean rms of ∼ 2.3
μJy/beam, cataloging sources above 5σ, and enclosing full  2.6 square
degree COSMOS field, at an angular resolution of 0.75''. The radio data is combined with optical, near infrared (UltraVISTA), and mid-infrared (Spitzer/IRAC) data, as well as X-ray data (Chandra). 
The sources are divided into star forming galaxies or AGN based on various criteria, such as X-ray luminosity, observed MIR color, UV-FIR spectral-energy distribution, rest-frame NUV-optical color corrected for dust extinction, and radio-excess relative to that expected from the hosts’ star-formation rate. 

This is availble in `dmu13-jvla-cosmos-3-ghz-cat-ids-smolcic-2017`.

## Catalogue columns.

The 26 columns of the catalogue are as follows: 

1. `ID_VLA` - Identification number of the radio source.
2. `RA_VLA_J2000` -  Right ascension (J2000) of the radio source.
3. `DEC_VLA_J2000` Declination (J2000) of the radio source.
4. `MULTIFLAG` - Identifier for a single or multi-component radio source
(MULTI=0 or 1 for the first or latter, respectively).
5. `CAT_CPT` - Identification of the counterpart catalog, either ’COSMOS2015’, ’iband’, or ’IRAC’.
6. `ID_CPT` - Identification number of the counterpart.
7. `RA_CPT_J2000` - Right ascension (J2000) of the counterpart, corrected for
small astrometry offsets as described in the Appendix of Smolcic et al. 2017b.  
8. `DEC_CPT_J2000` -Declination (J2000) of the counterpart, corrected for small astrometry offsets as described in the Appendix of Smolcic 2017 b. 
9. `SEP_VLA_CPT` - Separation between the radio source and its counterpart (arc- seconds).
10. `P_FALSE` - False match probability.
11. `Z_BEST` - Best redshift available for the source.
12. `FLUX_INT_3GHz` - Integrated 3 GHz radio flux density (μJy).
13. `Lradio_3GHz` - Rest-frame 3 GHz radio luminosity (log W Hz−1).
14. `Lradio_1.4GHz` - Rest-frame 1.4 GHz radio luminosity (log W Hz−1), obtained using the measured 1.4-3 GHz spectral index, if available, otherwise assuming a spectral index of -0.7.
15. `L_TIR_SF` - Star-formation related infrared (8-1000 μm rest-frame) luminosity derived from SED-fitting (log L⊙). If the source is classified as HLAGN, this value represents the fraction of the total infrared luminosity arising from star formation, while it corresponds to the total IR luminosity otherwise (see Delvec- chio et al., accepted).
16. `SFR_KENN98` - Star formation rate (M⊙yr−1) obtained from the total infrared luminosity listed in column (15), by assuming the Kennicutt (1998) conversion factor, and scaled to a Chabrier (2003) IMF.
17. `Xray-AGN` - “T” if true, “F” otherwise.
18. `MIR_AGN` - “T” if true, “F” otherwise.
19. `SED-AGN` - “T” if true, “F” otherwise.
20. `Quiescent_MLAGN` - “T” if true, “F” otherwise.
21. `SFG` - “T” if true, “F” otherwise.
22. `Clean_SFG` - “T” if true, “F” otherwise.
23. `HLAGN` - “T” if true, “F” otherwise.
24. `MLAGN` - “T” if true, “F” otherwise.
25. `Radio-excess` - “T” if true, “F” otherwise.
26. `flag_COSMOS2015` - masked area flag: “1” if true, “0” other-
wise.18
