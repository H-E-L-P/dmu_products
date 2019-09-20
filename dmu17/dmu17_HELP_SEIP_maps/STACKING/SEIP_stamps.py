import numpy as np
import astropy.wcs as apw
import matplotlib.pyplot as plt


def stamps(im0,hd,ra,dec,coord_stamp,med=False,weight=False,noFilt=True,mask=False,size=25,src_boost=False):
    '''
         INPUTS:
        
         im0:           (2D array, naxis1 x naxis2) large image from which stack is to be extracted
         hd:            header for above
         ra (Vector) :  coordinates of target sources whose flux is to be stacked
         dec (vector) : coordinates of target sources whose flux is to be stacked
         coord (ra,dec): coordinates of target sources already stacked
        
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
        
         StackCube: (3D array, ngal x size x size)  
         WeightCube: (3D array, ngal x size x size)
         coord_stamp: ((ra,dec) coordinates of target sources in the stamp)
         stamp_hd: header from image targets
         b1:   estimate of background from pixels not used in stack
         sig1: estimate of variance in background from pixels not used in stack
                 
        SIMPLE DEFAULT USEAGE:
        
        StackCube, WeightCube, coord_stamp, stamp_hd, b1, sig1 = stamps(im0,hd,ra,dec,coord,med=False,weight=False,noFilt=True,mask=False,size=25,src_boost=False)
        
        '''
    im=im0 
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
 
    #remove ra,dec already used

    for ind, coord in enumerate(zip(ra,dec)):
        if coord in coord_stamp:
            ra.remove(ra[ind])
            dec.remove(dec[ind])
    
    wcs=apw.WCS(hd)
    x,y=wcs.wcs_world2pix(ra,dec,0)
    
    #finding sources that lie off the map and putting those well off the map
    # bad = np.where((x<=-1) | (x>=naxis1)| (y<=-1) | (y>=naxis2))  --> change to: 
    
    bad, = np.where((x<=size/2) | (x>=naxis1-(size/2))| (y<=size/2) | (y>=naxis2-(size/2))) 
    
   
    if len(bad) > 0:
        x[bad] = None
        y[bad] = None    
    
    x_stamp = x[np.where(~np.isnan(x))]
    y_stamp = y[np.where(~np.isnan(y))]
    ra_stamp = ra[np.where(~np.isnan(x))]
    dec_stamp = dec[np.where(~np.isnan(y))]
                             
    
    coord_stamp=list((a,b)for a, b in zip(ra_stamp, dec_stamp))
    
    ngals_in = len(x_stamp)
    print ('number of galaxies: '+str(ngals_in))
    
    i0=np.array([int(np.round(xi)) for xi in x_stamp])
    j0=np.array([int(np.round(yi)) for yi in y_stamp])
    
    
    
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
    i=np.tile(dii,(ngals_in,1,1)).astype('int')
    j=np.tile(djj,(ngals_in,1,1)).astype('int')
    
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
        
        
    #change the header from the image file to one for the stack
    
    #build a wcs object, might not be the best way? 
    stamp_hd=hd.copy()
    stamp_hd['crval1']=0
    stamp_hd['crval2']=0
    stamp_hd['crpix1']=size/2+1
    stamp_hd['crpix2']=size/2+1
    stamp_hd['naxis1']=size
    stamp_hd['naxis2']=size
    

    return (StackCube, WeightCube, coord_stamp, stamp_hd, b1, sig1, mask)
