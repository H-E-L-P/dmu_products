# AllWISE catalogue

The following is a description of the production of the version 1.x of the
catalog, that are based on the AllWise catalogs.

## Original catalog and local copy

We use a local copy of the AllWise catalog downloaded from
http://irsadist.ipac.caltech.edu/wise-allwise/ . The catalog has been indexed
locally, using a nside=256 nested healpix scheme, allowing for fast queries by
position. The indexing method is as follow: for each source position in the
original catalog, its pixel id is computed, and a copy of the original catalog
is created where all sources belonging to the same pixel id are written
continuously. The use of a nested scheme allows for sources closely in the sky
to be written in closeby positions in the file. With nside=256, the healpix size
are of the order of 0.25 sq degree.

## Catalog Query

For each field, the indexed catalog is queried in the following manner:

- The healpix pixel ids in the catalog scheme of all the non null pixels in the
  master mask file of the field are computed. The master masks were obtained
  from [SPIRE Coverage
  Maps](http://fp7census.pbworks.com/w/page/87735187/SPIRE%20Coverage%20Maps).
- The corresponding sources are extracted from the indexed catalog
- Their position in the mask is computed
- Only the sources where the mask is non null are kept.

## Catalog HELP formatting

The indexed catalog contains the columns listed in
http://wise2.ipac.caltech.edu/docs/release/allwise/expsup/sec2_1a.html

For the HELP version, the following filters are used: WISE_W1, WISE_W2, WISE_W3,
WISE_W4. In the following, the letter 'x' stands for 1, 2, 3, or 4 according to
the band.

The AllWise catalog provides a very large amount of information: there are 298
columns in the catalog, reporting various flags and types of photometry. Among
these, there is:

- wxmpro : point source profile fitting photometry
- wxflux : raw flux from profile fitting photometry
- wxmag : aperture corrected photometry from a 8.25" aperture measurement.
- wxmag_n : aperture photometry in aperture n where n runs from 1 to 8, from
  5.5" to 49.5"
- wxmagp : profile fitting photometry on individual images. useful for source
  variability
- wxgmag : magnitude of extended source in the aperture from the 2MASS XSC.

On top of these, a source can be detected in band and not in others. This is
indicated in the AllWise catalog by the 'det_bit' and the 'ph_qual' flags.
A det_bit set to 0 indicates that the SNR at that position in the band is
below 2. Two cases can

As the goal of HELP is to provide a master flux for each source, we have decided
to build the F_WISE_Wx values from a combination of some of the fluxes listed
above:

- if the source is point-like, F_WISE_Wx is computed from wxmpro. As indicator
  of point-like source, we used the 'ext_flg' column, requesting a value of 0.
- if the source shows indications of not being point-like (ext_flg != 0), if the
  source has a valid wxgmag magnitude, that one is used for computing F_WISE_Wx
- if the source shows indications of not being point-like (ext_flg != 0), if the
  source has not a valid wxgmag, the profile fitting magnitude is used (wxmpro),
  as there is not really other measurements that could be used without
  a detailed investigation.
- we create a flag 'type_phot' indicating whether the source flux comes from
  wxmmpro (1) or wxgmag (2)

**As a result, sources for which 'ext_flg' !=0 and  type_phot = 1 should be
treated with caution.**

If a source is not detected in the band (below 2 sigma), the 'wxmpro' will
contain the 95% upper limit if the pht_qual flag is 'U'. If it is 'X' or 'Z',
there are no good sources of photometry and a NaN is unavoidable.  To summarize,
we create the following variables:

- F_WISE_Wx
- FErr_WISE_Wx
- Detection_WISE_Wx
- TypePhot_WISE_Wx

that are filled according to the prescriptions in the following table:

|        |                                                                |                             | FErr_WISE_Wx        | Detection_WISE_Wx | TypePhot_WISE_Wx |
|--------|----------------------------------------------------------------|-----------------------------|---------------------|-------------------|------------------|
| case 1 | det_bit = 1<br> ph_qual= 'A' or 'B' or 'C'<br> ext_flg = 0<br> | wxmpro                      | wxsigmpro           | 1                 | 1                |
| case 2 | det_bit = 0<br> ph_qual = 'U'<br> ext_flg = 0                  | 95 % upper limit<br> wxmpro | wxsigmpro (NaN)     | 3                 | 1                |
| case 3 | det_bit = 0<br> ph_qual = 'X' or 'Z'<br> any ext_flag          | wxmag (NaN)                 | wxsigm (NaN)        | 0                 | 3                |
| case 4 | det_bit = 1<br> ext_flg > 0<br> wxgmag not NaN                 | wxgmag                      | w1gerr              | 1                 | 2                |
| case 5 | det_bit = 1<br> ext_flg > 0<br> wxgmag = NaN                   | wxmpro                      | wxsigmpro           | 1                 | 1                |
| case 6 | det_bit = 0<br> ext_flg > 0<br> ph_qual = 'u'                  | wxmag                       | wxsigm (can be NaN) | 3                 | 3                |

AllWise magnitudes are on the Vega scale. They are converted to the AB scale
following the prescriptions of the explanatory supplement
http://wise2.ipac.caltech.edu/docs/release/allsky/expsup/sec4_4h.html#conv2flux
$m_{AB} = m_{Vega} + dm$ with $dm$ values of:

| Band | W1    | W2    | W3    | W4    |
|------|-------|-------|-------|-------|
| dm   | 2.699 | 3.339 | 5.174 | 6.620 |

The fluxes in Jy are then computed with F_WISE_Wx = 3631. x $10^{-0.4*(mv
+ dm)}$.

And the errors with: FErr_WISE_Wx = ln(10) / 2.5 × F_WISE_x × errmag

## Catalogs columns

| Column Name       | Description                                                                                                       |
|-------------------|-------------------------------------------------------------------------------------------------------------------|
| srcname           | Catalog official name. Full designation.                                                                          |
| RA                | Right Ascension (J2000) in degree                                                                                 |
| Dec               | Declination (J2000) in degree                                                                                     |
| F_WISE_W1         | Flux in the W1 band (microJy)                                                                                     |
| FErr_WISE_W1      | Error in Flux in the W1 band (microJy)                                                                            |
| Detection_WISE_W1 | Flag 1/0 indicating whether the source could be detected at least at 2 sigma in the W1 band.                      |
| PhotType_WISE_W1  | Flag [1 2  3] giving the  method used for determining the flux. See TypePhot_WISE_Wx in table above               |
| PhotCase_WISE_W1  | Flag [1-6] indicating which is the relevant case for the measure of the source in W1                              |
| F_WISE_W2         | Flux in the W2 band (microJy)                                                                                     |
| FErr_WISE_W2      | Error in Flux in the W2 band (microJy)                                                                            |
| Detection_WISE_W2 | Flag 1/0 indicating whether the source could be detected at least at 2 sigma in the W2 band.                      |
| PhotType_WISE_W2  | "Flag [1 2  3] giving the  method used for determining the flux. See TypePhot_WISE_Wx in table above"             |
| PhotCase_WISE_W2  | Flag [1-6] indicating which is the relevant case for the measure of the source in W2                              |
| F_WISE_W3         | Flux in the W3 band (microJy)                                                                                     |
| FErr_WISE_W3      | Error in Flux in the W3 band (microJy)                                                                            |
| Detection_WISE_W3 | Flag 1/0 indicating whether the source could be detected at least at 2 sigma in the W3 band.                      |
| PhotType_WISE_W3  | Flag [1 2  3] giving the  method used for determining the flux. See TypePhot_WISE_Wx in table above               |
| PhotCase_WISE_W3  | Flag [1-6] indicating which is the relevant case for the measure of the source in W3                              |
| F_WISE_W4         | Flux in the W4 band (microJy)                                                                                     |
| FErr_WISE_W4      | Error in Flux in the W4 band (microJy)                                                                            |
| Detection_WISE_W4 | Flag 1/0 indicating whether the source could be detected at least at 2 sigma in the W4 band.                      |
| PhotType_WISE_W4  | Flag [1 2  3] giving the  method used for determining the flux. See TypePhot_WISE_Wx in table above               |
| PhotCase_WISE_W4  | Flag [1-6] indicating which is the relevant case for the measure of the source in W4                              |
| cc_flags          | Contamination and confusion flag. Copied from the AllWise catalog. See AllWise explanatory supplement for details |
| ext_flg           | Extended source flag. Copied from the AllWise catalog. See AllWise explanatory supplement for details             |
| var_flg           | Variability flag. Copied from the AllWise catalog. See AllWise explanatory supplement for details                 |
| ph_qual           | Photometry quality flag. Copied from the AllWise catalog. See AllWise explanatory supplement for details          |
| cntr              | Unique identification number for this object in the AllWISE Catalog/Reject Tab. Copied from the AllWise catalog.  |
| tmass_key         | 2MASS PSC association. Copied from the AllWise catalog. See AllWise explanatory supplement for details            |
