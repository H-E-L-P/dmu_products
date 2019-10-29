
# coding: utf-8

# # XID+PACS NGP Prior

# In[1]:


import pylab
import pymoc
import xidplus
import numpy as np
get_ipython().run_line_magic('matplotlib', 'inline')
from astropy.table import Table , join
from mocpy import MOC
from astropy.io import fits
from astropy import wcs


# In[2]:


import seaborn as sns


# This notebook uses all the raw data from the XID+PACS catalogue, maps, PSF and relevant MOCs to create XID+ prior object and relevant tiling scheme

# ## Read in MOCs
# The selection functions required are the main MOC associated with the masterlist. As the prior for XID+ is based on IRAC detected sources.

# In[ ]:


Sel_func=pymoc.MOC()
Sel_func.read('../../dmu4/dmu4_sm_NGP/data/holes_NGP_ukidss_k_O16_20190204_MOC.fits')

filename='../../dmu18/dmu18_HELP-PACS-maps/data/NGP_PACS100_v0.9.fits'
hdulist = fits.open(filename)
im100phdu=hdulist['IMAGE'].header
ngp_moc=MOC.from_image(im100phdu, 13)
ngp_moc.write('./data/ngp_moc.fits')



im_moc=pymoc.MOC()
im_moc.read('./data/ngp_moc.fits')

Final=Sel_func.intersection(im_moc)


# In[ ]:


#Final.write('./data/testMoc.fits', overwrite=True)
#Final=pymoc.MOC()
#Final.read('./data/testMoc.fits')


# ## Read in CIGALE predictions catalogue

# In[14]:


cigale=Table.read('../../dmu28/dmu28_NGP/data/NGP_results_Ldust_prediction.fits')


# In[5]:


cigale['id'].name = 'help_id'


# In[15]:


cigale


# ## Read in photoz

# In[ ]:


photoz=Table.read('../../dmu24/dmu24_NGP/data/master_catalogue_ngp_20180501_photoz_20180601_r_optimised.fits')


# In[ ]:


photoz


# ## Join CIGALE and photoz tables

# In[ ]:


prior=join(cigale,photoz,keys='help_id')


# In[ ]:


from astropy.cosmology import Planck15 as cosmo
from astropy import units as u
f_pred=prior['bayes.dust.luminosity']/(4*np.pi*cosmo.luminosity_distance(prior['z1_median']).to(u.cm))


# In[ ]:


prior=prior[np.isfinite(f_pred.value)][np.log10(f_pred.value[np.isfinite(f_pred.value)])>8.5]


# In[ ]:


prior['DEC'].name='Dec'


# ## Read in Maps

# In[10]:


PACS_100='../../dmu18/dmu18_HELP-PACS-maps/data/NGP_PACS100_v0.9.fits'
PACS_160='../../dmu18/dmu18_HELP-PACS-maps/data/NGP_PACS160_v0.9.fits'
#output folder
output_folder='./'


# In[11]:


from astropy.io import fits
from astropy import wcs

#-----100-------------
hdulist = fits.open(im100fits)
im100phdu=hdulist['PRIMARY'].header
im100=hdulist['IMAGE'].data*2.35045e-5*(np.abs(hdulist[1].header['CDELT1'])*3600)**2
hdulist['IMAGE'].header['BUNIT']='Jy/pix'
im100hdu=hdulist['IMAGE'].header

w_100 = wcs.WCS(hdulist['IMAGE'].header)
pixsize100=3600.0*np.abs(hdulist['IMAGE'].header['CDELT1']) #pixel size (in arcseconds)
nim100=hdulist['ERROR'].data*2.35045e-5*(np.abs(hdulist[1].header['CDELT1'])*3600)**2

hdulist.close()

#-----160-------------
hdulist = fits.open(im160fits)
im160phdu=hdulist['PRIMARY'].header
im160=hdulist['IMAGE'].data*2.35045e-5*(np.abs(hdulist[1].header['CDELT1'])*3600)**2
hdulist['IMAGE'].header['BUNIT']='Jy/pix'
im160hdu=hdulist['IMAGE'].header

