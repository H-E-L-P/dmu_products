### dmu18_ELAIS-N2

### PSF Stack

PSF stacking for ELAIS-N2 maps was carried out using IDL code on ./PACS_PSF_STACK/
Both, input data for running the code, and output data are in :
./data/
Final stacked PSFs: 'psf_native.fits'

Due to bad 100um image, 'ELAIS-N2-100um-psffromstack.fits' in 
http://hedam.lam.fr/HELP/dataproducts/dmu18/dmu18_ELAIS-N2/data/' was used instead. 

### PSF normalisation
PSF normalisation for ELAIS-N2 maps was carried out using the Jupyter notebooks 
[normalize_PACS_100_psf.ipynb](./normalize_PACS_100_psf.ipynb) and [normalize_PACS_160_psf.ipynb](./normalize_PACS_160_psf.ipynb)


## Final Product
Normalised PSFs:

./dmu18_PACS_100_PSF_ELAIS-N2_20190124.fits
./dmu18_PACS_160_PSF_ELAIS-N2_20190124.fits