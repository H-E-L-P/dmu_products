import numpy as np
from astropy.io import fits
import os
from matplotlib import path
from astropy.wcs import WCS
from scipy import fftpack
from scipy import signal
np.set_printoptions(formatter={'float': lambda x: "{0:0.3f}".format(x)})

def find_peak(hdulist, dmin, negmap = 'FALSE'):
    map = hdulist["MFILT"].data
    mask = hdulist["MASK"].data

    #map = hdulist["NEBFILT"].data

    emap = hdulist["MFILT_ERROR"].data
    if negmap == 'TRUE':
        map = -1.0*map
        map = map-np.nanmedian(map)
    
    map[np.isnan(map)] = 0.
    #map[map < dmin] = 0.  #to speed up the sort, ignore pixels which are smaller than the d limit
    
   
    w = WCS(hdulist["MFILT"].header)
    
    y, x = np.indices(map.shape)
    y_max,x_max = np.max(y), np.max(x)

 
        
    #flatten 2d arrays 
    dflat = map.ravel()
    eflat = emap.ravel()
    yflat = y.ravel()
    xflat = x.ravel()
    #sort all the values in descending order:
    wmax = np.argsort(dflat)[::-1]
    sortedval = dflat[wmax]
    sorteeval = eflat[wmax]
    sortedx = xflat[wmax]
    sortedy = yflat[wmax]
    xp = []
    yp = []
    dp = []
    ep = []
    rap = []
    decp = []
    
    i=0
    while (sortedval[i] > dmin):
        #select neighbouring pixels (i.e. 3 by 3) around pixel of interest for both map and mask
        minimap = map[sortedy[i]-1:sortedy[i]+2, sortedx[i]-1:sortedx[i]+2]
        mask_map = mask[sortedy[i]-1:sortedy[i]+2, sortedx[i]-1:sortedx[i]+2]
        #indices where map is nonzero
        good = minimap != 0
        #set pixels to zero close to edge of map (i.e. 7 pixels)
        if  (sortedy[i] <= 7) or (sortedx[i] <= 7) or (sortedy[i] >= y_max-7) or (sortedx[i] >= x_max-7) :
            minimap = 0

        # if pixel of interest is max for the 3 by 3 minimap and 8 out of 9 pixels are not zero and 2 or less pixels are masked.
        if (sortedval[i] == np.max(minimap)) and (np.size(minimap[good]) >=8) and (np.sum(mask_map) <=2) :

            dp.append(sortedval[i])
            ep.append(sorteeval[i])
            yp.append(sortedy[i])
            xp.append(sortedx[i])
            ra, dec = w.wcs_pix2world(sortedx[i],sortedy[i],0)


            rap.append(ra)
            decp.append(dec)


        i = i+1        
        
    hdulist.close()
    return (dp, ep, rap, decp, xp, yp)


def generate_pixelized_psf(fwhm,pixsize,xc=0,yc=0):
    
    '''
    psf = generate_pixelized_psf(fwhm,pixsize,xc=0,yc=0)
    '''
    
    sig = fwhm / (8.*np.log(2))**0.5
    sig = sig / pixsize
    npix = int(5.*(fwhm/pixsize))
    npix += (npix + 1 ) % 2

    npix = 11 #######
    oversamp = 9
    gen_xc = xc * oversamp
    gen_yc = yc * oversamp        
    gen_npix = npix * oversamp
    gen_pixsize = float(pixsize)/oversamp
    gen_sig = (fwhm / (8.*np.log(2))**0.5)/gen_pixsize
    r = int(gen_npix/2)
    x = np.linspace(-r, r, gen_npix)
    y = np.linspace(-r, r, gen_npix)
    x,y = np.meshgrid(x, y)
    psf = (1./(2*np.pi*gen_sig**2))*np.exp( - ((x-gen_xc)**2.+(y-gen_yc)**2.) / (2*gen_sig**2))
    psf=psf/psf.max()  
    psf_px = psf.reshape((npix, int(gen_npix/npix), npix, int(gen_npix/npix))).mean(3).mean(1)

    return psf_px

