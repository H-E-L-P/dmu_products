# CATALOG

## How to create catalog
I used a catalog created by Yannick. To create COSMOS catalog one need to download four catalogs:
1. http://vohedamtest.lam.fr/cosmos2015/q/cone/static/COSMOS2015-HELP_selected_20160613.fits.gz 
2. ftp://ftp.strw.leidenuniv.nl/pub/duncan/HELP/COSMOS/COSMOS2015-HELP_selected_20160613_photoz_v1.0.fits
3. http://hedam.lam.fr/HELP/dataproducts/dmu26/dmu26_XID+MIPS_COSMOS/data/dmu26_XID+MIPS_COSMOS_20170213_idshrunken.fits
4. http://hedam.lam.fr/HELP/dataproducts/dmu26/dmu26_XID+SPIRE_COSMOS/data/dmu26_XID+SPIRE_COSMOS_20161129_idshrunken.fits

and two scripts: 
1. https://rea-help.slack.com/files/yannick/F4DBCCCAC/merge_catalogues_v6.py - to merge catalogs
2. https://rea-help.slack.com/files/yannick/F4ETBS8UW/convert_for_cigale_v3.py - to prepare cigale-like input file. 

I changed a little bit the last script to obtain the the real names of the filters. I added a function NEW_NAME:

```
NEW_NAME = {
    "ks": "WFCAM_Ks",
    "y": "WFCAM_Y",
    "h": "WFCAM_H",
    "j": "UKIRT_WFCJ",
    "b": "SUBARU_B",
    "v": "SUBARU_V",
    "ip": "SUBARU_i",
    "r": "SUBARU_r",
    "u": "CFHT_u",
    "zp": "SUBARU_z",
    "zp": "SUBARU_zp",
    "ia484":"IB484_SCam",
    "ia527":"IB527_SCam",
    "ia624":"IB624_SCam",
    "ia679":"IB679_SCam",
    "ia738":"IB738_SCam",
    "ia767":"IB767_SCam",
    "ib427":"IB427_SCam",
    "ib464":"IB464_SCam",
    "ib505":"IB505_SCam",
    "ib574":"IB574_SCam",
    "ib709":"IB709_SCam",
    "ib827":"IB827_SCam",
    "hw":"CFHT_H",
    "ksw": "CFHT_wircam_Ks",
    "yhsc":"yHSC",
    "irac1": "IRAC1",
    "irac2": "IRAC2",
    "irac3": "IRAC3",
    "irac4": "IRAC4",
    "nuv":"NUV",
    "fuv": "FUV",
    "mips24": "MIPS1",
    "pacs100": "PACS_green",
    "pacs160": "PACS_red",
    "spire250": "PSW",
    "spire350": "PMW",
    "spire500": "PLW"
}
```
## Redshift distribution

![png](https://github.com/H-E-L-P/dmu_products/edit/master/dmu28/dmu28_COSMOS/COSMOS_redshift.png?raw=true)

## Filters

Our catalog contains the following bands:  FUV, NUV, CFHT u, SUBARU B,  SUBARU V, SUBARU r, SUBARU i, SUBARU z, yHSC, UKIRT WFCJ, CFHT H, CFHT wircam Ks, IRAC1, IRAC2, IRAC3, IRAC4, MIPS1, PACS green, PACS red,  PSW,  PMW and PLW.  We removed double bands (WFCAM Ks, WIRCAM Y, WFCAM H, z++), and narrow bands (IA484 SCam, IA527 SCam, IA624 SCam, IA679 SCam, IA738 SCam, IA773 SCam, IA427 SCam, IA464 SCam, IA505 SCam, IA574 SCam, IA709 SCam, IA827 SCam, NB717 and NB816) as it gave us very dense coverage of the optical passbands in comparison with the infrared part of the spectra. 

To pick one filter over two similar ones, we decided to check the number of measurements in the full catalog of 694 478 HELP-COSMOS galaxies, the depth of which filter and the distribution of uncertainties. 

**Ks**: CFHTLS wircam Ks: 512 131 vs **WFCAM Ks: 594 551**

**Y**: WIRCAM Y: 529 129 vs **SUBARU yHSC: 661 669**

**H**: WFCAM H: 517 441 vs **CFHT H: 589 027**


# Sample selection

To make a test of our approach we used the best sample selected from COSMOS field  for which PACS  and SPIRE fluxes are available (marked with a good flag). We selected **1012** galaxies. We used photometric redshifts provided by Ken. The measurements in the HELP-COSMOS catalog are not k-corrected but as the mean Galactic extinction  at the object position  is very low (mean value equal to 0.019$\pm$0.001, and median: 0.019) we used not corrected fluxes.




