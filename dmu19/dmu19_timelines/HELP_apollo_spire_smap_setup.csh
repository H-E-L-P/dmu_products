#!/bin/bash
#----------------------------------------------------------------------
# environment variable set up
#----------------------------------------------------------------------

echo setting up the environment for running SMAP code \(on Sussex apollo machine\)

module load mps
module load idl

export GITHUB_DIR="/research/astrodata2/fir/HELP"


export IDL_PATH="<IDL_DEFAULT>"
export IDL_PATH=\+$GITHUB_DIR/smaproot/smap_pipeline/:${IDL_PATH}

export IDL_STARTUP=$GITHUB_DIR/dmu_products/dmu19/dmu19_timelines/smap_apollo_idl_startup.pro

#----------------------------------------------------------------------
# linking some directors and making sure others exist
#----------------------------------------------------------------------



export DATA_DIR=$GITHUB_DIR/dmu_products/dmu19/dmu19_timelines/data

printenv IDL_PATH
printenv IDL_STARTUP
printenv DATA_DIR
printenv GITHUB_DIR

#mkdir $DATA_DIR

#ln -s /lustre/scratch/astro/sjo/dmu_products/dmu19/dmu19_timelines/data/reprocessed $DATA_DIR
#ln -s /lustre/scratch/astro/sjo/dmu_products/dmu19/dmu19_timelines/data/maps $DATA_DIR