def generate_pixelized_matched_filter(fwhm, pixsize, nconf, ninstr, xc=0,yc=0, mf_only = False):
    
    #ny, nx = (15,15)      
    ny, nx = (11,11)      
    
    oversamp = 9
    
    gen_nx = nx * oversamp
    gen_ny = ny * oversamp
    gen_pixsize = pixsize/oversamp
    
    gen_xc = xc * oversamp
    gen_yc = yc * oversamp

    
    ry = int(gen_ny/2)
    rx = int(gen_nx/2)

    x = np.linspace(-rx, rx, gen_nx)
    y = np.linspace(-ry, ry, gen_ny)
    x,y = np.meshgrid(x, y) 
    
    gen_sig = (fwhm / (8.*np.log(2))**0.5)/gen_pixsize
   
    psf = (1./(2*np.pi*gen_sig**2))*np.exp( - ((x-gen_xc)**2.+(y-gen_yc)**2.) / (2*gen_sig**2))
    psf = psf/psf.max()

    gen_ninstr = oversamp * ninstr
   
        
    #create the matched filter:
    #instrument noise level in Fourier space    
    ps_ninstr = gen_nx*gen_ny*gen_ninstr**2.     
    #confusion noise power spectrum
    fft_psf = fftpack.fft2(psf)
    ps_psf = np.abs(fft_psf)**2.
    scale_confusion = nconf/np.std(psf)
    ps_nconf = scale_confusion**2.*ps_psf    
    ps_noise = ps_ninstr+ps_nconf
    fft_mfilt = fft_psf/ps_noise
    matchedfilt = fftpack.ifft2(fft_mfilt)
    matchedfilt = matchedfilt.real

    matchedfilt = matchedfilt.reshape((ny, int(gen_ny/ny), nx, int(gen_nx/nx))).mean(3).mean(1)
    psf = psf.reshape((ny, int(gen_ny/ny), nx, int(gen_nx/nx))).mean(3).mean(1)

    #norm = np.sum(psf*matchedfilter)/np.sum(matchedfilter**2.)
    #matchedfilter = norm * matchedfilter 
    if mf_only == True:
        return (matchedfilt)

    return (matchedfilt, psf)
    #return  matchedfilt  

