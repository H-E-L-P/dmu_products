### dmu18_XMM-LSS

### PSF Stack
PSF stacking for XMM-LSS maps was carried out using IDL code on ./PACS_PSF_STACK/

Both, input data for running the code, and output data are in :
./data/


### PSF normalisation
PSF normalisation for XMM-LSS maps was carried out using the Jupyter notebooks 
[normalize_PACS_100_psf.ipynb](./normalize_PACS_100_psf.ipynb) and [normalize_PACS_160_psf.ipynb](./normalize_PACS_160_psf.ipynb)

## Final Product
Normalised PSFs(/sr):

./dmu18_PACS_100_PSF_XMM-LSS_20190125_sr.fits
./dmu18_PACS_160_PSF_XMM-LSS_20190125_sr.fits

Normalised PSFs(/pix):

./dmu18_PACS_100_PSF_XMM-LSS_20190125.fits
./dmu18_PACS_160_PSF_XMM-LSS_20190125.fits