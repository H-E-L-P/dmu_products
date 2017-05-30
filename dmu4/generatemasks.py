from herschelhelp_internal import starmask

fields= [
'AKARI-NEP',
'AKARI-SEP',
'Bootes',
'CDFS-SWIRE',
'COSMOS',
'EGS',
'ELAIS-N1',
'ELAIS-N2',
'ELAIS-S1',
'GAMA-09',
'GAMA-12',
'GAMA-15',
'HDF-N',
'Herschel-Stripe-82',
'Lockman-SWIRE',
'NGP',
'SA13',
'SGP',
'SPIRE-NEP',
'SSDF',
'xFLS',
'XMM-13hr',
'XMM-LSS']


for field in fields:
    starmask.create_starmask('../dmu0/dmu0_GAIA/data/GAIA_' + field + '.fits',
                             'dmu4_starmasks/starmask-' + field + '.reg')
    
    #starmask.ds9tomoc('dmu4_starmasks/starmask-GAIA_' + field + '.reg',
    #                  'dmu4_starmasks/starmask-GAIA_' + field + '_MOC.fits')