def corr_psf_max_MF(hdulist1,hdulist2,hdulist3, ra, dec):

    '''
    max_correlation, ra_maxcorr, dec_maxcorr = corr_psf_max(imagename, fwhm, pixsize, ra, dec)
    '''

    nanvalues = np.isnan(hdulist1["MFILT"].data) | np.isnan(hdulist1["MFILT_ERROR"].data) | np.isnan(hdulist1["ERROR"].data)
    hdulist1["MFILT"].data[nanvalues] = 0.
    hdulist1["MFILT_ERROR"].data[nanvalues]= 100.*np.max(hdulist1["MFILT_ERROR"].data[np.isfinite(hdulist1["MFILT_ERROR"].data)])
    hdulist1["ERROR"].data[nanvalues]= 100.*np.max(hdulist1["ERROR"].data[np.isfinite(hdulist1["ERROR"].data)])

    f_n1 = 1./hdulist1["MFILT_ERROR"].data**2
    weightmap1 = 1./hdulist1["ERROR"].data**2

    nanvalues = np.isnan(hdulist2["MFILT"].data) | np.isnan(hdulist2["MFILT_ERROR"].data) | np.isnan(hdulist2["ERROR"].data)
    hdulist2["MFILT"].data[nanvalues] = 0.
    hdulist2["MFILT_ERROR"].data[nanvalues]= 100.*np.max(hdulist2["MFILT_ERROR"].data[np.isfinite(hdulist2["MFILT_ERROR"].data)])
    hdulist2["ERROR"].data[nanvalues]= 100.*np.max(hdulist2["ERROR"].data[np.isfinite(hdulist2["ERROR"].data)])

    f_n2 = 1./hdulist2["MFILT_ERROR"].data**2
    weightmap2 = 1./hdulist2["ERROR"].data**2

    nanvalues = np.isnan(hdulist3["MFILT"].data) | np.isnan(hdulist3["MFILT_ERROR"].data) | np.isnan(hdulist3["ERROR"].data)
    hdulist3["MFILT"].data[nanvalues] = 0.
    hdulist3["MFILT_ERROR"].data[nanvalues]= 100.*np.max(hdulist3["MFILT_ERROR"].data[np.isfinite(hdulist3["MFILT_ERROR"].data)])
    hdulist3["ERROR"].data[nanvalues]= 100.*np.max(hdulist3["ERROR"].data[np.isfinite(hdulist3["ERROR"].data)])

    f_n3 = 1./hdulist3["MFILT_ERROR"].data**2
    weightmap3 = 1./hdulist3["ERROR"].data**2

    w1 = WCS(hdulist1["MFILT"].header) 
    w2 = WCS(hdulist2["MFILT"].header) 
    w3 = WCS(hdulist3["MFILT"].header) 

    fwhm1 = hdulist1["Matchedfilter"].header["FWHM"]   
    conf = hdulist1["Matchedfilter"].header["nconf"]   
    ninstr = hdulist1["Matchedfilter"].header["nins"]   
    pixsize1 = hdulist1["Matchedfilter"].header["PIXSIZE"] 
    mf, psf = generate_pixelized_matched_filter(fwhm1, pixsize1,conf, ninstr, 0, 0)   
    norm = np.sum(psf*mf)/np.sum(mf**2.)
    matchedfilter1 = norm * mf
 
    x, y = w1.wcs_world2pix(ra, dec, 0)

    x_edge2, y_edge2 =  w2.wcs_world2pix(ra, dec, 0)
    x_edge3, y_edge3 =  w3.wcs_world2pix(ra, dec, 0)

    y_max2, x_max2 = np.shape(hdulist2["MFILT"].data)
    y_max3, x_max3 = np.shape(hdulist3["MFILT"].data)

    edge_problem = (x_edge2 <= 8) | (x_edge3 <= 8) | \
                   (y_edge2 <= 8) | (y_edge3 <= 8) | \
                   (y_edge2 >= y_max2-8) | (x_edge2 >= x_max2-8) | \
                   (y_edge3 >= y_max3-8) | (x_edge3 >= x_max3-8)

    x0, y0 = np.round(x),np.round(y)
    dx0, dy0 = np.round(x-x0, 1), np.round(y-y0, 1)  
    #dx0step = [step for stepy in range(-5,5) for step in range(-5,5)]
    #dy0step = [step for step in range(-5,5) for stepx in range(-5,5)]
    dx0step = [step for stepy in range(-3,3) for step in range(-3,3)]
    dy0step = [step for stepy in range(-3,3) for step in range(-3,3)]



    #psf1 = [generate_pixelized_psf(fwhm1, pixsize1, xc = dx0step[_]/10., yc = dy0step[_]/10.) for _ in range(len(dx0step))]
    psf1 = [generate_pixelized_psf(fwhm1, pixsize1, xc = dx0step[_]/30.*5, yc = dy0step[_]/30.*5) for _ in range(len(dx0step))]

    fwhm2 = hdulist2["Matchedfilter"].header["FWHM"]   
    conf = hdulist2["Matchedfilter"].header["nconf"]   
    ninstr = hdulist2["Matchedfilter"].header["nins"]   
    pixsize2 = hdulist2["Matchedfilter"].header["PIXSIZE"] 
    mf, psf = generate_pixelized_matched_filter(fwhm2, pixsize2,conf, ninstr, 0, 0)   
    norm = np.sum(psf*mf)/np.sum(mf**2.)
    matchedfilter2 = norm * mf

    fwhm3 = hdulist3["Matchedfilter"].header["FWHM"]   
    conf = hdulist3["Matchedfilter"].header["nconf"]   
    ninstr = hdulist3["Matchedfilter"].header["nins"]   
    pixsize3 = hdulist3["Matchedfilter"].header["PIXSIZE"] 
    mf, psf = generate_pixelized_matched_filter(fwhm3, pixsize3,conf, ninstr, 0, 0)   
    norm = np.sum(psf*mf)/np.sum(mf**2.)
    matchedfilter3 = norm * mf

    max_correlation = []
    ra_maxcorr = []
    dec_maxcorr = []
 

    S1_map = []
    E1_map = []

    S2_map = []
    E2_map = []
    
    S3_map = []
    E3_map = []  


 
    stampsize = 5

    weightsize = 11 #15

    for i in range(len(ra)):      
        print(100.*(float(i)/len(ra)), '%')
        
        newcorr = []
        newra = []
        newdec = []
        newS1,newS2,newS3 = [], [], []
        newE1,newE2,newE3 = [], [], []


        for y0step in range(-1,2):
            for x0step in range(-1,2):
                tmpy0 = y0[i] + y0step
                tmpx0 = x0[i] + x0step
                cutout1 = hdulist1["MFILT"].data[int(tmpy0-stampsize/2):int(tmpy0+stampsize/2+1),int(tmpx0-stampsize/2):int(tmpx0+stampsize/2+1)]
                cut_f_n1 = f_n1[int(tmpy0-stampsize/2):int(tmpy0+stampsize/2+1),int(tmpx0-stampsize/2):int(tmpx0+stampsize/2+1)] 
                wm_cut1 = weightmap1[int(tmpy0-weightsize/2):int(tmpy0+weightsize/2+1),int(tmpx0-weightsize/2):int(tmpx0+weightsize/2+1)] 

                p = cutout1 - np.mean(cutout1)
            
                for dstep in range(len(dx0step)):                         
                    #ra_tmp, dec_tmp = w1.wcs_pix2world(tmpx0+dx0step[dstep]/10., tmpy0+dy0step[dstep]/10.,0)
                    ra_tmp, dec_tmp = w1.wcs_pix2world(tmpx0+dx0step[dstep]/30.*5, tmpy0+dy0step[dstep]/30.*5,0)

                    psf_use = psf1[dstep]
                    f_b = signal.fftconvolve(psf_use*wm_cut1,matchedfilter1,mode='same')
                    f_noise = signal.fftconvolve(wm_cut1,matchedfilter1**2,mode='same')
                    f_b = f_b[3:8,3:8]/f_noise[3:8,3:8] #/cut_f_n1
                    t =  f_b - np.mean(f_b)

                    e_tmp1 = 1./np.sqrt(f_noise[5,5])
                    
                    #second filter
                    if edge_problem[i] == False:
                        x2, y2 = w2.wcs_world2pix(ra_tmp, dec_tmp, 0)
                        x0_2, y0_2 = np.round(x2),np.round(y2)
                        dx0, dy0 = np.round(x2-x0_2, 1), np.round(y2-y0_2, 1)


                        cutout2 = hdulist2["MFILT"].data[int(y0_2-stampsize/2):int(y0_2+stampsize/2+1),int(x0_2-stampsize/2):int(x0_2+stampsize/2+1)]
                        cut_f_n2 = f_n2[int(y0_2-stampsize/2):int(y0_2+stampsize/2+1),int(x0_2-stampsize/2):int(x0_2+stampsize/2+1)] 
                        wm_cut2 = weightmap2[int(y0_2-weightsize/2):int(y0_2+weightsize/2+1),int(x0_2-weightsize/2):int(x0_2+weightsize/2+1)]
                        p2 = cutout2 - np.mean(cutout2)
                        psf2 = generate_pixelized_psf(fwhm2, pixsize2, xc = dx0, yc = dy0)
                        f_b2 = signal.fftconvolve(psf2*wm_cut2,matchedfilter2,mode='same')
                        f2_noise = signal.fftconvolve(wm_cut2,matchedfilter2**2,mode='same')
                        e_tmp2 = 1./np.sqrt(f2_noise[5,5])

                        f_b2 = f_b2[3:8,3:8]/f2_noise[3:8,3:8] #/cut_f_n2
                        t2 =  f_b2 - np.mean(f_b2)

                        #third filter
                        x3, y3 = w3.wcs_world2pix(ra_tmp, dec_tmp, 0)
                        x0_3, y0_3 = np.round(x3),np.round(y3)
                        dx0, dy0 = np.round(x3-x0_3, 1), np.round(y3-y0_3, 1)

                        cutout3 = hdulist3["MFILT"].data[int(y0_3-stampsize/2):int(y0_3+stampsize/2+1),int(x0_3-stampsize/2):int(x0_3+stampsize/2+1)]
                        cut_f_n3 = f_n3[int(y0_3-stampsize/2):int(y0_3+stampsize/2+1),int(x0_3-stampsize/2):int(x0_3+stampsize/2+1)] 
                        wm_cut3 = weightmap3[int(y0_3-weightsize/2):int(y0_3+weightsize/2+1),int(x0_3-weightsize/2):int(x0_3+weightsize/2+1)]
               
                        p3 = cutout3 - np.mean(cutout3)
                        psf3 = generate_pixelized_psf(fwhm3, pixsize3, xc = dx0, yc = dy0)
                        
                        f_b3 = signal.fftconvolve(psf3*wm_cut3,matchedfilter3,mode='same')
                        f3_noise = signal.fftconvolve(wm_cut3,matchedfilter3**2,mode='same')
                        e_tmp3 = 1./np.sqrt(f3_noise[5,5])

                        f_b3 = f_b3[3:8,3:8]/f3_noise[3:8,3:8] # cut_f_n3 # 5:10
                        t3 =  f_b3 - np.mean(f_b3)

                        p_tot = np.array([p,p2,p3])
                        t_tot = np.array([t,t2,t3])


                    else:
                        p_tot = p
                        t_tot = t    

                    corr = np.sum(p_tot*t_tot) / (np.sum(p_tot**2.)*np.sum(t_tot**2.))**0.5
                    S_tmp1 = np.sum(cutout1*f_b*cut_f_n1)/np.sum(f_b**2*cut_f_n1)

                    #e_tmp1 = 1./(np.sum(f_b**2.*cut_f_n1**2))**0.5

                    if edge_problem[i] == False:
                        S_tmp2 = np.sum(cutout2*f_b2*cut_f_n2)/np.sum(f_b2**2*cut_f_n2)
                        #e_tmp2 = 1./(np.sum(f_b2**2.*cut_f_n2**2))**0.5

                        S_tmp3 = np.sum(cutout3*f_b3*cut_f_n3)/np.sum(f_b3**2*cut_f_n3)
                        #e_tmp3 = 1./(np.sum(f_b3**2.*cut_f_n3**2))**0.5  
                    else:
                        x2, y2 = w2.wcs_world2pix(ra_tmp, dec_tmp, 0)
                        x0_2, y0_2 = np.round(x2),np.round(y2)
                        x3, y3 = w3.wcs_world2pix(ra_tmp, dec_tmp, 0)
                        x0_3, y0_3 = np.round(x3),np.round(y3)

                        S_tmp2 = hdulist2["MFILT"].data[int(y0_2),int(x0_2)]
                        e_tmp2 = hdulist2["MFILT_ERROR"].data[int(y0_2),int(x0_2)]
                        S_tmp3 = hdulist3["MFILT"].data[int(y0_3),int(x0_3)]
                        e_tmp3 = hdulist3["MFILT_ERROR"].data[int(y0_3),int(x0_3)]  

                    newcorr = np.append(newcorr, corr)
                    newra =  np.append(newra,ra_tmp)
                    newdec =  np.append(newdec,dec_tmp)
                    newS1 = np.append(newS1,S_tmp1)
                    newE1 = np.append(newE1,e_tmp1)
                    newS2 = np.append(newS2,S_tmp2)
                    newE2 = np.append(newE2,e_tmp2) 
                    newS3 = np.append(newS3,S_tmp3)
                    newE3 = np.append(newE3,e_tmp3)


        wmax = np.argmax(newcorr)
        max_correlation = np.append(max_correlation, newcorr[wmax])

        ra_maxcorr =  np.append(ra_maxcorr, newra[wmax])
        dec_maxcorr =  np.append(dec_maxcorr, newdec[wmax])
        S1_map =  np.append(S1_map, newS1[wmax])
        E1_map =  np.append(E1_map, newE1[wmax])

        S2_map =  np.append(S2_map, newS2[wmax])
        E2_map =  np.append(E2_map, newE2[wmax])

        S3_map =  np.append(S3_map, newS3[wmax])
        E3_map =  np.append(E3_map, newE3[wmax])

    return (max_correlation, ra_maxcorr, dec_maxcorr,S1_map, E1_map,S2_map, E2_map, S3_map, E3_map)    



