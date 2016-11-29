# Templates for meta-data files

In the standards we defined some time ago, we insisted on the meta-data that
must be associated to each product. We decided to add them in special Header
Data Units (HDU). Doing this may not be convenient, especially when a product if
produced elsewhere.

This directory contains template files to give the same information in text
files:

- `meta_main.yml` contains the main information on the HELP data product.
- `meta_survey.yml` contains the information on the original survey. When
  several surveys are combined, the work package must provide several files
  `meta_survey_1.yml`, `meta_survey_2.yml`, etc.

Those files are `YAML` containing several items (like FITS keywords) that can
easily be read by a computer programme. You should not worry and only fill the
information after the `:` preserving one blank line between items. I will
reformat them if needed.
