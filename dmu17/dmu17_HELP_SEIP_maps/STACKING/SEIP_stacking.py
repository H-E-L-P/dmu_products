import numpy as np
import astropy.wcs as apw
import matplotlib.pyplot as plt




def stack_image(StackCube, WeightCube,med=False,size=25):
    '''
         INPUTS:
        
         StackCube: (3D array, ngal x size x size)  
         WeightCube: (3D array, ngal x size x size)
         size:          number of pixels on each side of stack image (default 25)
        
        
        OUTPUTS:
        
         mean: (2D array, size x size) mean intensity map around targets
         var: (2D array, size x size) variance of above (i.e, variance between pixels for different
              targets - error in mean would be smaller than this by root(nsamp))
         med:  (2D array, size x size) median stack of intesnities
        
         stack: (2D array, size x size) sum of intensities around targets
         stack2: (2D array, size x size) sum of squares of intensities around
         nsamp: (2D array, size x size) number of samples in each pixel
        
        SIMPLE DEFAULT USEAGE:
        Mean, Var, stack, stack2, nsamp,med = stack_image(StackCube, WeightCube,med=False,size=25)
        
        '''
    
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

    
    if med==True:
        return (Mean, Var, stack, stack2, nsamp,med)
    else:
        return (Mean, Var, stack, stack2, nsamp)

