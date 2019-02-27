
# In[1]:


import pylab
import pymoc
import xidplus
import numpy as np
get_ipython().run_line_magic('matplotlib', 'inline')
from astropy.table import Table
from astropy.io import fits
from astropy import wcs
import seaborn as sns


# This notebook uses all the raw data from the XID+MIPS catalogue, maps, PSF and relevant MOCs to create XID+ prior object and relevant tiling scheme

# ## Read in MOCs
# The selection functions required are the main MOC associated with the masterlist. As the prior for XID+ is based on IRAC detected sources coming from two different surveys at different depths (SPUDS and SWIRE) I will split the XID+ run into two different runs. Here we use the SWIRE depth.

# In[2]:


Sel_func=pymoc.MOC()
Sel_func.read('../../dmu4/dmu4_sm_XMM-LSS/data/holes_XMM-LSS_irac1_O16_20180420_MOC.fits')
SWIRE_MOC=pymoc.MOC()
SWIRE_MOC.read('../../dmu0/dmu0_DataFusion-Spitzer/data/Sub_wp4_xmm-lss_mips24_map_v1-1-_MOCmips_mosaic_MOC.fits')
Final=Sel_func.intersection(SWIRE_MOC)


# ## Read in XID+MIPS catalogue

# In[3]:


XID_MIPS=Table.read('../dmu26_XID+MIPS_XMM-LSS/data/dmu26_XID+MIPS_XMM-LSS_SWIREnSPUDS_concat_20190106.fits')


# In[4]:


XID_MIPS[0:10]


# In[5]:


skew=(XID_MIPS['FErr_MIPS_24_u']-XID_MIPS['F_MIPS_24'])/(XID_MIPS['F_MIPS_24']-XID_MIPS['FErr_MIPS_24_l'])
skew.name='(84th-50th)/(50th-16th) percentile'
use = skew < 5 
n_use=skew>5
g=sns.jointplot(x=np.log10(XID_MIPS['F_MIPS_24'][use]),y=skew[use] ,kind='hex')
print(np.max(skew[use]))
print(len(skew[n_use]))


# The uncertianties become Gaussian by $\sim 20 \mathrm{\mu Jy}$

# In[6]:


good=XID_MIPS['F_MIPS_24']>20


# In[7]:


good.sum()


# ## Read in Maps

# In[8]:


#im100fits='../../dmu18/dmu18_XMM-LSS/data/input_data/XMM-LSS_PACS100_20160728_img_wgls.fits'#PACS 100 map
#nim100fits='../../dmu18/dmu18_XMM-LSS/data/input_data/XMM-LSS_PACS100_20160728_img_noise.fits'#PACS 100 noise map
#im160fits='../../dmu18/dmu18_XMM-LSS/data/input_data/XMM-LSS_PACS160_20160728_img_wgls.fits'#PACS 160 map
#nim160fits='../../dmu18/dmu18_XMM-LSS/data/input_data/XMM-LSS_PACS160_20160728_img_noise.fits'#PACS 100 noise map

im100fits='../../dmu18/dmu18_XMM-LSS/data/input_data/XMM-LSS_PACS100_v0.9.fits'#PACS 100 map
im160fits='../../dmu18/dmu18_XMM-LSS/data/input_data/XMM-LSS_PACS160_v0.9.fits'#PACS 160 map

#output folder
output_folder='./'


# In[9]:


hdulist = fits.open(im100fits)
hdulist[0].header


# In[10]:


from astropy.io import fits
from astropy import wcs

#-----100-------------
hdulist = fits.open(im100fits)
im100phdu=hdulist['PRIMARY'].header
im100hdu=hdulist['IMAGE'].header
im100=hdulist['IMAGE'].data*1.0E9 #convert to mJy
w_100 = wcs.WCS(hdulist['IMAGE'].header)
pixsize100=3600.0*np.abs(hdulist['IMAGE'].header['CDELT1']) #pixel size (in arcseconds)

nim100=hdulist['ERROR'].data
hdulist.close()

#-----160-------------
hdulist = fits.open(im160fits)
im160phdu=hdulist['PRIMARY'].header
im160hdu=hdulist['IMAGE'].header
im160=hdulist['IMAGE'].data*1.0E9 #convert to mJy
w_160 = wcs.WCS(hdulist['IMAGE'].header)
pixsize160=3600.0*np.abs(hdulist['IMAGE'].header['CDELT1']) #pixel size (in arcseconds)

