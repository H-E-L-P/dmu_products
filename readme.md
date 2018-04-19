HELP DMU product repository
===========================

This repository contains the products of the various HELP *Data Management
Units* (DMU). The Github repository contains everything except the actual data,
while [it's mirror on HeDaM](http://hedam.lam.fr/HELP/data/dmu_products/)
contains everything. The reason not to store the data files in Github is that we
have huge files and git is not meant to manipulate such large files (except
using *Large File Storage*).

The repository is organised as follow:

- Each DMU (see [list below](#dmu-list)) has its own directory. You can add
  a `readme.md` file with any appropriate information.
- Each DMU product lives in a separate directory. Here again, you can add
  a `readme.md` file that will be displayed in Github.  If you want to keep your
  data in the clone of this repository on your computer, you can put it in
  a `data/` folder inside the DMU product directory.  These folders are
  automatically ignore by git.

Procedure to add a new DMU data product
---------------------------------------

Here is the procedure to add a new DMU data product:

- Create a `dmu<nn>/dmu<nn>_<product_name>` directory.
- Create a `readme.md` file describing the product.  Indicate what pristine data
  was used and all the process that was applied to it.
- You may add some scripts in the folder or create another DMU product
  containing the programme that you are using in various products.
- Add a `meta_main.yml` and one or more `meta_survey.yml` (if there are several,
  name them `meta_survey_1.yml` and so on) taken form the `TEMPLATES` directory.
  These files are important as they allow us to trace and acknowledge the data
  we use.
- Don't put the actual data on Github, instead explain how to get it in
  a `get_data.md` file or contact Yannick.

When this is done, Yannick will:

- Synchronise the DMU product repository on HeDaM and add the actual data in the
  `data/` folder.
- Add a `changelog.md` file describing the history of the data product.
- Add a `dmu2_validation` report with technical checks to the data.

Procedure for validators
------------------------

When you have to validate a product, you can download it [from
HeDaM](http://hedam.lam.fr/HELP/data/dmu_products/).  Then you need to add
a `validation_report.md` file inside the product folder and sync it back to
Github.  You can also update the `changelog.md` file.

DMU list
--------

Here is the list of the DMU numbers with their associated responsibility.

 DMU#  |  Responsibility
-------|------------------------------------------
 0     |  Pristine catalogues
 1     |  Masterlist data
 2     |  HeDaM
 3     |  Morphologies (Shapes & Sizes) of Objects
 4     |  Bright Star Mask
 5     |  Known Star Flag
 6     |  Optical photometry validation
 7     |  Optical photometry
 8     |  Radio data - LOFAR & FIRST/NVSS/TGSS
 9     |  Radio data - JVLA-DEEP & GMRT-DEEP
 10    |  Data Fusion
 11    |  Cross matching MIPS/PACS/SPIRE
 12    |  Cross Matching LOFAR & FIRST/NVSS/TGSS
 13    |  Cross Matching JVLA-DEEP & GMRT-DEEP
 14    |  GALEX data
 15    |  X-Ray data
 16    |  WISE Photometry
 16a   |  WISE (allwise)
 17    |  MIPS Maps
 18    |  PACS maps
 19    |  SPIRE maps
 20    |  MIPS blind photometry
 21    |  PACS blind photometry
 22    |  SPIRE blind photometry
 23    |  Spec-z data
 24    |  Photo-z
 25    |  Prior model
 26    |  XID+
 27    |  Empirical models / templates
 28    |  SED fitting / CIGALE
 29    |  Radiative transfer models
 30    |  Missing (supplementary) Sources
 31    |  Tools
 32    |  Merged catalogue

