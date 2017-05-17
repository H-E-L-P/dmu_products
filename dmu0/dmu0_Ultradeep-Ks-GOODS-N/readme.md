Ultradeep Ks Imaging in the GOODS-N
===================================

This product contains the catalogue of Ks and IRAC fluxes from the “Ultradeep Ks
Imaging in the GOODS-N” (Wang et al., 2010). The catalogue was downloaded from
http://www.asiaa.sinica.edu.tw/~whwang/goodsn_ks/ (`table3_ver2.txt.gz`) and
transformed to FITS table.

Here is the header of the original ASCII table:

```
       Ultradeep Ks Imaging in the GOODS-N
Authors: Wang, W.-H., Cowie, L.L., Barger, A.J., Keenan, R.C., Ting, H.-C.
Table: Ks Selected Multi-Band Catalog
================================================================================
Byte-by-byte Description of file: table3.txt
--------------------------------------------------------------------------------
   Bytes Format Units    Label   Explanations
--------------------------------------------------------------------------------
   1-  6 I6     ---      Num     Catalog number
   9- 18 F10.6  deg      RAdeg   Right Ascension in decimal degrees (J2000)
  21- 29 F9.6   deg      DEdeg   Declination in decimal degrees (J2000)
  31- 40 F10.3  uJy      F_Ks    WIRCam Ks-band flux
  42- 51 F10.3  uJy    e_F_Ks    The 1{sigma} error in Flux
  53- 62 F10.3  uJy      F_3.6   IRAC 3.6 um flux
  64- 73 F10.3  uJy    e_F_3.6   The 1{sigma} error in Flux
  75- 84 F10.3  uJy      F_4.5   IRAC 4.5 um flux
  86- 95 F10.3  uJy    e_F_4.5   The 1{sigma} error in Flux
  97-106 F10.3  uJy      F_5.8   IRAC 5.8 um flux
 108-117 F10.3  uJy    e_F_5.8   The 1{sigma} error in Flux
 119-128 F10.3  uJy      F_8.0   IRAC 8.0 um flux
 130-139 F10.3  uJy    e_F_8.0   The 1{sigma} error in Flux
--------------------------------------------------------------------------------
Note : If the measured fluxes are less than the flux errors (S/N < 1), zeros are
assigned to the fluxes but the errors are given for upper limits. Zero flux
errors mean that the sources do not have measurements (i.e., Ks sources not in
the IRAC regions.)
--------------------------------------------------------------------------------
```

There are a few sources outside of HELP coverage so the catalogue was filtered
with our `filterAndTag.sh` tool.
