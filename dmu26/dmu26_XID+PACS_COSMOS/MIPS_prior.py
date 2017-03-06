from astropy.io import fits
from astropy.table import Table,Column
import astropy.units as u
import numpy as np
WP3 = Table.read('COSMOS2015_Laigle+_v1.1_wHELPids_IRAC.fits.gz', format='fits')

ind=(WP3['FLAG_COSMOS']==1) & (WP3['FLAG_PETER']==0) 



WP3=WP3[ind]


ind=(WP3['SPLASH_1_FLUX'] > 1.0) | (WP3['SPLASH_2_FLUX'] > 1.0) | (WP3['SPLASH_3_FLUX'] > 1.0) |(WP3['SPLASH_4_FLUX'] > 1.0)
WP3=WP3[ind]

nsrc=WP3['help_id'].size
MIPS_lower=np.full(nsrc,0.1)
MIPS_upper=np.full(nsrc,1E3)



for i in np.arange(0.0,nsrc):
    if WP3['SPLASH_2_FLUX'][i] >0.0:
        MIPS_lower[i]=WP3['SPLASH_2_FLUX'][i]/500.0
        MIPS_upper[i]=WP3['SPLASH_2_FLUX'][i]*500.0



col1 = Column(name='MIPS_lower_prior', data=MIPS_lower*u.Jansky*1E-6,)
col2 = Column(name='MIPS_upper_prior', data=MIPS_upper*u.Jansky*1E-6,)

WP3.add_column(col1)
WP3.add_column(col2)
WP3.write('WP3_COSMOS_MIPS_prior_20160613.fits', format='fits',overwrite=True)
