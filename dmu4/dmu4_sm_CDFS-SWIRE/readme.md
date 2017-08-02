# Star masks and holes on CDFS-SWIRE

This folder contains the region files and MOCS that aid identification of artefacts and
missing sources in the masterlist.

For each detection band, the IDL code identifies the radius at which the source density 
goes above 50% of the background in a 0.5 mag magnitude bin and then fits a linear relation in log space. This is used to define a 'hole' in which sources are not detected 
around bright stars. As a default we only provide holes for stars above magnitude 18.


