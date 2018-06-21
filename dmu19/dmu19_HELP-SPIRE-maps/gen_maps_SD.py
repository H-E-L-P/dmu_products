"""Script to generate the HELP homogenised SPIRE maps."""

from datetime import datetime
from itertools import product

import numpy as np
import os

from astropy.io import fits
from astropy.table import Table
import MF_HELP as MF

VERSION = "1.0"

spire_maps = Table.read("spire_maps.fits")
all_obsids = Table.read("spire_obsids.fits")


nconf = np.array([0.0069, 0.0070, 0.0064]) # Smith et al. 2017, table 6
fwhm = np.array([18.15,25.15,36.3]) # Parameters used for XID+ HELP catalogues


def get_band(filename):
    if "250" in filename or "psw" in filename.lower():
        return "250"
    if "350" in filename or "pmw" in filename.lower():
        return "350"
    if "500" in filename or "plw" in filename.lower():
        return "500"
    raise ValueError(f"Can't identify the band in '{filename}'.")


# HerMES
hermes_maps = spire_maps[(spire_maps['survey'] == "HerMES") & (spire_maps['field'] != "Herschel-Stripe-82")]
pixsize = np.array([6., 8.333, 12.])
for row in hermes_maps:
    field = row['field']
    filename = row['filename']

    if "hers-helms-xmm" not in filename:
        obsids = sorted(list(all_obsids['ObsID'][
            all_obsids['field'] == field
        ]))
    else:
        obsids = sorted(list(all_obsids['ObsID'][
            (
                (all_obsids['field'] == field) |
                (all_obsids['field'] == 'XMM-LSS')
            ) & (all_obsids['not_in_hs82'] == 0)
        ]))
    assert len(obsids) > 0

    orig_hdu_list = fits.open(f"../dmu19_HerMES/data/{filename}")

    image_hdu = orig_hdu_list[1]
    assert image_hdu.header['EXTNAME'] == "image"
    image_hdu.header['EXTNAME'] = "IMAGE"
    image_hdu.header['BUNIT'] = "Jy / beam"

    if filename == 'hers-helms-xmm_itermap_20160623_PSW.fits':
        # FIXME The Herschel-Strip-82 SPIRE250 map is corrupted; we can only
        # access the image data.
        error_hdu = fits.ImageHDU()
        error_hdu.header['EXTNAME'] = "ERROR"
        error_hdu.header.add_comment("The error map is not available.")
        exposure_hdu = fits.ImageHDU()
        exposure_hdu.header['EXTNAME'] = "EXPOSURE"
        exposure_hdu.header.add_comment("The exposure map is not available.")
        mask_hdu = fits.ImageHDU()
        mask_hdu.header['EXTNAME'] = "MASK"
        mask_hdu.header.add_comment("The mask map is not available.")

    else:
        error_hdu = orig_hdu_list[2]
        assert error_hdu.header['EXTNAME'] == "error"
        error_hdu.header['EXTNAME'] = "ERROR"
        error_hdu.header['BUNIT'] = "Jy / beam"

        exposure_hdu = orig_hdu_list[3]
        assert exposure_hdu.header['EXTNAME'] == "exposure"
        exposure_hdu.header['EXTNAME'] = "EXPOSURE"
        exposure_hdu.header['BUNIT'] = "s"

        mask_hdu = orig_hdu_list[4]


        if "hers-helms-xmm" not in filename and "SSDF" not in filename:
            assert mask_hdu.header['EXTNAME'] == "flag"
        else:
            assert mask_hdu.header['EXTNAME'] == "mask"
            # The Herschel-Stripe-82 and SSDF masks are 0 for bad and 1 for
            # good while we use the reverse for HELP
            good_mask = mask_hdu.data == 1
            bad_mask = mask_hdu.data == 0
            mask_hdu.data[good_mask] = 0
            mask_hdu.data[bad_mask] = 1
        mask_hdu.header['EXTNAME'] = "MASK"
        if "SSDF" in filename:
            good = exposure_hdu.data != 0
            bad = exposure_hdu.data == 0
            mask_hdu.data[good] = 0
            mask_hdu.data[bad] = 1


    nebfilt_map_name = filename.replace(".fits", "_nebfiltered.fits")
    nebfilt_map = fits.open(
        f"../dmu19_nebular_filtered_maps/data/{nebfilt_map_name}")
    nebfilt_hdu = fits.ImageHDU(header=nebfilt_map[0].header,
                                data=nebfilt_map[0].data)
    nebfilt_hdu.header['EXTNAME'] = "NEBFILT"
    nebfilt_hdu.header['BUNIT'] = "Jy / beam"

    image_hdu.data -= np.nanmean(image_hdu.data) 
    good_filter = np.abs(image_hdu.data - nebfilt_hdu.data) < 0.1 # smaller thatn 100mJy difference
    nebfilt_hdu.data -= np.nanmean(nebfilt_hdu.data[good_filter])  # Background substration neb
    nebfilt_hdu.data[~good_filter] = np.nan
    if get_band(filename) == "250": ind = 0 
    if get_band(filename) == "350": ind = 1 
    if get_band(filename) == "500": ind = 2


    use_for_mf_noise =  error_hdu.data < np.sqrt(2)*np.nanmedian(error_hdu.data)
    noise = np.median(error_hdu.data[use_for_mf_noise])

    if 'CD2_2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CD2_2'] * 3600. - pixsize[ind]) 
        print(image_hdu.header['CD2_2'] * 3600., pixsize[ind])
    elif 'CDELT2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CDELT2'] * 3600. - pixsize[ind])         
        print(image_hdu.header['CDELT2'] * 3600.,pixsize[ind])
    if delt_pix > 0.01:
        print('pix_size_wrong')
        exit()    



    mf, psf = MF.matched_filter(fwhm[ind], pixsize[ind], nconf[ind], noise, whitenoise=True, image=False, psf_only=False, normalize=False)
    image_to_convolve = 1.0*nebfilt_hdu.data
    error_to_convolve = 1.0*error_hdu.data
    conv_map, conv_noise, matchedfilter = MF.do_filtering(image_to_convolve, error_to_convolve, mf , psf)


    mf_hdu = fits.ImageHDU(header=nebfilt_hdu.header,
                                data=conv_map)
    mf_hdu.header['EXTNAME'] = "MFILT"
    mf_hdu.header['BUNIT'] = "Jy / beam"
    mf_error_hdu = fits.ImageHDU(header=error_hdu.header,
                                data=conv_noise)
    mf_error_hdu.header['EXTNAME'] = "MFILT_ERROR"
    mf_error_hdu.header['BUNIT'] = "Jy / beam"

    filter_hdu = fits.PrimaryHDU()
    filter_hdu.header.append(("EXTNAME", "Matchedfilter"))
    filter_hdu.header.append(("FWHM", fwhm[ind], "FWHM of PSF in NEBFILT map"))
    filter_hdu.header.append(("nconf", nconf[ind], "confusion noise, Jy/beam"))
    filter_hdu.header.append(("nins", noise, "instrumental noise, Jy/beam"))
    filter_hdu.header.append(("pixsize", pixsize[ind], "pixel size, arcsec"))

    filter_hdu = fits.ImageHDU(header=filter_hdu.header,
                                data=matchedfilter)

    primary_hdu = fits.PrimaryHDU()
    primary_hdu.header.append((
        "CREATOR", "Herschel Extragalactic Legacy Project"
    ))
    primary_hdu.header.append((
        "TIMESYS", "UTC", "All dates are in UTC time"
    ))
    primary_hdu.header.append((
        "DATE", datetime.now().replace(microsecond=0).isoformat(),
        "Date of file creation"
    ))
    primary_hdu.header.append((
        "VERSION", VERSION, "HELP product version"
    ))
    primary_hdu.header.append((
        "TELESCOP", "Herschel", "Name of the telescope"
    ))
    primary_hdu.header.append((
        "INSTRUME", "SPIRE", "Name of the instrument"
    ))
    primary_hdu.header.append((
        "FILTER", f"SPIRE-{get_band(filename)}", "Name of the filter"
    ))
    primary_hdu.header.append((
        "FIELD", field, "Name of the HELP field"
    ))
    for idx, obs_id in enumerate(obsids):
        keyword = "OBSID" + str(idx).zfill(3)
        primary_hdu.header.append((keyword, obs_id))

    if "hers-helms-xmm" in filename:
        primary_hdu.header.add_comment(
            "These maps also contain some observations on the XMM-LSS field.")

    hdu_list = fits.HDUList([primary_hdu, image_hdu, nebfilt_hdu, error_hdu,
                             exposure_hdu, mask_hdu,mf_hdu,mf_error_hdu,filter_hdu])
    #os.remove(f"data_HELP_v1.0/{field}_SPIRE{get_band(filename)}_v{VERSION}.fits")

    hdu_list.writeto(f"data_HELP_v1.0/{field}_SPIRE{get_band(filename)}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {get_band(filename)} processed...")
    print(fwhm[ind], pixsize[ind], nconf[ind], noise)
    hdu_list.close()

