# ![HELP LOGO](https://avatars1.githubusercontent.com/u/7880370?s=75&v=4) HELP dmu 25 Prior Model

The HELP XID+ data products require a prior list of sources to run. Our choice of prior list 
is dependent on the field and band.
 
 For example
 * XID+MIPS uses an sources from the masterlist that are detected in Spitzer IRAC and either optical or near infrared.
 * XID+SPIRE (where MIPS is also available) uses sources with an XID+MIPS detection
 * XID+PACS (where MIPS is also available) uses sources with an XID+MIPS detection
 * For larger fields with no MIPS, a flux cut on prior sources is made from taking $L_{dust}$ predictions from CIGALE and photometric redshifts.

The prior decisions for each field and band are described in the relevant notebook in dmu26.

## Advanced SED prior
XID+ has been developed such that additional model complexity can be added.

XID+SED is an extension that uses SED templates and photometric redshift priors to fit the MIPS and SPIRE maps.
This available as part of the [XID+ software](www.herschel.sussex.ac.uk) and demonstrated in the paper Hurley et al. 2018.