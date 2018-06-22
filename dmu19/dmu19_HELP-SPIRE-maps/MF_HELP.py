from matplotlib import pyplot as plt

from astropy.io import fits
import numpy as np
from scipy import signal
import os
from scipy import fftpack

def matched_filter(fwhm, pixsize, nconf, noise, whitenoise=False, image=False, psf_only=False, normalize=False):

    ny, nx = (101,101)      

    #first create an oversampled psf, we want: pixsize/oversamp~1arcsec
    oversamp = int(round(pixsize))
    #oversamp factor needs to be an odd integer, for the psf to remain centered
    oversamp += (oversamp+1) %2  
    ###oversamp = 9
    
    gen_nx = nx * oversamp
    gen_ny = ny * oversamp
    gen_pixsize = pixsize/oversamp
    
    ry = int(gen_ny/2)
    rx = int(gen_nx/2)
    x = np.linspace(-rx, rx, gen_nx)
    y = np.linspace(-ry, ry, gen_ny)
    x,y = np.meshgrid(x, y) 
    
    gen_sig = (fwhm / (8.*np.log(2))**0.5)/gen_pixsize
   
    psf = (1./(2*np.pi*gen_sig**2))*np.exp( - (x**2.+y**2.) / (2*gen_sig**2))
    psf = psf/psf.max()
    #resbin the psf to the actual pixel size:

    psf = psf.reshape((ny, int(gen_ny/ny), nx, int(gen_nx/nx))).mean(3).mean(1)
    #psf = psf/psf.max() # wrong

    
    #if psf_only keyword is given, break and return the psf:
    if psf_only:
        return psf
    
    if whitenoise:   
        ninstr = noise
    else:                 
        #calculate ninstr:
        ny_map,nx_map = noise.shape
        weightmap = 1./noise**2.
        centralx = int(np.round(nx_map*0.1))
        centraly = int(np.round(ny_map*0.1))
        meanweight = np.nanmean(weightmap[ny_map/2-centraly:ny_map/2+centraly, nx_map/2-centralx:nx_map/2+centralx])
        ninstr = (1. / meanweight)**0.5


         
        
   
    #create the matched filter:
    #instrument noise level in Fourier space    
    ps_ninstr = nx*ny*ninstr**2.     
    #confusion noise power spectrum
    fft_psf = fftpack.fft2(psf)
    ps_psf = np.abs(fft_psf)**2.
    scale_confusion = nconf/np.std(psf)
    ps_nconf = scale_confusion**2.*ps_psf    
    ps_noise = ps_ninstr+ps_nconf    
    fft_mfilt = fft_psf/ps_noise
    matchedfilt = fftpack.ifft2(fft_mfilt)

    matchedfilt = matchedfilt.real

    matchedfilt_norm = (matchedfilt/np.sum(psf*matchedfilt))

    if normalize:
        return matchedfilt_norm
    return (matchedfilt, psf)


def  do_filtering(image, noisemap, matchedfilter , psf):


    nanvalues = np.isnan(noisemap)  |  np.isnan(image)
    image[nanvalues] = 0.

    max_e = np.nanmax(noisemap)
    noisemap[nanvalues]=100.*max_e
    weightmap = 1./noisemap**2.

    norm = np.sum(psf*matchedfilter)/np.sum(matchedfilter**2.)
    matchedfilter = norm * matchedfilter


    print( 'max filt', np.max(matchedfilter), np.max(psf))
    conv_image = signal.fftconvolve(image*weightmap,matchedfilter,mode='same')
    conv_noise = signal.fftconvolve(weightmap,matchedfilter**2.,mode='same')
    conv_image = conv_image/conv_noise
    conv_noise = (1./(conv_noise**0.5))

    conv_image[nanvalues] = np.nan
    conv_noise[nanvalues] = np.nan

    conv_image -= np.nanmean(conv_image)  #meansubtraction, ignore, NaN pixels:
    return (conv_image, conv_noise, matchedfilter )