def matched_filter_full(fwhm, pixsize, nconf, noise, whitenoise=False, image=False, psf_only=False, normalize=False):

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

def do_filtering(hdulist250,hdulist500,new500):

    conf_250 = hdulist250["Matchedfilter"].header["nconf"]   
    ninstr_250 = hdulist250["Matchedfilter"].header["nins"]
    pixsize_250 = hdulist250["Matchedfilter"].header["PIXSIZE"]
    FWHM_250 = hdulist250["Matchedfilter"].header["FWHM"]



    conf_500 = hdulist500["Matchedfilter"].header["nconf"]   
    ninstr_500 = hdulist500["Matchedfilter"].header["nins"]
    FWHM_500 = hdulist500["Matchedfilter"].header["FWHM"]


    nconf = [conf_250,conf_500]
    pixsize = [pixsize_250,pixsize_250]
    fwhm = [FWHM_250,FWHM_500]
    ninstr = [ninstr_250,ninstr_500]
        
    matchedfilter = []
    psf = []

    
    for i in range(2):
        #image = hdulist[1].data
        #noisemap = hdulist[2].data
        #nanvalues = np.isnan(noisemap)    
        #image[nanvalues] = 0.
        #noisemap[nanvalues]=100.*np.nanmax(noisemap)
        #weightmap = 1./noisemap**2.
    
        m, p = matched_filter_full(fwhm[i], pixsize[i], nconf[i], ninstr[i], whitenoise=True, image=False, psf_only=False, normalize=False)
        #norm = np.sum(p*m)/np.sum(m**2.)
        #m = norm * m
        #print (m - hdulist250["Matchedfilter"].data)[50,30:60]


        matchedfilter.append(m)
        psf.append(p)
        #hdulist.close()

    #------------------------------------------------
    #figure out the actual smoothing filters. For 500 micron it will be the matched filter, but for the other
    #two wavelengths we want to create the same shape as the 500 micron matched filtered pointsource profile

    kernel = [] 
    
    target_profile =signal.fftconvolve(psf[1],matchedfilter[1], mode='same')/np.sum(psf[1]*matchedfilter[1])
    
 
    final = target_profile
    initial = psf[0]
    f_final = fftpack.fftshift(fftpack.fft2(final))
    f_initial = fftpack.fftshift(fftpack.fft2(initial))
    filt = fftpack.fftshift(fftpack.ifft2(fftpack.ifftshift(f_final/f_initial)))
    filt = filt.real
    kernel.append(filt)


    kernel.append(matchedfilter[1])
    
    #pyfits.writeto(basepath+basename+'effective_redmatched_psf.fits',target_profile, clobber=True)
    #pyfits.writeto(basepath+basename+'redmatched_kernel_PSW.fits',kernel[0], clobber=True)
    #pyfits.writeto(basepath+basename+'redmatched_kernel_PMW.fits',kernel[1], clobber=True)
    #pyfits.writeto(basepath+basename+'redmatched_kernel_PLW.fits',kernel[2], clobber=True)
    #pyfits.writeto(basepath+basename+'psf_PSW.fits',psf[0], clobber=True)
    #pyfits.writeto(basepath+basename+'psf_PMW.fits',psf[1], clobber=True)
    #pyfits.writeto(basepath+basename+'psf_PLW.fits',psf[2], clobber=True)

    #------------------------------------------------
    #now do the actual noise weighted convolution:

    #bandmaps = [bandindex[_] for _ in doband]
    #for i in bandmaps:
    image = hdulist250["NEBFILT"].data
    noisemap = hdulist250["ERROR"].data
    
    nanvalues = np.isnan(noisemap) |   np.isnan(image) | np.isnan(new500)



    image[nanvalues] = 0.
    noisemap[nanvalues]=100.*np.nanmax(noisemap)
    weightmap = 1./noisemap**2.

    norm = np.sum(psf[0]*kernel[0])/np.sum(kernel[0]**2.)
    kernel[0] = norm * kernel[0]

         
    #conv_image = convolve_fft(image*weightmap,kernel[i],fft_pad=False)
    #conv_noise = convolve_fft(weightmap,kernel[i]**2.,fft_pad=False)
    
    conv_image = signal.fftconvolve(image*weightmap,kernel[0], mode='same') 
    conv_noise = signal.fftconvolve(weightmap,kernel[0]**2., mode='same') 
    conv_image = conv_image/conv_noise
    conv_noise = (1./(conv_noise**0.5))


    #set pixels with zero exposure to NaN: 
    #conv_image[nanvalues] = np.nan
    #conv_noise[nanvalues] = np.nan
    conv_image -= np.nanmean(conv_image)  #meansubtraction, ignore, NaN pixels:


    k = 0.392
    D = np.sqrt(1.-k**2)*new500 - k*conv_image
    D[nanvalues] = np.nan

    #hdulist.writeto(basepath+basename+outtype+band[i]+'.fits', clobber=True) 
    #hdulist.close()
    return D

