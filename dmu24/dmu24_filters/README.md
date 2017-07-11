# Filter library for photometric redshifts and physical modeling

This folder contains all filter response files required for photometric redshift
fitting and/or physical modeling in any HELP field.

Filter files are in VOTable format and where available are taken directly from
from the [SVO Filter Profile Service](http://svo2.cab.inta-csic.es/theory/fps/).
File format and contents therefore follow the conventions

In some cases, the filter files stored at SVO do not include the full throughput
information including optical throughputs, atmosphere and CCD quantum efficiency.
For these filters, additional processing was done to include these effects in the
response curves - making use of the appropriate observatory/instrument specific
reference information.

Information on what additional processing was done and references for files used
in doing so have been included in an additional header parameter ("AdditionalProcessing").

When filters are not available through SVO in the required format, new VO-compatible
files have been constructed from the available plain text filter files. These files
follow the same format as the SVO FPS file format and key header information has
been included (note that not all keywords included in the SVO files are currently
  included in the VO files created from scratch).

NB: Filter response curves for all bands in the masterlists are included.
However, this does not guarantee that filters use in the respective photo-z estimation
or physical modeling.


| Telescope / Instrument | Filter*        | Filter File       | Fields      |
|------------------------|----------------|-------------------|-------------|
| Subaru/HSC             | suprime_g      | HSC-g_mod.res     | ELAIS-N1    |
| Subaru/HSC             | suprime_r      | HSC-r_mod.res     | ELAIS-N1    |
| Subaru/HSC             | suprime_i      | HSC-i_mod.res     | ELAIS-N1    |
| Subaru/HSC             | suprime_z      | HSC-z_mod.res     | ELAIS-N1    |
| Subaru/HSC             | suprime_y      | HSC-Y_mod.res     | ELAIS-N1    |
| Subaru/HSC             | suprime_n921   | wHSC-NB921_mod.res| ELAIS-N1    |
| CFHT/MegaPrime/MegaCam | cfht_megacam_u | MegaCam.u.res     | ELAIS-N1    |
| CFHT/MegaPrime/MegaCam | cfht_megacam_g | MegaCam.g.res     | ELAIS-N1    |
| CFHT/MegaPrime/MegaCam | cfht_megacam_r | MegaCam.r.res     | ELAIS-N1    |
| CFHT/MegaPrime/MegaCam | cfht_megacam_z | MegaCam.z.res     | ELAIS-N1    |
| INT/WFC                | wfc_u          | WFC.RGO_u_qe.res  | ELAIS-N1    |
| INT/WFC                | wfc_g          | WFC.Gunn_g_qe.res | ELAIS-N1    |
| INT/WFC                | wfc_r          | WFC.Gunn_r_qe.res | ELAIS-N1    |
| INT/WFC                | wfc_i          | WFC.Gunn_i_qe.res | ELAIS-N1    |
| INT/WFC                | wfc_z          | WFC.RGO_z_qe.res  | ELAIS-N1    |
| Pan-STARRS1/Pan-STARRS1| gpc1_g         | PS1.g.res         | ELAIS-N1    |
| Pan-STARRS1/Pan-STARRS1| gpc1_r         | PS1.r.res         | ELAIS-N1    |
| Pan-STARRS1/Pan-STARRS1| gpc1_i         | PS1.i.res         | ELAIS-N1    |
| Pan-STARRS1/Pan-STARRS1| gpc1_z         | PS1.z.res         | ELAIS-N1    |
| Pan-STARRS1/Pan-STARRS1| gpc1_y         | PS1.y.res         | ELAIS-N1    |
| UKIRT/WFCAM            | ukidss_j       | UKIDSS.J          | ELAIS-N1    |
| UKIRT/WFCAM            | ukidss_k       | UKIDSS.K          | ELAIS-N1    |
| Spitzer/IRAC           | irac_1         | IRAC.I1           | ELAIS-N1    |
| Spitzer/IRAC           | irac_2         | IRAC.I2           | ELAIS-N1    |
| Spitzer/IRAC           | irac_3         | IRAC.I3           | ELAIS-N1    |
| Spitzer/IRAC           | irac_4         | IRAC.I4           | ELAIS-N1    |

*Filter name as used in dmu1 masterlists.