print('done hermes')


# AKARI-NEP
akarinep_maps = spire_maps[spire_maps['survey'] == "AKARI-NEP"]
pixsize = np.array([6., 10., 14.])

for row in akarinep_maps:
    field = row['field']
    filename = row['filename']

    obsids = sorted(list(all_obsids['ObsID'][all_obsids['field'] == field]))
    assert len(obsids) > 0

    orig_hdu_list = fits.open(f"../dmu19_AKARI-NEP/data/{filename}")

    image_hdu = orig_hdu_list[1]
    assert image_hdu.header['EXTNAME'] == "image"
    image_hdu.header['EXTNAME'] = "IMAGE"
    image_hdu.header['BUNIT'] = "Jy / beam"

    error_hdu = orig_hdu_list[2]
    assert error_hdu.header['EXTNAME'] == "error"
    error_hdu.header['EXTNAME'] = "ERROR"
    error_hdu.header['BUNIT'] = "Jy / beam"

    # The maps contain the coverage and where observed in normal mode.
    exposure_hdu = orig_hdu_list[3]
    assert exposure_hdu.header['EXTNAME'] == "coverage"
    exposure_hdu.data *= 1 / 18.6  # Conversion of coverage to exposure
    exposure_hdu.header['EXTNAME'] = "EXPOSURE"
    exposure_hdu.header['BUNIT'] = "s"
    exposure_hdu.header['QTTY____'] = "s"

    # The maps do not contain mask maps.
    mask_hdu = fits.ImageHDU()
    mask_hdu.header['EXTNAME'] = "MASK"
    mask_hdu.header.add_comment("The mask map was not available.")
    mask_hdu.header.add_comment("new mask: mask = exposure == 0")

    mask = np.zeros(np.shape(exposure_hdu.data)) 
    mask[exposure_hdu.data == 0] = 1
    mask_hdu.data = mask

    nebfilt_map_name = filename.replace(".fits", "_nebfiltered.fits")
    nebfilt_map = fits.open(
        f"../dmu19_nebular_filtered_maps/data/AKARI-NEP_{nebfilt_map_name}")
    nebfilt_hdu = fits.ImageHDU(header=nebfilt_map[0].header,
                                data=nebfilt_map[0].data)
    nebfilt_hdu.header['EXTNAME'] = "NEBFILT"
    nebfilt_hdu.header['BUNIT'] = "Jy / beam"

    image_hdu.data -= np.nanmean(image_hdu.data) 
    good_filter = np.abs(image_hdu.data - nebfilt_hdu.data) < 0.1 # smaller thatn 100mJy difference
    nebfilt_hdu.data -= np.nanmean(nebfilt_hdu.data[good_filter])  # Background substration neb
    nebfilt_hdu.data[~good_filter] = np.nan
    if get_band(filename) == "250": ind = 0 
    if get_band(filename) == "350": ind = 1 
    if get_band(filename) == "500": ind = 2


    use_for_mf_noise =  error_hdu.data < np.sqrt(2)*np.nanmedian(error_hdu.data)
    noise = np.median(error_hdu.data[use_for_mf_noise])

    if 'CD2_2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CD2_2'] * 3600. - pixsize[ind]) 
    elif 'CDELT2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CDELT2'] * 3600. - pixsize[ind]) 
    if delt_pix > 0.01:
        print('pix_size_wrong')
        exit()    

    mf, psf = MF.matched_filter(fwhm[ind], pixsize[ind], nconf[ind], noise, whitenoise=True, image=False, psf_only=False, normalize=False)
    image_to_convolve = 1.0*nebfilt_hdu.data
    error_to_convolve = 1.0*error_hdu.data
    conv_map, conv_noise, matchedfilter = MF.do_filtering(image_to_convolve, error_to_convolve, mf , psf)


    mf_hdu = fits.ImageHDU(header=nebfilt_hdu.header,
                                data=conv_map)
    mf_hdu.header['EXTNAME'] = "MFILT"
    mf_hdu.header['BUNIT'] = "Jy / beam"
    mf_error_hdu = fits.ImageHDU(header=error_hdu.header,
                                data=conv_noise)
    mf_error_hdu.header['EXTNAME'] = "MFILT_ERROR"
    mf_error_hdu.header['BUNIT'] = "Jy / beam"

    filter_hdu = fits.PrimaryHDU()
    filter_hdu.header.append(("EXTNAME", "Matchedfilter"))
    filter_hdu.header.append(("FWHM", fwhm[ind], "FWHM of PSF in NEBFILT map"))
    filter_hdu.header.append(("nconf", nconf[ind], "confusion noise, Jy/beam"))
    filter_hdu.header.append(("nins", noise, "instrumental noise, Jy/beam"))
    filter_hdu.header.append(("pixsize", pixsize[ind], "pixel size, arcsec"))

    filter_hdu = fits.ImageHDU(header=filter_hdu.header,
                                data=matchedfilter)

    primary_hdu = fits.PrimaryHDU()
    primary_hdu.header.append((
        "CREATOR", "Herschel Extragalactic Legacy Project"
    ))
    primary_hdu.header.append((
        "TIMESYS", "UTC", "All dates are in UTC time"
    ))
    primary_hdu.header.append((
        "DATE", datetime.now().replace(microsecond=0).isoformat(),
        "Date of file creation"
    ))
    primary_hdu.header.append((
        "VERSION", VERSION, "HELP product version"
    ))
    primary_hdu.header.append((
        "TELESCOP", "Herschel", "Name of the telescope"
    ))
    primary_hdu.header.append((
        "INSTRUME", "SPIRE", "Name of the instrument"
    ))
    primary_hdu.header.append((
        "FILTER", f"SPIRE-{get_band(filename)}", "Name of the filter"
    ))
    primary_hdu.header.append((
        "FIELD", field, "Name of the HELP field"
    ))
    for idx, obs_id in enumerate(obsids):
        keyword = "OBSID" + str(idx).zfill(3)
        primary_hdu.header.append((keyword, obs_id))

    hdu_list = fits.HDUList([primary_hdu, image_hdu, nebfilt_hdu, error_hdu,
                             exposure_hdu, mask_hdu,mf_hdu,mf_error_hdu,filter_hdu])

    hdu_list.writeto(f"data_HELP_v1.0/{field}_SPIRE{get_band(filename)}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {get_band(filename)} processed...")
    print(fwhm[ind], pixsize[ind], nconf[ind], noise)
    hdu_list.close()