def find_peak_red(Dhdu, dmin):
    D = Dhdu[1].data

    D[np.isnan(D)] = 0.
    #D[D < dmin] = 0.  #to speed up the sort, ignore pixels which are smaller than the d limit
    
   
    w = WCS(Dhdu[1].header)
    
    y, x = np.indices(D.shape)
    y_max,x_max = np.max(y), np.max(x)

 
        
    #flatten 2d arrays 
    dflat = D.ravel()
    yflat = y.ravel()
    xflat = x.ravel()
    #sort all the values in descending order:
    wmax = np.argsort(dflat)[::-1]
    sortedval = dflat[wmax]
    sortedx = xflat[wmax]
    sortedy = yflat[wmax]
    xp = []
    yp = []
    dp = []
    ep = []
    rap = []
    decp = []
    
    i=0
    while (sortedval[i] > dmin):

        minimap = D[sortedy[i]-1:sortedy[i]+2, sortedx[i]-1:sortedx[i]+2]
        maximap = D[sortedy[i]-3:sortedy[i]+4, sortedx[i]-3:sortedx[i]+4]

        good = maximap != 0

        if  (sortedy[i] <= 4) or (sortedx[i] <= 4) or (sortedy[i] >= y_max-4) or (sortedx[i] >= x_max-4) :
            minimap = 0
        
        if (sortedval[i] == np.max(minimap)) and (np.size(maximap[good]) >=45):

            dp.append(sortedval[i])
            yp.append(sortedy[i])
            xp.append(sortedx[i])
            ra, dec = w.wcs_pix2world(sortedx[i],sortedy[i],0)


            rap.append(ra)
            decp.append(dec)


        i = i+1        
        
    return (dp, rap, decp, xp, yp)