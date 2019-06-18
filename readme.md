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

 DMU              |  Responsibility
------------------|------------------------------------------
 [DMU0](dmu0)     |  Pristine catalogues
 [DMU1](dmu0)     |  Masterlist data
 [DMU2](dmu0)     |  Field definitions
 [DMU3](dmu0)     |  Morphologies (Shapes & Sizes) of Objects
 [DMU4](dmu0)     |  Bright Star Mask
 [DMU5](dmu0)     |  Known Star Flag
 [DMU6](dmu0)     |  Optical photometry validation
 [DMU7](dmu0)     |  Optical photometry
 [DMU8](dmu0)     |  Radio data - LOFAR & FIRST/NVSS/TGSS
 [DMU9](dmu0)     |  Radio data - JVLA-DEEP & GMRT-DEEP
 [DMU10](dmu10)    |  Data Fusion
 [DMU11](dmu11)    |  Cross matching MIPS/PACS/SPIRE
 [DMU12](dmu12)    |  Cross Matching LOFAR & FIRST/NVSS/TGSS
 [DMU13](dmu13)    |  Cross Matching JVLA-DEEP & GMRT-DEEP
 [DMU14](dmu14)    |  GALEX data
 [DMU15](dmu15)    |  X-Ray data
 [DMU16](dmu16)    |  WISE Photometry
 [DMU17](dmu17)    |  MIPS Maps
 [DMU18](dmu18)    |  PACS maps
 [DMU19](dmu19)    |  SPIRE maps
 [DMU20](dmu20)    |  MIPS blind photometry
 [DMU21](dmu21)    |  PACS blind photometry
 [DMU22](dmu22)    |  SPIRE blind photometry
 [DMU23](dmu23)    |  Spec-z data
 [DMU24](dmu24)    |  Photo-z
 [DMU25](dmu25)    |  Prior model
 [DMU266](dmu26)    |  XID+
 [DMU27](dmu27)    |  Empirical models / templates
 [DMU28](dmu28)    |  SED fitting / CIGALE
 [DMU29](dmu29)    |  Radiative transfer models
 [DMU30](dmu30)    |  Missing (supplementary) Sources
 [DMU31](dmu31)    |  Tools
 [DMU32](dmu31)    |  Merged catalogue


Running the code
----------------

Most of the code used to generate and manipulate data here is run through Jupyter notebooks and makes extensive use of the Python package `herschelhelp_internal` written for the purpose. Installation instructions are available on the GitHub download page:

- [https://github.com/H-E-L-P/herschelhelp_internal](https://github.com/H-E-L-P/herschelhelp_internal)

If you don't wish to rerun or adapt the code here but just to use the data, you may be interested in the Python package `herschelhelp_python`. We anticipate most users of HELP data using this package.

- [https://github.com/H-E-L-P/herschelhelp_python](https://github.com/H-E-L-P/herschelhelp_python)



-------------------------------------------------------------------------------

**Authors**: [Raphael Shirley](http://raphaelshirley.co.uk/), Yannick Roehlly, Peter Hurley, Ken Duncan, Kasia Malek, Estelle Pons, [Seb Oliver](http://www.sussex.ac.uk/profiles/91548)

 ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4)
 
For a full description of the database and how it is organised in to `dmu_products` please see the top level [readme](../readme.md).
 
The Herschel Extragalactic Legacy Project, ([HELP](http://herschel.sussex.ac.uk/)), is a [European Commission Research Executive Agency](https://ec.europa.eu/info/departments/research-executive-agency_en)
funded project under the SP1-Cooperation, Collaborative project, Small or medium-scale focused research project, FP7-SPACE-2013-1 scheme, Grant Agreement
Number 607254.

[Acknowledgements](http://herschel.sussex.ac.uk/acknowledgements)