# SPIRE-NEP
spirenep_maps = spire_maps[spire_maps['survey'] == "SPIRE-NEP"]
pixsize = np.array([6., 10., 14.])
for row in spirenep_maps:
    field = row['field']
    filename = row['filename']

    obsids = sorted(list(all_obsids['ObsID'][all_obsids['field'] == field]))
    assert len(obsids) > 0

    orig_hdu_list = fits.open(
        f"../dmu19_SPIRE-NEP-calibration/data/{filename}")

    image_hdu = orig_hdu_list[1]
    assert image_hdu.header['EXTNAME'] == "image"
    image_hdu.header['EXTNAME'] = "IMAGE"
    image_hdu.header['BUNIT'] = "Jy / beam"

    mask_hdu = orig_hdu_list[2]
    assert mask_hdu.header['EXTNAME'] == "flag"
    mask_hdu.header['EXTNAME'] = "MASK"

    # The maps contain the coverage and where observed in normal mode.
    exposure_hdu = orig_hdu_list[3]
    assert exposure_hdu.header['EXTNAME'] == "coverage"
    exposure_hdu.data *= 1 / 18.6  # Conversion of coverage to exposure
    exposure_hdu.header['EXTNAME'] = "EXPOSURE"
    exposure_hdu.header['BUNIT'] = "s"
    exposure_hdu.header['QTTY____'] = "s"

    error_hdu = orig_hdu_list[4]
    assert error_hdu.header['EXTNAME'] == "error"
    error_hdu.header['EXTNAME'] = "ERROR"
    error_hdu.header['BUNIT'] = "Jy / beam"

    nebfilt_map_name = filename.replace(".fits", "_nebfiltered.fits")
    nebfilt_map = fits.open(
        f"../dmu19_nebular_filtered_maps/data/SPIRE-NEP_{nebfilt_map_name}")
    nebfilt_hdu = fits.ImageHDU(header=nebfilt_map[0].header,
                                data=nebfilt_map[0].data)
    nebfilt_hdu.header['EXTNAME'] = "NEBFILT"
    nebfilt_hdu.header['BUNIT'] = "Jy / beam"

    image_hdu.data -= np.nanmean(image_hdu.data) 
    good_filter = np.abs(image_hdu.data - nebfilt_hdu.data) < 0.1 # smaller thatn 100mJy difference
    nebfilt_hdu.data -= np.nanmean(nebfilt_hdu.data[good_filter])  # Background substration neb
    nebfilt_hdu.data[~good_filter] = np.nan
    if get_band(filename) == "250": ind = 0 
    if get_band(filename) == "350": ind = 1 
    if get_band(filename) == "500": ind = 2


    use_for_mf_noise =  error_hdu.data < np.sqrt(2)*np.nanmedian(error_hdu.data)
    noise = np.median(error_hdu.data[use_for_mf_noise])

    if 'CD2_2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CD2_2'] * 3600. - pixsize[ind]) 
    elif 'CDELT2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CDELT2'] * 3600. - pixsize[ind]) 
    if delt_pix > 0.01:
        print('pix_size_wrong')
        exit()    

    mf, psf = MF.matched_filter(fwhm[ind], pixsize[ind], nconf[ind], noise, whitenoise=True, image=False, psf_only=False, normalize=False)
    image_to_convolve = 1.0*nebfilt_hdu.data
    error_to_convolve = 1.0*error_hdu.data
    conv_map, conv_noise, matchedfilter = MF.do_filtering(image_to_convolve, error_to_convolve, mf , psf)


    mf_hdu = fits.ImageHDU(header=nebfilt_hdu.header,
                                data=conv_map)
    mf_hdu.header['EXTNAME'] = "MFILT"
    mf_hdu.header['BUNIT'] = "Jy / beam"
    mf_error_hdu = fits.ImageHDU(header=error_hdu.header,
                                data=conv_noise)
    mf_error_hdu.header['EXTNAME'] = "MFILT_ERROR"
    mf_error_hdu.header['BUNIT'] = "Jy / beam"

    filter_hdu = fits.PrimaryHDU()
    filter_hdu.header.append(("EXTNAME", "Matchedfilter"))
    filter_hdu.header.append(("FWHM", fwhm[ind], "FWHM of PSF in NEBFILT map"))
    filter_hdu.header.append(("nconf", nconf[ind], "confusion noise, Jy/beam"))
    filter_hdu.header.append(("nins", noise, "instrumental noise, Jy/beam"))
    filter_hdu.header.append(("pixsize", pixsize[ind], "pixel size, arcsec"))

    filter_hdu = fits.ImageHDU(header=filter_hdu.header,
                                data=matchedfilter)


    primary_hdu = fits.PrimaryHDU()
    primary_hdu.header.append((
        "CREATOR", "Herschel Extragalactic Legacy Project"
    ))
    primary_hdu.header.append((
        "TIMESYS", "UTC", "All dates are in UTC time"
    ))
    primary_hdu.header.append((
        "DATE", datetime.now().replace(microsecond=0).isoformat(),
        "Date of file creation"
    ))
    primary_hdu.header.append((
        "VERSION", VERSION, "HELP product version"
    ))
    primary_hdu.header.append((
        "TELESCOP", "Herschel", "Name of the telescope"
    ))
    primary_hdu.header.append((
        "INSTRUME", "SPIRE", "Name of the instrument"
    ))
    primary_hdu.header.append((
        "FILTER", f"SPIRE-{get_band(filename)}", "Name of the filter"
    ))
    primary_hdu.header.append((
        "FIELD", field, "Name of the HELP field"
    ))
    for idx, obs_id in enumerate(obsids):
        keyword = "OBSID" + str(idx).zfill(3)
        primary_hdu.header.append((keyword, obs_id))

    hdu_list = fits.HDUList([primary_hdu, image_hdu, nebfilt_hdu, error_hdu,
                             exposure_hdu, mask_hdu,mf_hdu,mf_error_hdu,filter_hdu])
    hdu_list.writeto(f"data_HELP_v1.0/{field}_SPIRE{get_band(filename)}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {get_band(filename)} processed...")
    print(fwhm[ind], pixsize[ind], nconf[ind], noise)
    hdu_list.close()

