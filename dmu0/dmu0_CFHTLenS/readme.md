The CFHT Lensing Survey (CHTSLenS) catalogue
============================================

This product contains the catalogue from the CFHT Lensing Survey.  The catalogue
was obtained from the [CFHTLenS catalog query
page](http://www.cadc-ccda.hia-iha.nrc-cnrc.gc.ca/en/community/CFHTLens/query.html)
using the standard query for HELP (see `misc_tools/coverage`).  The result was
then limited to HELP coverage and a catalogue per field was produced.

In the catalogue, we renamed the `field` column to `cfhtlens_field` because we
use a `field` column to hold the HELP field name in our workflow.

The CFHTLenS catalogue covers the fields EGS, GAMA-09, and XMM-LSS.
