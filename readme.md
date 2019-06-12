# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP DMU product repository


This repository contains the products of the various HELP *Data Management
Units* (DMU). The Github repository contains everything except the actual data,
while [its mirror on HeDaM](http://hedam.lam.fr/HELP/dataproducts/)
contains everything. The reason not to store the data files in Github is that we
have such huge files, that git is not designed for working with them. The directory structures on HeDaM and GitHub are  identical. If you plan to use HELP data extensively, we recommend cloning the GitHub repository and downloading data to the corresponding data folders on your computer so that relative links continue to work properly. As well as accessing the binary data files on HeDaM:

- [http://hedam.lam.fr/HELP/dataproducts/](http://hedam.lam.fr/HELP/dataproducts/)

it is also possible to query the data from the Virtual Observatory database:

- [https://herschel-vos.phys.sussex.ac.uk/](https://herschel-vos.phys.sussex.ac.uk/)

The repository is organised as follows:

- Each DMU (see [list below](#dmu-list)) has its own directory (e.g. DMU24/ contains photometric redshifts). 
- Each DMU product (e.g. photometric redshifts in the XMM-LSS field) lives in a separate sub-directory. These contain
  a `readme.md` file describing the data product.  If you want to keep your
  data in the clone of this repository on your computer, you can put it in
  a `data/` folder inside the DMU product directory.  These folders are
  automatically ignored by git.



DMU list
--------

Here is the list of the DMU numbers with their associated responsibility. Some of these involve ongoing work and are not currently on GitHub. dmu32 contains the main HELP data product which joins together data from dmu0 (optical surveys), dmu1 (masterlist), dmu24 (photometric redshifts), dmu26 (XID+ fluxes), dmu28 (CIGALE SED fits).

 DMU#  |  Responsibility
-------|------------------------------------------
 0     |  Pristine catalogues
 1     |  Masterlist data
 2     |  Field definitions
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


Running the code
----------------

Most of the code used to generate and manipulate data here is run through Jupyter notebooks and makes extensive use of the Python package `herschelhelp_internal` written for the purpose. Installation instructions are available on the GitHub download page:

- [https://github.com/H-E-L-P/herschelhelp_internal](https://github.com/H-E-L-P/herschelhelp_internal)

If you don't wish to rerun or adapt the code here but just to use the data, you may be interested in the Python package `herschelhelp_python`. We anticipate most users of HELP data using this package.

- [https://github.com/H-E-L-P/herschelhelp_python](https://github.com/H-E-L-P/herschelhelp_python)

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

**Authors**: [Raphael Shirley](http://raphaelshirley.co.uk/), Yannick Roehlly, Peter Hurley, Ken Duncan, Kasia Malek, Estelle Pons, [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)
