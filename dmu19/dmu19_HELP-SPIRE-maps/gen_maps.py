"""Script to generate the HELP homogenised SPIRE maps."""

from datetime import datetime
from itertools import product

import numpy as np

from astropy.io import fits
from astropy.table import Table

VERSION = "0.9"

spire_maps = Table.read("spire_maps.fits")
all_obsids = Table.read("spire_obsids.fits")


def get_band(filename):
    if "250" in filename or "psw" in filename.lower():
        return "250"
    if "350" in filename or "pmw" in filename.lower():
        return "350"
    if "500" in filename or "plw" in filename.lower():
        return "500"
    raise ValueError(f"Can't identify the band in '{filename}'.")


# HerMES
hermes_maps = spire_maps[spire_maps['survey'] == "HerMES"]

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

    error_hdu = orig_hdu_list[2]
    assert error_hdu.header['EXTNAME'] == "error"
    error_hdu.header['EXTNAME'] = "ERROR"
    error_hdu.header['BUNIT'] = "Jy / beam"

    exposure_hdu = orig_hdu_list[3]
    assert exposure_hdu.header['EXTNAME'] == "exposure"
    exposure_hdu.header['EXTNAME'] = "EXPOSURE"
    exposure_hdu.header['BUNIT'] = "s"

    mask_hdu = orig_hdu_list[4]
    assert mask_hdu.header['EXTNAME'] == "flag"
    mask_hdu.header['EXTNAME'] = "MASK"

    nebfilt_map_name = filename.replace(".fits", "_nebfiltered.fits")
    nebfilt_map = fits.open(
        f"../dmu19_nebular_filtered_maps/data/{nebfilt_map_name}")
    nebfilt_hdu = fits.ImageHDU(header=nebfilt_map[0].header,
                                data=nebfilt_map[0].data)
    nebfilt_hdu.header['EXTNAME'] = "NEBFILT"
    nebfilt_hdu.header['BUNIT'] = "Jy / beam"

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
                             exposure_hdu, mask_hdu])
    hdu_list.writeto(f"data/{field}_SPIRE{get_band(filename)}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {get_band(filename)} processed...")

# AKARI-NEP
akarinep_maps = spire_maps[spire_maps['survey'] == "AKARI-NEP"]

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
    mask_hdu.header.add_comment("The mask map is not available.")

    nebfilt_map_name = filename.replace(".fits", "_nebfiltered.fits")
    nebfilt_map = fits.open(
        f"../dmu19_nebular_filtered_maps/data/AKARI-NEP_{nebfilt_map_name}")
    nebfilt_hdu = fits.ImageHDU(header=nebfilt_map[0].header,
                                data=nebfilt_map[0].data)
    nebfilt_hdu.header['EXTNAME'] = "NEBFILT"
    nebfilt_hdu.header['BUNIT'] = "Jy / beam"

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
                             exposure_hdu, mask_hdu])
    hdu_list.writeto(f"data/{field}_SPIRE{get_band(filename)}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {get_band(filename)} processed...")

# SPIRE-NEP
spirenep_maps = spire_maps[spire_maps['survey'] == "SPIRE-NEP"]

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
                             exposure_hdu, mask_hdu])
    hdu_list.writeto(f"data/{field}_SPIRE{get_band(filename)}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {get_band(filename)} processed...")

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
    "HATLAS_SGP_500": "SGP-PLWmap-mosaic_MS-full_coverage.fits",
    "HATLAS_SGP_350": "SGP-PMWmap-mosaic_MS-full_coverage.fits",
    "HATLAS_SGP_250": "SGP-PSWmap-mosaic_MS-full_coverage.fits",
}

for field, band in product(hatlas_field_basenames, ["250", "350", "500"]):
    basename = hatlas_field_basenames[field]

    obsids = sorted(list(all_obsids['ObsID'][all_obsids['field'] == field]))
    assert len(obsids) > 0

    image_map = fits.open(f"../dmu19_HATLAS/data/{basename}RAW{band}.FITS")
    image_hdu = fits.ImageHDU(header=image_map[0].header,
                              data=image_map[0].data)
    image_hdu.data -= np.nanmean(image_hdu.data)  # Background substration
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
                             exposure_hdu, mask_hdu])
    hdu_list.writeto(f"data/{field}_SPIRE{band}_v{VERSION}.fits",
                     checksum=True)
    print(f"{field} / {band} processed...")
