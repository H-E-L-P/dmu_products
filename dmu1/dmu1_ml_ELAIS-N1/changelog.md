## 2017-03-08: Initial notebook

Initial version of the notebook for master-catalogue creation.

## 2017-03-13: Choices for SpARCS

Updated notebook and new one with analysis to make choices for aperture
correction of the SpARCS data.

## 2017-05-10: IRAC1 and IRAC2 flux selection

Both SERVS and SWIRE provide IRAC1 and IRAC2 fluxes. We use only one value,
preferably SERVS except when its flux is over 2000 μJy (SERVS tends to
underestimate large fluxes).

## 2017-06-06: New pristine catalogues and notebook split

HSC-PSS and PanSTARRS-3SS were added.  The monolithic notebook was split and
temporary files are saved in `data_tmp`.

## 2017-06-27: Update notebook

- Add aperture correction to HSC.
- Compute stellarity for HSC.
- Add HEALPix index to master list.