# H-ATLAS

hatlas_field_basenames = {
    "GAMA-09": "HATLAS_GAMA9_DR1_",
    "GAMA-12": "HATLAS_GAMA12_DR1_",
    "GAMA-15": "HATLAS_GAMA15_DR1_",
    "HATLAS-NGP": "HATLAS_NGP_DR2_",
    "HATLAS-SGP": "HATLAS_SGP_DR2_",
}




hatlas_coverage_maps = {
    "GAMA-12_500": "GAMA12-PLWmap-mosaic-20141007_coverage.fits",
    "GAMA-12_350": "GAMA12-PMWmap-mosaic-20141007_coverage.fits",
    "GAMA-12_250": "GAMA12-PSWmap-mosaic-20141007_coverage.fits",
    "GAMA-15_500": "GAMA15-PLWmap-mosaic-20130218_coverage.fits",
    "GAMA-15_350": "GAMA15-PMWmap-mosaic-20130218_coverage.fits",
    "GAMA-15_250": "GAMA15-PSWmap-mosaic-20130218_coverage.fits",
    "GAMA-09_500": "GAMA9-PLWmap-mosaic-20130218_coverage.fits",
    "GAMA-09_350": "GAMA9-PMWmap-mosaic-20130218_coverage.fits",
    "GAMA-09_250": "GAMA9-PSWmap-mosaic-20130218_coverage.fits",
    "HATLAS-NGP_500": "NGP-PLWmap-mosaic_MS-20131121-full_coverage.fits",
    "HATLAS-NGP_350": "NGP-PMWmap-mosaic_MS-20131121-full_coverage.fits",
    "HATLAS-NGP_250": "NGP-PSWmap-mosaic_MS-20131121-full_coverage.fits",
    "HATLAS-SGP_500": "SGP-PLWmap-mosaic_MS-full_coverage.fits",
    "HATLAS-SGP_350": "SGP-PMWmap-mosaic_MS-full_coverage.fits",
    "HATLAS-SGP_250": "SGP-PSWmap-mosaic_MS-full_coverage.fits",
}


