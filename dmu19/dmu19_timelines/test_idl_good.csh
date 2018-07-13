#!/bin/bash
######################################################################
# Options for the batch system
# # These options are not executed by the script, but are instead read by the
# # batch system before submitting the job. Each option is preceeded by '#$' to
# # signify that it is for grid engine.
# #
# # All of these options are the same as flags you can pass to qsub on the
# # command line and can be **overriden** on the command line. see man qsub for
# # all the details
# ######################################################################
# # -- The shell used to interpret this script

#$ -S /bin/bash
#$ -q serial.q

# # -- Execute this job from the current working directory.
# # -- Job output to stderr will be merged into standard out. Remove this line if
# # -- you want to have separate stderr and stdout log files
# #$ -e /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/logs
# #$ -o /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/logs
# # -- Send email when the job exits, is aborted or suspended
# ######################################################################
# # We can pass arguments to this script like normal. Here we read in $1 if it is
# # available, otherwise, set the default value, ARG_DIGITS=10
#

source /research/astrodata2/fir/HELP/dmu_products/dmu19/dmu19_timelines/smap_herschel-stripe-82_test.csh
sleep 50
