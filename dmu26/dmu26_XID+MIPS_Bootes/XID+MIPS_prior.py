#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pylab
import pymoc
import xidplus
import numpy as np
get_ipython().run_line_magic('matplotlib', 'inline')


# In[ ]:





# This notebook uses all the raw data from the masterlist, maps, PSF and relevant MOCs to create XID+ prior object and relevant tiling scheme

# ## Read in MOCs
# The selection functions required are the main MOC associated with the masterlist. Here we use the DataFusion-Spitzer MOC.

# In[2]:


Sel_func=pymoc.MOC()
Sel_func.read('../../dmu4/dmu4_sm_Bootes/data/holes_Bootes_irac_i1_O16_20180424.fits')
SWIRE_MOC=pymoc.MOC()
SWIRE_MOC.read('../../dmu0/dmu0_DataFusion-Spitzer/data/Datafusion-Bootes_MOC.fits')


# In[3]:


Final=Sel_func.intersection(SWIRE_MOC)


# In[4]:


#Final.write('./data/testMoc.fits', overwrite=True)


# ## Read in Masterlist
# Next step is to read in Masterlist and select only sources that are detected in mid-infrared and at least one other wavelength domain (i.e. optical or nir). This will remove most of the objects in the catalogue that are artefacts. We can do this by using the `flag_optnir_det` flag and selecting sources that have a binary value of $>= 5$

# In[5]:


from astropy.io import fits
masterfile='master_catalogue_bootes_20180520.fits'
masterlist=fits.open('../../dmu1/dmu1_ml_Bootes/data/'+masterfile)


# In[6]:


good=masterlist[1].data['flag_optnir_det']>=5


# ### Create uninformative (i.e. conservative) upper and lower limits based on IRAC fluxes
# As the default flux prior for XID+ is a uniform distribution, it makes sense to set reasonable upper and lower 24 micron flux limits based on the longest wavelength IRAC flux available. For a lower limit I take IRAC/500.0 and for upper limit I take IRACx500.

# In[7]:


MIPS_lower=np.full(good.sum(),0.0)
MIPS_upper=np.full(good.sum(),1E5)


# In[8]:


#masterlist[1].header


# In[9]:


#for i in range(0,good.sum()):
#    if masterlist[1].data['flag_irac4'][good][i]>0:
#        MIPS_lower[i]=masterlist[1].data['f_irac4'][good][i]/500.0
#        MIPS_upper[i]=masterlist[1].data['f_irac4'][good][i]*500.0
#    elif masterlist[1].data['flag_irac3'][good][i]>0:
#        MIPS_lower[i]=masterlist[1].data['f_irac3'][good][i]/500.0
#        MIPS_upper[i]=masterlist[1].data['f_irac3'][good][i]*500.0
#    elif masterlist[1].data['flag_irac2'][good][i]>0:
#        MIPS_lower[i]=masterlist[1].data['f_irac2'][good][i]/500.0
#        MIPS_upper[i]=masterlist[1].data['f_irac2'][good][i]*500.0
#    elif masterlist[1].data['flag_irac1'][good][i]>0:
#        MIPS_lower[i]=masterlist[1].data['f_irac1'][good][i]/500.0
#        MIPS_upper[i]=masterlist[1].data['f_irac1'][good][i]*500.0


# In[10]:


for i in range(0,good.sum()):
    if ~np.isnan(masterlist[1].data['f_irac_i4'][good][i]):
        MIPS_lower[i]=masterlist[1].data['f_irac_i4'][good][i]/500.0
        MIPS_upper[i]=masterlist[1].data['f_irac_i4'][good][i]*500.0
    elif ~np.isnan(masterlist[1].data['f_irac_i3'][good][i]):
        MIPS_lower[i]=masterlist[1].data['f_irac_i3'][good][i]/500.0
        MIPS_upper[i]=masterlist[1].data['f_irac_i3'][good][i]*500.0
    elif ~np.isnan(masterlist[1].data['f_irac_i2'][good][i]):
        MIPS_lower[i]=masterlist[1].data['f_irac_i2'][good][i]/500.0
        MIPS_upper[i]=masterlist[1].data['f_irac_i2'][good][i]*500.0
    elif ~np.isnan(masterlist[1].data['f_irac_i1'][good][i]):
        MIPS_lower[i]=masterlist[1].data['f_irac_i1'][good][i]/500.0
        MIPS_upper[i]=masterlist[1].data['f_irac_i1'][good][i]*500.0


# In[ ]:





# In[13]:


len(MIPS_upper)


# ## Read in Map
# We are now ready to read in the MIPS map
# 

# In[ ]:


MIPS_Map=fits.open('../../dmu17/dmu17_HELP_Legacy_Maps/Bootes/data/input_data/wp4_bootes_mips24_map_v1.0.fits.gz')


# ## Read in PSF

# In[ ]:


MIPS_psf=fits.open('../../dmu17/dmu17_HELP_Legacy_Maps/Bootes/data/output_data/dmu17_MIPS_PSF_Bootes_20180129.fits')


# In[ ]:


MIPS_psf=fits.open('../../dmu17/dmu17_HELP_Legacy_Maps/Bootes/data/output_data/dmu17_MIPS_PSF_Bootes_20180129.fits')


# In[ ]:


centre=np.long((MIPS_psf[1].header['NAXIS1']-1)/2)
radius=20


# In[ ]:


import pylab as plt
plt.imshow(np.log10(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1]/np.max(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1])))
plt.colorbar()


# ## Set XID+ prior class

# In[ ]:


prior_MIPS=xidplus.prior(MIPS_Map[1].data,MIPS_Map[2].data,MIPS_Map[0].header,MIPS_Map[1].header,moc=Final)
prior_MIPS.prior_cat(masterlist[1].data['ra'][good],masterlist[1].data['dec'][good],masterfile,flux_lower=MIPS_lower,
                     flux_upper=MIPS_upper,ID=masterlist[1].data['help_id'][good])


# In[ ]:


prior_MIPS.set_prf(MIPS_psf[1].data[centre-radius:centre+radius+1,centre-radius:centre+radius+1]/1.0E6,np.arange(0,41/2.0,0.5),np.arange(0,41/2.0,0.5))


# ## Calculate tiles
# As fitting the whole map would be too computationally expensive, I split based on HEALPix pixels. For MIPS, the optimum order is 11. So that I don't have to read the master prior based on the whole map into memory each time (which requires a lot more memory) I also create another layer of HEALPix pixels based at the lower order of 6.

# In[ ]:


import pickle
#from moc, get healpix pixels at a given order
from xidplus import moc_routines
order=11
tiles=moc_routines.get_HEALPix_pixels(order,prior_MIPS.sra,prior_MIPS.sdec,unique=True)
order_large=6
tiles_large=moc_routines.get_HEALPix_pixels(order_large,prior_MIPS.sra,prior_MIPS.sdec,unique=True)
print('----- There are '+str(len(tiles))+' tiles required for input catalogue and '+str(len(tiles_large))+' large tiles')
output_folder='./data/'
outfile=output_folder+'Master_prior.pkl'
with open(outfile, 'wb') as f:
    pickle.dump({'priors':[prior_MIPS],'tiles':tiles,'order':order,'version':xidplus.io.git_version()},f)
outfile=output_folder+'Tiles.pkl'
with open(outfile, 'wb') as f:
    pickle.dump({'tiles':tiles,'order':order,'tiles_large':tiles_large,'order_large':order_large,'version':xidplus.io.git_version()},f)
raise SystemExit()


# In[ ]:


prior_MIPS.nsrc


# In[ ]:




