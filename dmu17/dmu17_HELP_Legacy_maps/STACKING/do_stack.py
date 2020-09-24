import numpy as np
import astropy.io.fits as apif
from stacking import stack_image
import matplotlib.pyplot as plt

iminfile="../EGS/data/fidel_egs_24_s1plus_v0.50_help.fits"
catinfile="../../../dmu16/dmu16_allwise/data/Allwise_PSF_stack_GAIA_EGS.fits"


im0=apif.open(iminfile)[1].data
hd=apif.open(iminfile)[1].header
cat=apif.open(catinfile)[1].data

#set nans to 0
ind=np.where(np.isnan(im0))
weight=np.ones(im0.shape)
weight[ind]=0

ra=cat.field('ra')
dec=cat.field('dec')
mag=cat.field('chi2w4_pm')

ind,=np.where(mag < 4)
#ind=ind[10:11]
ra=ra[ind]
dec=dec[ind]

print('ra',len(ra))
src_boost=False
##########################

StackCube, WeightCube, meanStack, varStack, stack, stack2,b1,sig1, mask, nsamp = stack_image(im0,hd,ra,dec,med=False,weight=weight,noFilt=False,mask=True,size=25,src_boost=src_boost)


print (b1)
print (sig1)

#plt.imshow(StackCube)
#plt.colorbar()
#plt.show()

print ('StackCube_shape:', StackCube)
print ('WeightCube_shape:', WeightCube)


plt.imshow(meanStack)
plt.colorbar()
plt.show()

plt.imshow(varStack)
plt.colorbar()
plt.show()

plt.imshow(nsamp)
plt.colorbar()
plt.show()

plt.imshow(mask)
plt.show()