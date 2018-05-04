xid+, the probabilistic de-blender for Herschel SPIRE maps
==========================================================

XID+ is the next generation deblender tool for Herschel SPIRE maps. Its uses
a probabilistic framework which allows the use of prior information about the
sources. For further details, please see [Hurley et al.
2016](http://mnras.oxfordjournals.org/content/464/1/885).

XID+ is developed in it's own Github repository:
https://github.com/H-E-L-P/XID_plus/.

## Docker image
A docker image of xid+ is available on Peter Hurley's docker hub 
[https://hub.docker.com/r/pdh21/xidplus/](https://hub.docker.com/r/pdh21/xidplus/).

## Oracle Cloud compute and Docker swarm
We have mostly run xid+ on the University of Sussex's HPC, Apollo, using the Sun grid engine and job arrays for 
computing tiled areas of sky in parallel. However, in final months of project we were given access to Oracle 
Cloud computing. Here we ran xid+ using our docker image and docker swarm for parallel processing of tiles. For 
documented lists of setting up Oracle cloud compute instance and running docker swarm, see 
[dmu31_XIDplus_Oracle](dmu31_XIDplus_Oracle)