nim160=hdulist['ERROR'].data
hdulist.close()


# ## Read in PSF

# In[12]:


pacs100_psf=fits.open('../../dmu18/dmu18_XMM-LSS/dmu18_PACS_100_PSF_XMM-LSS_20190116.fits')
pacs160_psf=fits.open('../../dmu18/dmu18_XMM-LSS/dmu18_PACS_160_PSF_XMM-LSS_20190116.fits')

pacs100_psf['IMAGE'].header


# In[13]:


centre100=np.long((pacs100_psf[1].header['NAXIS1']-1)/2)
radius100=15
centre160=np.long((pacs160_psf[1].header['NAXIS1']-1)/2)
radius160=25

pind100=np.arange(0,radius100+1+radius100,1)*3600*np.abs(pacs100_psf[1].header['CDELT1'])/pixsize100 #get 100 scale in terms of pixel scale of map
pind160=np.arange(0,radius160+1+radius160,1)*3600*np.abs(pacs160_psf[1].header['CDELT1'])/pixsize160 #get 160 scale in terms of pixel scale of map


# In[14]:


print(pind100)


# In[15]:


import pylab as plt
plt.figure(figsize=(20,10))
plt.subplot(1,2,1)
plt.imshow(pacs100_psf[1].data[centre100-radius100:centre100+radius100+1,centre100-radius100:centre100+radius100+1])
plt.colorbar()
plt.subplot(1,2,2)
plt.imshow(pacs160_psf[1].data[centre160-radius160:centre160+radius160+1,centre160-radius160:centre160+radius160+1])
plt.colorbar()


# ## Set XID+ prior class

# In[ ]:


#---prior100--------
prior100=xidplus.prior(im100,nim100,im100phdu,im100hdu, moc=Final)#Initialise with map, uncertianty map, wcs info and primary header
prior100.prior_cat(XID_MIPS['RA'][good],XID_MIPS['Dec'][good],'dmu26_XID+MIPS_XMM-LSS_SWIREnSPUDS_concat_20190106.fits',ID=XID_MIPS['help_id'][good])#Set input catalogue
prior100.prior_bkg(0.0,5)#Set prior on background (assumes Gaussian pdf with mu and sigma)

#---prior160--------
prior160=xidplus.prior(im160,nim160,im160phdu,im160hdu, moc=Final)
prior160.prior_cat(XID_MIPS['RA'][good],XID_MIPS['Dec'][good],'dmu26_XID+MIPS_XMM-LSS_SWIREnSPUDS_concat_20190106.fits',ID=XID_MIPS['help_id'][good])
prior160.prior_bkg(0.0,5)


# In[ ]:


# Divide by 1000 so that units are mJy
prior100.set_prf(pacs100_psf[1].data[centre100-radius100:centre100+radius100+1,centre100-radius100:centre100+radius100+1]/1000.0,
                pind100,pind100)
prior160.set_prf(pacs160_psf[1].data[centre160-radius160:centre160+radius160+1,centre160-radius160:centre160+radius160+1]/1000.0,
                pind160,pind160)


# In[ ]:


import pickle
#from moc, get healpix pixels at a given order
from xidplus import moc_routines
order=11
tiles=moc_routines.get_HEALPix_pixels(order,prior100.sra,prior100.sdec,unique=True)
order_large=6
tiles_large=moc_routines.get_HEALPix_pixels(order_large,prior100.sra,prior100.sdec,unique=True)
print('----- There are '+str(len(tiles))+' tiles required for input catalogue and '+str(len(tiles_large))+' large tiles')
output_folder='./data/SWIRE/'
outfile=output_folder+'Master_prior.pkl'
with open(outfile, 'wb') as f:
    pickle.dump({'priors':[prior100,prior160],'tiles':tiles,'order':order,'version':xidplus.io.git_version()},f)
outfile=output_folder+'Tiles.pkl'
with open(outfile, 'wb') as f:
    pickle.dump({'tiles':tiles,'order':order,'tiles_large':tiles_large,'order_large':order_large,'version':xidplus.io.git_version()},f)
raise SystemExit()


# In[ ]:




