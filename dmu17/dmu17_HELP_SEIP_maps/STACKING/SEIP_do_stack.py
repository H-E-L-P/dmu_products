import numpy as np
import astropy.io.fits as apif
from SEIP_stamps import stamps
import matplotlib.pyplot as plt
from SEIP_stacking import stack_image
import glob

field = 'SA13'
#iminfiles = glob.glob("../"+field+"/data/*.help.fits", recursive=True)
iminfiles = ['../'+field+'/data/50070360.50070360-0.MIPS.1.help.fits']
catinfile="../../../dmu16/dmu16_allwise/data/Allwise_PSF_stack_SA13.fits"  

cat=apif.open(catinfile)[1].data
ra_cat=cat.field('ra')
dec_cat=cat.field('dec')

mag=cat.field('chi2w4_pm')
ind,=np.where(mag < 4)
ra=ra_cat[ind]
dec=dec_cat[ind]

coord_stamp=[]
src_boost=False
##########################

SCubes = []
WCubes = []
b1_all = []
sig1_all = []
mask_all = []

for i in iminfiles:
    im0 = apif.open(i)[1].data 
    hd = apif.open(i)[1].header
    hd_err = apif.open(i)[2].header
    
    # To correct problem with image coordenates on SEIP mosaic
    hd['CRVAL1'] = hd_err['CRVAL1']
    hd['CRVAL2'] = hd_err['CRVAL2']
    
    #set nans to 0
    ind=np.where(np.isnan(im0))
    weight=np.ones(im0.shape)
    weight[ind]=0
    
    # Create cube_stamps for each image
    StackCube, WeightCube, coord, stamp_hd, b1, sig1, mask= stamps(im0,hd,ra,dec, coord_stamp,med=False,weight=weight,noFilt=False,mask=True,size=25,src_boost=src_boost)

    coord_stamp.append(coord)
    SCubes.append(StackCube)
    WCubes.append(WeightCube)
    b1_all.append(b1)
    sig1_all.append(sig1)
    mask_all.append(mask)
    
StackCube_All = np.asarray(StackCube)
WeightCube_All = np.asarray(WeightCube)

for i in range(len(SCubes)-1):
    StackCube_All = np.concatenate([StackCube_All, SCubes[i]])   
    WeightCube_All = np.concatenate([WeightCube_All, WCubes[i]])     
    
    
    
# Do the stacking    
meanStack, varStack, stack, stack2, nsamp = stack_image(StackCube_All, WeightCube_All,med=False,size=25)


# Save psf.fits
primary_hdu = apif.PrimaryHDU()
stack_hdu = apif.ImageHDU(header=stamp_hd, data=meanStack)
err_hdu = apif.ImageHDU(data=varStack)
    
hdu_stamp = apif.HDUList([primary_hdu, stack_hdu, err_hdu])
hdu_stamp.writeto('./data/dmu17_PSF_MIPS_'+ field + '_20190325.fits')
    

print ('StackCube_shape:', np.shape(StackCube_All))
print ('WeightCube_shape:', np.shape(WeightCube_All))


plt.imshow(meanStack)
plt.colorbar()
plt.show()

#plt.imshow(varStack)
#plt.colorbar()
#plt.show()

#plt.imshow(nsamp)
#plt.colorbar()
#plt.show()
