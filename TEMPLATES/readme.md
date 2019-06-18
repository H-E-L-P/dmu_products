

# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP Template Files (dmuXX)

*The title above should be meaninful for astronomers*

This is a data product of the Herschel Extragalactic Legacy Project ([HELP](http://www.herschel.sussex.ac.uk)). This sentence gives a very simple overview of what is stored in this folder understandable to a first year astronomy PhD.

The files in this folder provide templates for development of HELP documentation, acknowledgements and navigation. This second top level paragraph can give a bit more detail about what is stored here. Do you want any links to code used? Perhaps you should specify git versions or give a brief overview of what the code does.

The full files which are not stored in the Git repository can be downloaded from HeDaM:

- [http://hedam.lam.fr/HELP/dataproducts/](http://hedam.lam.fr/HELP/dataproducts/)

## Folder structure
This section describes how this folder is organised. Is it organised by field or by some other criteria such as survey. Perhaps there should be a table here describing all the folders that are present? Perhaps there should be an overview of the format of the data files. Are they tables? Where is the description of the column headings in yml format? Where can the data be downloaded from? Do you have links to HeDaM files? Do you have example queries for getting info from a VO database? Do you need describe where inputs come from other parts of dmu_products. 

## Templates for Readme.md

[This file itself](https://github.com/H-E-L-P/dmu_products/tree/master/TEMPLATES/readme.md)
is a template for our readme.md files.

*comments in italics give guidance on what to put in template*


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

Procedure to add a new DMU data product
---------------------------------------

Here is the procedure to add a new DMU data product:

- Create a `dmu<nn>/dmu<nn>_<product_name>` directory.
- Create a `readme.md` file describing the product.  Indicate what pristine data
  was used and all the processes that were applied to it.
- You may add some scripts in the folder or create another DMU product
  containing the programme that you are using in various products.
- Add a `meta_main.yml` and one or more `meta_survey.yml` (if there are several,
  name them `meta_survey_1.yml` and so on) taken from the `TEMPLATES` directory.
  These files are important as they allow us to trace and acknowledge the data
  we use.
- Don't put the actual data on Github, instead explain how to get it in
  a `get_data.md` file, or contact Yannick.

When this is done, Yannick will:

- Synchronise the DMU product repository on HeDaM and add the actual data in the
  `data/` folder.
- Add a `changelog.md` file describing the history of the data product.
- Add a `dmu2_validation` report with technical checks to the data.

Procedure for validators
------------------------

When you have to validate a product, you can download it [from
HeDaM](http://hedam.lam.fr/HELP/dataproducts/).  Then you need to add
a `validation_report.md` file inside the product folder and sync it back to
Github.  You can also update the `changelog.md` file.


-------------------------------------------------------------------------------

*This is a default HELP Readme markdown footer which should be identical across all fields*

**Authors**: *insert your name(s) here e.g.*  Yannick Rohelly, [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)

