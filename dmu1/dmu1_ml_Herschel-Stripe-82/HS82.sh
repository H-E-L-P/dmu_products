######################################################################
# -- The shell used to interpret this script
#$ -S /bin/bash
# -- Execute this job from the current working directory.
#$ -cwd
# -- Job output to stderr will be merged into standard out. Remove this line if
# -- you want to have separate stderr and stdout log files
#$ -j y
# #$ -o output/
# -- Send email when the job exits, is aborted or suspended
#$ -m eas
#$ -M raphael.shirley@sussex.ac.uk

## source /research/astro/fir/apps/python_fir/bin/activate
export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin:$PATH"
~/.bash_profile
# source activate herschelhelp_internal


# python -V
# module list
# python -m ipykernel install --user --name helpint --display-name "Python (herschelhelp_internal)"
# jupyter kernelspec list
# echo $USER

# conda info --envs

#/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.1_HSC-SSP.ipynb --output 1.1-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.2_*.ipynb --output 1.2-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.3_*.ipynb --output 1.3-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.4_*.ipynb --output 1.4-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.5_*.ipynb --output 1.5-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.6_*.ipynb --output 1.6-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.7_*.ipynb --output 1.7-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.8_*.ipynb --output 1.8-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.9_*.ipynb --output 1.9-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 1.10_*.ipynb --output 1.10-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 2.1_*.ipynb --output 2.1-out.ipynb --ExecutePreprocessor.kernel_name=helpint

/usr/bin/time -o trace -a -f '%C %M kb %e s' jupyter nbconvert --to notebook --execute --ExecutePreprocessor.timeout=-1 2.2_*.ipynb --output 2.2-out.ipynb --ExecutePreprocessor.kernel_name=helpint
 