w_160 = wcs.WCS(hdulist['IMAGE'].header)
pixsize160=3600.0*np.abs(hdulist['IMAGE'].header['CDELT1']) #pixel size (in arcseconds)
nim160=hdulist['ERROR'].data*2.35045e-5*(np.abs(hdulist[1].header['CDELT1'])*3600)**2
hdulist.close()


# ## Read in PSF

# In[12]:


pacs100_psf=fits.open('../../dmu18/dmu18_NGP/dmu18_PACS_100_PSF_NGP_20190125.fits')
pacs160_psf=fits.open('../../dmu18/dmu18_NGP/dmu18_PACS_160_PSF_NGP_20190125.fits')

centre100=np.long((pacs100_psf[0].header['NAXIS1']-1)/2)
radius100=15
centre160=np.long((pacs160_psf[0].header['NAXIS1']-1)/2)
radius160=25

pind100=np.arange(0,radius100+1+radius100,1)*3600*np.abs(pacs100_psf[0].header['CDELT1'])/pixsize100 #get 100 scale in terms of pixel scale of map
pind160=np.arange(0,radius160+1+radius160,1)*3600*np.abs(pacs160_psf[0].header['CDELT1'])/pixsize160 #get 160 scale in terms of pixel scale of map


# In[13]:


print(pind100)


# In[14]:


import pylab as plt
plt.figure(figsize=(20,10))
plt.subplot(1,2,1)
plt.imshow(pacs100_psf[1].data[centre100-radius100:centre100+radius100+1,centre100-radius100:centre100+radius100+1])
plt.colorbar()
plt.subplot(1,2,2)
plt.imshow(pacs160_psf[1].data[centre160-radius160:centre160+radius160+1,centre160-radius160:centre160+radius160+1])
plt.colorbar()


# ## Set XID+ prior class

# In[15]:


#---prior100--------
prior100=xidplus.prior(im100,nim100,im100phdu,im100hdu, moc=Final)#Initialise with map, uncertianty map, wcs info and primary header
prior100.prior_cat(prior_cat(prior['RA'] ,prior['Dec'] ,'NGP_results_Ldust_prediction.fits',ID=prior['help_id'])#Set input catalogue
prior100.prior_bkg(0.0,5)#Set prior on background (assumes Gaussian pdf with mu and sigma)

#---prior160--------
prior160=xidplus.prior(im160,nim160,im160phdu,im160hdu, moc=Final)
prior160.prior_cat(prior_cat(prior['RA'] ,prior['Dec'] ,'NGP_results_Ldust_prediction.fits',ID=prior['help_id'])
prior160.prior_bkg(0.0,5)


# In[16]:


# Divide by 1000 so that units are mJy
prior100.set_prf(pacs100_psf[0].data[centre100-radius100:centre100+radius100+1,centre100-radius100:centre100+radius100+1]/1000.0,
                pind100,pind100)
prior160.set_prf(pacs160_psf[0].data[centre160-radius160:centre160+radius160+1,centre160-radius160:centre160+radius160+1]/1000.0,
                pind160,pind160)


# In[17]:


import pickle
#from moc, get healpix pixels at a given order
from xidplus import moc_routines
order=11
tiles=moc_routines.get_HEALPix_pixels(order,prior100.sra,prior100.sdec,unique=True)
order_large=6
tiles_large=moc_routines.get_HEALPix_pixels(order_large,prior100.sra,prior100.sdec,unique=True)
print('----- There are '+str(len(tiles))+' tiles required for input catalogue and '+str(len(tiles_large))+' large tiles')
output_folder='./data/'
xidplus.io.pickle_dump({'priors':[prior100,prior160],'tiles':tiles,'order':order,'version':xidplus.io.git_version()},'Master_prior.pkl')
outfile=output_folder+'Tiles.pkl'
with open(outfile, 'wb') as f:
    pickle.dump({'tiles':tiles,'order':order,'tiles_large':tiles_large,'order_large':order_large,'version':xidplus.io.git_version()},f)
raise SystemExit()


# In[18]:


ls -ltrh
