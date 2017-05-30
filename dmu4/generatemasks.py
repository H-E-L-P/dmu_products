from herschelhelp_internal import starmask

fields= [
'AKARI-NEP.fits',
'AKARI-SEP.fits',
'Bootes.fits',
'CDFS-SWIRE.fits',
'COSMOS.fits',
'EGS.fits',
'ELAIS-N1.fits',
'ELAIS-N2.fits,
'ELAIS-S1.fits','
'GAMA-09.fits',
'GAMA-12.fits',
'GAMA-15.fits',
'HDF-N.fits',
'Herschel-Stripe-82.fits',
'Lockman-SWIRE.fits',
'NGP.fits',
'SA13.fits',
'SGP.fits',
'SPIRE-NEP.fits',
'SSDF.fits',
'xFLS.fits',
'XMM-13hr',
'XMM-LSS']


for field in fields:
    starmask.create_starmask('../dmu0/dmu0_GAIA/data/GAIA_' + field + '.fits',
                             'dmu4_starmasks/starmask-GAIA_' + field + '.reg')
    
    #starmask.ds9tomoc('dmu4_starmasks/starmask-GAIA_' + field + '.reg',
    #                  'dmu4_starmasks/starmask-GAIA_' + field + '_MOC.fits')