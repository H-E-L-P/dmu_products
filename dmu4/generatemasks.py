from herschelhelp_internal import starmask

#Field names plus ra dec of first circle
fields= [
['AKARI-NEP', 274.654402036, 65.7962520276],
['AKARI-SEP', 72.2316923316, -54.380443672],
['Bootes', 216.431700722, 32.401081899],
['CDFS-SWIRE', 51.0227099923, -29.8185285737],
['COSMOS', 149.295925951, 1.08212668291],
['EGS', 217.276981956, 53.6441519854],
['ELAIS-N1', 247.096600963, 55.1757687739],
['ELAIS-N2', 248.424493154, 39.1274077489],
['ELAIS-S1', 7.10625839472, -43.8632559768],
['GAMA-09', 129.076050945, -2.23171513025],
['GAMA-12', 172.84437099, -0.482115877707],
['GAMA-15', 211.756497623, -2.28573712848],
['HDF-N', 190.259734752, 62.205265532],
['Herschel-Stripe-82', 353.751913281, -7.10891111165],
['Lockman-SWIRE', 161.942787703, 59.0563805825],
['NGP', 192.899559129, 22.0990890388],
['SA13', 197.895801254, 42.4400105492],
['SGP', 334.297748942, -34.5037863499],
['SPIRE-NEP', 266.334305546, 68.7904496043],
['SSDF', 341.577544902, -59.1868365369],
['xFLS', 261.387059958, 58.0184602211],
['XMM-13hr', 203.318355937, 37.4745777866],
['XMM-LSS', 32.9413834032, -6.02293494708]]


for field in fields:
    #starmask.create_starmask('../dmu0/dmu0_GAIA/data/GAIA_' + field + '.fits',
    #                         'dmu4_starmasks/starmask-' + field + '.reg')
    
    starmask.reg2moc('dmu4_starmasks/starmask-' + field + '.reg',
                      'dmu4_fieldmocs/' + field + '_MOC.fits',
                      'dmu4_starmasks/starmask-' + field + '_MOC.fits',
                      order=14)