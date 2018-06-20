![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=100&v=4)


# Template Files [title meaningful to general astronomer information]

The files in this folder provide templates for development of HELP
documentation, acknowledgements and navigation.


## Templates for meta-data files

The HELP standard for documentation of the provenance of data sets is
through the provision of ``YAML" meta files.  These meta files 

This directory contains template files to give the same information in text
files:

- `meta_main.yml` contains the main information on the HELP data product.
- `meta_survey.yml` contains the information on the original survey. When
  several surveys are combined, the work package must provide several files
  `meta_survey_1.yml`, `meta_survey_2.yml`, etc.

Those files are `YAML` containing several items (like FITS keywords) that can
easily be read by a computer programme. You should not worry and only fill the
information after the `:` preserving one blank line between items.

## Footer

-------------------------------------------------------------------------------

*This is a default HELP markdown footer*
The Herschel Extragalactic Legacy Project, (HELP](http://herschel.sussex.ac.uk/), is a European
Commission Research Executive Agency funded project under the
SP1-Cooperation, Collaborative project, Small or medium-scale focused
research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.
