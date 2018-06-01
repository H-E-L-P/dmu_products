#getting marco's code
# on my laptop
cd /Users/sjo/GitHub/dmu_products/dmu19/dmu19_timelines

rsync -va  scat@spire0.caltech.edu:/home/viero/smaproot/smap_pipeline/map_making/createmap/ .

rsync -va  scat@spire0.caltech.edu:/home/viero/smaproot/smap_pipeline/map_making/createmap/conffiles .

#getting data


cd /lustre/scratch/astro/sjo/data

screen

rsync -va  scat@spire0.caltech.edu:/data/spiredaq/reprocessed .
rsync -va  scat@spire0.caltech.edu:/data/scat/reprocessed_files.lis reprocessed/
# aborted to prioritise some small fields for testing

rsync -va  scat@spire0.caltech.edu:/data/spiredaq/reprocessed/XMM13hr_ntL1i reprocessed/


# remotely working at scat@spire0.caltech.edu

cd /data/spiredaq/reprocessed
du -kh . >! /data/scat/reprocessed_files.lis


