#!/usr/bin/env python
# coding: utf-8

# ## Analysing SSDF maps
# 
# ### Import modules

# In[1]:


import pylab as plt
import pymoc
import xidplus
import numpy as np
get_ipython().run_line_magic('matplotlib', 'inline')
from astropy.table import Table, join
import seaborn as sns

from astropy.cosmology import Planck15 as cosmo
from astropy import units as u


import astropy.wcs as apw
import matplotlib.pyplot as plt




def stack_image(im0,hd,ra,dec,med=False,weight=False,noFilt=True,mask=False,size=25,src_boost=False):
    '''
         INPUTS:
        
         im0:           (2D array, naxis1 x naxis2) large image from which stack is to be extracted
         hd:            header for above
         ra (Vector) :  coordinates of target sources whose flux is to be stacked
         dec (vector) : coordinates of target sources whose flux is to be stacked
        
         OPTIONAL INPUTS:
        
         weight:        (2D array, naxis1 x naxis2) large image of weights (n.B. modfied if mask set) weight could include flags where NaNs exist in the image im0, setting pixels outside the footprint to 0. 
         nofilt:        if set then weights are not used to set bad pixels to zero
                        (assumed that this has already been done - time saver)
         mask:          if set then on return the weight array is set to zero where stacks have been cut-out
         size:          number of pixels on each side of stack image (default 25)
         src_boost:     boost to be given to each source (if not set then
                        default is a boost of 1 of all sources, otherwise
                        must be a vector the same length as ra,dec.  This boost
                        can be used to normalise flux to same effective redshift
        
        
        OUTPUTS:
        
         mean: (2D array, size x size) mean intensity map around targets
         var: (2D array, size x size) variance of above (i.e, variance between pixels for different
              targets - error in mean would be smaller than this by root(nsamp))
        
         stack: (2D array, size x size) sum of intensities around targets
         stack2: (2D array, size x size) sum of squares of intensities around
                 targets
         med:  (2D array, size x size) median stack of intesnities
         b1:   estimate of background from pixels not used in stack
         sig1: estimate of variance in background from pixels not used in stack
         nsamp: (2D array, size x size) number of samples in each pixel
        
        SIMPLE DEFAULT USEAGE:
        
        Mean, Var, stack, stack2,b1,sig1, nsamp,med = stack_image(im0,hd,ra,dec,med=False,weight=False,noFilt=True,mask=False,size=25,src_boost=False)
        
        '''
    im=im0
    ngals=ra.size
    print ('number of galaxies: '+str(ngals))
    naxis1=np.int(hd['naxis1'])
    naxis2=np.int(hd['naxis2'])
    
    try:
        if (weight==False): #try statement here catches when weight is array
            weight=np.ones((naxis2,naxis1))
    except ValueError: None #do nothing just pass through
   
    
    try:
        if noFilt==False:
            bad=np.where(weight == 0.0)
            nbad = len(bad)
            if nbad > 0: im[bad]=0.0
    except ValueError: None   #do nothing

    
    #######convert radec to pixel coords
    
    wcs=apw.WCS(hd)
    x,y=wcs.wcs_world2pix(ra,dec,0)
    
    #finding sources that lie off the map and putting those well off the map
    # bad = np.where((x<=-1) | (x>=naxis1)| (y<=-1) | (y>=naxis2))  --> change to: 
    
    bad = np.where((x<=size/2) | (x>=naxis1-(size/2))| (y<=size/2) | (y>=naxis2-(size/2))) 
    
    if len(bad) > 0:
        x[bad] = -size/2
        y[bad] = -size/2
    
    
    i0=np.array([int(np.round(xi)) for xi in x])
    j0=np.array([int(np.round(yi)) for yi in y])
    
    
    
    #----------------------------------------------------------------------
    # setting up 3D array to define the i and j coordinates (in the
    # orginal image) of the pixels in the stack cube
    #----------------------------------------------------------------------
    
    #1D coordinate offsets
    di=np.arange(size)-np.floor(size/2)
    dj=di
    
    #2D coordinate offsets
    dii,djj=np.meshgrid(di,dj)
    
    #3D coordinate offsets
    i=np.tile(dii,(ngals,1,1)).astype('int')
    j=np.tile(djj,(ngals,1,1)).astype('int')
    
    # offseting from source positions
    #i = reform(fix(replicate(1,size^2)#i0)+temporary(i),size,size,ngals)
    
    for ind, ii in enumerate(i0):
        i[ind]+=ii
    
    for ind, ji in enumerate(j0):
        j[ind]+=ji
    
    #----------------------------------------------------------------------
    # ensuring within boundaries N.B. weights at boundaries should
    # have been set to zero
    #----------------------------------------------------------------------
    #i = temporary(i) > 0 & i = temporary(i) < (fix(naxis1)-1) <-IDL
    #j = temporary(j) > 0 & j = temporary(j) < (fix(naxis2)-1)
    
    #???????
    
    #----------------------------------------------------------------------
    # setting-up weight and stack cubes
    #----------------------------------------------------------------------
    StackCube = im[j,i]
    WeightCube=weight[j,i]
    
    #----------------------------------------------------------------------
    # calculating statistics for all pixels outside the cut-outs
    #----------------------------------------------------------------------
    
    weight[j,i] = False
    goodj,goodi=np.where(weight != 0)
    
    b1=np.mean(im[goodj,goodi].flatten())
    sig1=np.sqrt(np.var(im[goodj, goodi].flatten()))
    
    # if mask has been set then we can leave these weights at zero -
    # otherwise we should change them back to what they were
    if mask==False: 
        weight[j,i] = WeightCube
        mask=np.ones((naxis1,naxis2))
    else:
        mask=weight
    
    
    #----------------------------------------------------------------------
    # folding in source boost
    #----------------------------------------------------------------------
    
    try:
        if src_boost==False:
            src_boost = np.ones(len(ra))
    except ValueError:
        if len(src_boost) != len(ra):
            print ('elements in src_boost does not match ra')
         
        # reformating to 2D
        StackCube = StackCube.reshape(ngals,size*size)    
        src_boost_cube=np.ones((ngals,size*size))
        src_boost_cube=np.array([src_boost_cube[i]*src_boost[i] for i in range(len(src_boost))])
        
        StackCube*=src_boost_cube ##this may not be correct? 
        StackCube=StackCube.reshape(ngals,size,size)

    
    
    #----------------------------------------------------------------------
    # calculating stats for all pixels in cut-out (N.B. reformating matrix
    # dimensions is necessary because sometimes you only have 1 galaxy and
    # then the dimensions can drop to 2D arrays instead of 3D
    #----------------------------------------------------------------------
    
    #sw = StackCube*WeightCube
    #Stack=total(reform(sw, size, size, ngals),3)
    #Stack2=total(reform(sw^2, size, size, ngals),3)
    #nsamp=total(WeightCube,3)
    #nsamp2 = total(reform(WeightCube^2, size, size, ngals),3)
    
    sw = StackCube*WeightCube
    

    stack = np.sum(sw, axis=0)
    stack2=np.sum(sw**2, axis=0)
    nsamp=np.sum(WeightCube, axis=0)
    nsamp2=np.sum(WeightCube**2, axis=0)
    
    Mean=stack/nsamp
    Var = (stack2*nsamp-stack**2)/(nsamp**2-nsamp2)
    
    # trap for poorly determined variances
    bad = np.where(nsamp <= 1)
    good= np.where(nsamp >1)
    nbad=len(bad)
    ngood=len(good)
    
    if nbad > 0:
        if ngood > 0:
            badvar = np.max(Var[good])*2.
        else:
            badvar = 1
        Var[bad] = badvar
    
    #------------------------------------
    
    if med==True:
        med=np.zeros((size,size))
        for iloop in range(size):
            for jloop in range(size):
                good=np.where(WeightCube[:, iloop,jloop] != 0)
                ngood=np.array(good).size
                if ngood >= 0: med[iloop,jloop]=np.median(StackCube[good,iloop,jloop])
    
    #-----------------------------------
    
    #change the header from the image file to one for the stack
    
    #build a wcs object, might not be the best way? 
    stack_hd=hd.copy()
    stack_hd['crval1']=0
    stack_hd['crval2']=0
    stack_hd['crpix1']=size/2+1
    stack_hd['crpix2']=size/2+1
    stack_hd['naxis1']=size
    stack_hd['naxis2']=size
    
    if med==True:
        return (StackCube, WeightCube, Mean, Var, stack, stack2,b1,sig1, nsamp,mask,med)
    else:
        return (StackCube, WeightCube, Mean, Var, stack, stack2,b1,sig1,mask, nsamp)




