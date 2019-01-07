#!/bin/bash
#----------------------------------------------------------------------
# environment variable set up
#----------------------------------------------------------------------

export HOME="/data/scat"

echo setting up the environment for running SMAP code \(on IPAC spire machine\)

export GITHUB_DIR="/data/scat/GitHub/"


export IDL_PATH="<IDL_DEFAULT>"
export IDL_PATH=\+$GITHUB_DIR/smaproot/smap_pipeline/:${IDL_PATH}

export IDL_STARTUP=$GITHUB_DIR/dmu_products/dmu19/dmu19_timelines/smap_apollo_idl_startup.pro

#----------------------------------------------------------------------
# linking some directories and making sure others exist
#----------------------------------------------------------------------



export DATA_DIR=$GITHUB_DIR/dmu_products/dmu19/dmu19_timelines/data
export SMAP_DIR=$GITHUB_DIR/dmu_products/dmu19/dmu19_timelines/

printenv IDL_PATH
printenv IDL_STARTUP
printenv DATA_DIR
printenv GITHUB_DIR


#mkdir $DATA_DIR

ln -s /data/spiredaq/reprocessedd $DATA_DIR
#ln -s /lustre/scratch/astro/sjo/dmu_products/dmu19/dmu19_timelines/data/maps $DATA_DIR

