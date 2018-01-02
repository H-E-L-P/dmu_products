# Script to run nebuliser on HELP SPIRE maps adapted from Matt Smith script.

import astropy.io.fits as pyfits
import astropy.wcs as pywcs
import numpy as np
import os
from os.path import join as pj
from glob import glob


# Extension containing the maps to process
extension = 1

# Extract just required extension
extractExt = True

# Nebular parameters for each band.
# medFilt: the scale that is removed (in arcsec)
# linFilt: a value half medFilt worked well,  but for SPIRE ATLAS sent this to
# medFilt value.
# twod: technically better, but takes a lot longer, ATLAS didn't do this
# cirrusMap: Do you want to save a map of the cirrus emission
nebParamDict = {
    "250": {"medFilt": 180, "linFilt": 180, "twod": False, "cirrusMap": False},
    "350": {"medFilt": 240, "linFilt": 240, "twod": False, "cirrusMap": False},
    "500": {"medFilt": 360, "linFilt": 360, "twod": False, "cirrusMap": False},
}


# Directory where the nebuliser execulable is located if not in the path
pathInfo = None

# Directory where to to be processed maps are
#folder = "/research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_HerMES/data/"

# Destination directory to put the maps in
destdir = "/research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_nebular_filtered_maps/data/"

###############################################################################


def nebulising(folder, fitsFile, ext, nebPath, nebParam, extractExt):

    # switch fits file
    os.chdir(folder)

    # load fits files
    fits = pyfits.open(fitsFile)
    data = fits[ext].data
    header = fits[ext].header
    wcs = pywcs.WCS(header)

    if extractExt:
        makeMap(data, header, fitsFile[:-5]+"-sig.fits", folder)
    fitsFile = fitsFile[:-5]+"-sig.fits"

    # Mask file (1 where there is data, 0 otherwise)
    mask = (~np.isnan(data)).astype(int)

    # get pixel size
    pixSize = pywcs.utils.proj_plane_pixel_scales(wcs)[0]*3600.0

    # create mask fits map
    makeMap(mask, header, "nebMask-"+fitsFile, folder)

    # Add path to nebuliser to PATH if needed
    if nebPath is not None:
        os.environ["PATH"] = nebPath + ":" + os.environ["PATH"]

    command = ("nebuliser " + fitsFile + " " + "nebMask-"+fitsFile +
               " " + destdir + fitsFile[:-9] + "_nebfiltered.fits " +
               str(int(np.round(nebParam["medFilt"]) / pixSize)) + " " +
               str(int(np.round(nebParam["linFilt"] / pixSize))))
    if nebParam["twod"]:
        command = command + " --twod"
    if nebParam["cirrusMap"]:
        command = command + " --backmap=back-" + fitsFile
    os.system(command)

    fits.close()

    # remove mask
    os.remove(pj(folder, "nebMask-"+fitsFile))
    # remove extracted extension
    if extractExt:
        os.remove(pj(folder, fitsFile))


def makeMap(slice, header, outName, folder):
    # Create header object
    hdu = pyfits.PrimaryHDU(slice)
    hdulist = pyfits.HDUList([hdu])
    hdu.header.set('EQUINOX', 2000.0)
    hdu.header.set('CTYPE1', header["CTYPE1"])
    hdu.header.set('CTYPE2', header["CTYPE2"])
    hdu.header.set('CRPIX1', header["CRPIX1"])
    hdu.header.set('CRPIX2', header["CRPIX2"])
    hdu.header.set('CRVAL1', header["CRVAL1"])
    hdu.header.set('CRVAL2', header["CRVAL2"])
    try:
        hdu.header.set('CDELT1', header["CDELT1"])
        hdu.header.set('CDELT2', header["CDELT2"])
    except:
        hdu.header.set('CD1_1', header["CD1_1"])
        hdu.header.set('CD2_1', header["CD2_1"])
        hdu.header.set('CD1_2', header["CD1_2"])
        hdu.header.set('CD2_2', header["CD2_2"])
    try:
        hdu.header.set('LONPOLE', header["LONPOLE"])
        hdu.header.set('LATPOLE', header["LATPOLE"])
    except:
        pass
    if "TELESCOP" in header:
        hdu.header.set("TELESCOP", header["TELESCOP"])
    if "INSTRUME" in header:
        hdu.header.set("INSTRUME", header["INSTRUME"])
    if "FILTER" in header:
        hdu.header.set("FILTER", header["FILTER"])
    if "VSCAN" in header:
        hdu.header.set("VSCAN", header["VSCAN"])
    if "BUNIT" in header:
        hdu.header.set("BUNIT", header["BUNIT"])
    # get the list of obsids
    keys = [key for key in header.keys() if key.count("OBSID") > 0]
    keys.sort()
    for key in keys:
        hdu.header.set(key, header[key])
    hdu.header.set('COMMENT', "Created by M.Smith - Cardiff University")
    hdulist.writeto(pj(folder, outName))
    hdulist.close()

###############################################################################

# HerMES maps #################################################################
folder = "/research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_HerMES/data/"

for f in glob("{}*.fits".format(folder)):
    filename = f.split("/")[-1]
    print("Processing {}...".format(filename))
    if "250" in filename or "PSW" in filename:
        nebParam = nebParamDict['250']
    elif "350" in filename or "PMW" in filename:
        nebParam = nebParamDict['350']
    elif "500" in filename or "PLW" in filename:
        nebParam = nebParamDict['500']
    else:
        raise StandardError("Unknown band")

    nebulising(folder, filename, extension, pathInfo, nebParam, extractExt)

# AKARI-NEP maps ###############################################################
folder = "/research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_AKARI-NEP/data/"

for f in glob("{}/*.fits".format(folder)):
    filename = f.split("/")[-1]
    print("Processing {}...".format(filename))
    if "250" in filename or "PSW" in filename:
        nebParam = nebParamDict['250']
    elif "350" in filename or "PMW" in filename:
        nebParam = nebParamDict['350']
    elif "500" in filename or "PLW" in filename:
        nebParam = nebParamDict['500']
    else:
        raise StandardError("Unknown band")

    nebulising(folder, filename, extension, pathInfo, nebParam, extractExt)

# Renaming the maps
for f in glob("{}mapCombined*.fits".format(destdir)):
    os.rename(f, f.replace("mapCombined", "AKARI-NEP_mapCombined"))

# SPIRE-NEP maps ###############################################################
folder = "/research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_SPIRE-NEP-calibration/data/"

for f in glob("{}/*.fits".format(folder)):
    filename = f.split("/")[-1]
    print("Processing {}...".format(filename))
    if "250" in filename or "PSW" in filename:
        nebParam = nebParamDict['250']
    elif "350" in filename or "PMW" in filename:
        nebParam = nebParamDict['350']
    elif "500" in filename or "PLW" in filename:
        nebParam = nebParamDict['500']
    else:
        raise StandardError("Unknown band")

    nebulising(folder, filename, extension, pathInfo, nebParam, extractExt)

# Renaming the maps
for f in glob("{}SPIREcal*.fits".format(destdir)):
    os.rename(f, f.replace("SPIREcal", "SPIRE-NEP_SPIREcal"))

print("Finished successfully")

###############################################################################
