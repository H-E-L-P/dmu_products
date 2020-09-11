DMU31 - Examples of using HELP tools
===========================

This folder contains example notebooks for using the HELP database. It will include examples of accessing data for the VO databases and the raw table files.

The VO can also be used with TopCat and stilts to do cross matching and other common table tasks. For instance a cross match can be performed at the command line with stilts:

"""shell
stilts tapskymatch tapurl=“https://herschel-vos.phys.sussex.ac.uk/__system__/tap/run/tap” taptable=“herschelhelp.main” taplon=RA taplat=DEC in=$PATH_TO_MY_TABLE.fits.gz inlon=RA inlat=DEC sr=1./3600. out=matches-help.fits
"""