# #### Prior_list


# Cigale Ldust
cigale=Table.read('../../dmu28/dmu28_SSDF/data/SSDF_Ldust_prediction_results.fits')
cigale['id'].name = 'help_id'
cigale = cigale[['help_id', 'bayes.dust.luminosity']]


# Photo-z
photoz=Table.read('../../dmu24/dmu24_SSDF/data/master_catalogue_ssdf_20180221_photoz_20180612_r_optimised.fits')
photoz = photoz[['help_id','RA','DEC','z1_median']]

# join tables
prior=join(cigale,photoz)


f_pred=prior['bayes.dust.luminosity']/(4*np.pi*cosmo.luminosity_distance(prior['z1_median']).to(u.cm))

prior=prior[np.isfinite(f_pred.value)][np.log10(f_pred.value[np.isfinite(f_pred.value)])>8.5]

prior['DEC'].name='Dec'

len(prior)

# #### MAPS

# In[13]:


# SSDF
pswfits='../../dmu19/dmu19_HELP-SPIRE-maps/data/SSDF_SPIRE250_v1.0.fits'#SPIRE 250 map
pmwfits='../../dmu19/dmu19_HELP-SPIRE-maps/data/SSDF_SPIRE350_v1.0.fits'#SPIRE 350 map
plwfits='../../dmu19/dmu19_HELP-SPIRE-maps/data/SSDF_SPIRE500_v1.0.fits'#SPIRE 500 map


 # STACKING


import numpy as np
import astropy.io.fits as apif
from stacking import stack_image
import matplotlib.pyplot as plt

iminfile=[pswfits, pmwfits, plwfits]


cat=prior
ra=cat.field('RA')
dec=cat.field('Dec')

print('ra',len(ra))

names = ['SSDF250_stack.fits','SSDF350_stack.fits','SSDF500_stack.fits']

for i, file in iminfile:
    im0=apif.open(file)[1].data
    hd=apif.open(file)[1].header

    #set nans to 0
    ind=np.where(np.isnan(im0))
    weight=np.ones(im0.shape)
    weight[ind]=0

    src_boost=False

    #Stacking
    StackCube, WeightCube, meanStack, varStack, stack, stack2,b1,sig1, mask, nsamp = stack_image(im0,hd,ra,dec,med=False,weight=weight,noFilt=False,mask=True,size=25,src_boost=src_boost)

    # Save Image
    primary_hdu = apif.PrimaryHDU()
    stack_hdu = apif.ImageHDU(header=hd, data=meanStack)
    err_hdu = apif.ImageHDU(data=varStack)
    
    hdu_stamp = apif.HDUList([primary_hdu, stack_hdu, err_hdu])
    hdu_stamp.writeto('./data/'+ names[i])
    

    