pixsize = np.array([6., 8., 12.])

for field, band in product(hatlas_field_basenames, ["250", "350", "500"]):
    basename = hatlas_field_basenames[field]


    obsids = sorted(list(all_obsids['ObsID'][all_obsids['field'] == field]))
    assert len(obsids) > 0

    image_map = fits.open(f"../dmu19_HATLAS/data/{basename}RAW{band}.FITS")

    image_hdu = fits.ImageHDU(header=image_map[0].header,
                              data=image_map[0].data)
    image_hdu.header['EXTNAME'] = "IMAGE"
    image_hdu.header['BUNIT'] = "Jy / beam"

    mask_map = fits.open(f"../dmu19_HATLAS/data/{basename}MASK{band}.FITS")
    mask_hdu = fits.ImageHDU(header=mask_map[0].header,
                             data=mask_map[0].data)
    # H-ATLAS mask is 0 for bad and 1 for good while we use the reverse for
    # HELP
    good_mask = mask_hdu.data == 1
    bad_mask = mask_hdu.data == 0
    mask_hdu.data[good_mask] = 0
    mask_hdu.data[bad_mask] = 1
    mask_hdu.header['EXTNAME'] = "MASK"

    # The maps contain the coverage and where observed in parallel mode.
    coverage_map_name = hatlas_coverage_maps[f"{field}_{band}"]
    exposure_map = fits.open(
        f"../dmu19_HATLAS/data/coverages/{coverage_map_name}")
    exposure_hdu = exposure_map[1]
    assert exposure_hdu.header['EXTNAME'] == "coverage"
    exposure_hdu.data *= 1 / 10.  # Conversion of coverage to exposure
    exposure_hdu.header['EXTNAME'] = "EXPOSURE"
    exposure_hdu.header['BUNIT'] = "s"
    exposure_hdu.header['QTTY____'] = "s"

    error_map = fits.open(f"../dmu19_HATLAS/data/{basename}SIGMA{band}.FITS")
    error_hdu = fits.ImageHDU(header=error_map[0].header,
                              data=error_map[0].data)
    error_hdu.header['EXTNAME'] = "ERROR"
    error_hdu.header['BUNIT'] = "Jy / beam"

    nebfilt_map = fits.open(f"../dmu19_HATLAS/data/{basename}BACKSUB{band}.FITS")
    nebfilt_hdu = fits.ImageHDU(header=nebfilt_map[0].header,
                                data=nebfilt_map[0].data)
    nebfilt_hdu.header['EXTNAME'] = "NEBFILT"
    nebfilt_hdu.header['BUNIT'] = "Jy / beam"
    
    image_hdu.data[bad_mask] = np.nan
    nebfilt_hdu.data[bad_mask] = np.nan
    error_hdu.data[bad_mask] = np.nan

    image_hdu.data -= np.nanmean(image_hdu.data)  # Background substration
    good_filter = np.abs(image_hdu.data - nebfilt_hdu.data) < 0.1 # smaller thatn 100mJy difference
    nebfilt_hdu.data -= np.nanmean(nebfilt_hdu.data[good_filter])  # Background substration neb
    nebfilt_hdu.data[~good_filter] = np.nan


    if get_band(f"{band}") == "250": ind = 0 
    if get_band(f"{band}") == "350": ind = 1 
    if get_band(f"{band}") == "500": ind = 2


    use_for_mf_noise =  error_hdu.data < np.sqrt(2)*np.nanmedian(error_hdu.data)
    noise = np.median(error_hdu.data[use_for_mf_noise])

    if 'CD2_2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CD2_2'] * 3600. - pixsize[ind]) 
    elif 'CDELT2' in image_hdu.header:
        delt_pix = np.abs(image_hdu.header['CDELT2'] * 3600. - pixsize[ind]) 
    if delt_pix > 0.01:
        print('pix_size_wrong', image_hdu.header['CDELT2'] * 3600.)
        exit()    

    mf, psf = MF.matched_filter(fwhm[ind], pixsize[ind], nconf[ind], noise, whitenoise=True, image=False, psf_only=False, normalize=False)
    image_to_convolve = 1.0*nebfilt_hdu.data
    error_to_convolve = 1.0*error_hdu.data
    conv_map, conv_noise, matchedfilter = MF.do_filtering(image_to_convolve, error_to_convolve, mf , psf)


    mf_hdu = fits.ImageHDU(header=nebfilt_hdu.header,
                                data=conv_map)
    mf_hdu.header['EXTNAME'] = "MFILT"
    mf_hdu.header['BUNIT'] = "Jy / beam"
    mf_error_hdu = fits.ImageHDU(header=error_hdu.header,
                                data=conv_noise)
    mf_error_hdu.header['EXTNAME'] = "MFILT_ERROR"
    mf_error_hdu.header['BUNIT'] = "Jy / beam"

    filter_hdu = fits.PrimaryHDU()
    filter_hdu.header.append(("EXTNAME", "Matchedfilter"))
    filter_hdu.header.append(("FWHM", fwhm[ind], "FWHM of PSF in NEBFILT map"))
    filter_hdu.header.append(("nconf", nconf[ind], "confusion noise, Jy/beam"))
    filter_hdu.header.append(("nins", noise, "instrumental noise, Jy/beam"))
    filter_hdu.header.append(("pixsize", pixsize[ind], "pixel size, arcsec"))

    filter_hdu = fits.ImageHDU(header=filter_hdu.header,
                                data=matchedfilter)

    primary_hdu = fits.PrimaryHDU()
    primary_hdu.header.append((
        "CREATOR", "Herschel Extragalactic Legacy Project"
    ))
    primary_hdu.header.append((
        "TIMESYS", "UTC", "All dates are in UTC time"
    ))
    primary_hdu.header.append((
        "DATE", datetime.now().replace(microsecond=0).isoformat(),
        "Date of file creation"
    ))
    primary_hdu.header.append((
        "VERSION", VERSION, "HELP product version"
    ))
    primary_hdu.header.append((
        "TELESCOP", "Herschel", "Name of the telescope"
    ))
    primary_hdu.header.append((
        "INSTRUME", "SPIRE", "Name of the instrument"
    ))
    primary_hdu.header.append((
        "FILTER", f"SPIRE-{band}", "Name of the filter"
    ))
    primary_hdu.header.append((
        "FIELD", field, "Name of the HELP field"
    ))
    for idx, obs_id in enumerate(obsids):
        keyword = "OBSID" + str(idx).zfill(3)
        primary_hdu.header.append((keyword, obs_id))

    hdu_list = fits.HDUList([primary_hdu, image_hdu, nebfilt_hdu, error_hdu,
                             exposure_hdu, mask_hdu,mf_hdu,mf_error_hdu,filter_hdu])
    hdu_list.writeto(f"data_HELP_v1.0/{field}_SPIRE{band}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {band} processed...")
    print(fwhm[ind], pixsize[ind], nconf[ind], noise)
    hdu_list.close()
