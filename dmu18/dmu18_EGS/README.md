### dmu18_EGS

### PSF Stack
PSF stacking for EGS maps was carried out using IDL code on ./PACS_PSF_STACK/
Both, input data for running the code, and output data are in :
./data/

Due to bad 100um stacking, 'EGS-PACS100_20161012_stacked+psf_100.fits' in 
http://hedam.lam.fr/HELP/dataproducts/dmu18/dmu18_EGS/data/' was used instead. 


### PSF normalisation
PSF normalisation for EGS maps was carried out using the Jupyter notebooks 
[normalize_PACS_100_psf.ipynb](./normalize_PACS_100_psf.ipynb) and [normalize_PACS_160_psf.ipynb](./normalize_PACS_160_psf.ipynb)

## Final Product
Normalised PSFs (/sr):

./dmu18_PACS_100_PSF_EGS_20190123_sr.fits
./dmu18_PACS_160_PSF_EGS_20190123_sr.fits

Normalised PSFs (/pix):

./dmu18_PACS_100_PSF_EGS_20190125.fits
./dmu18_PACS_160_PSF_EGS_20190125.fits