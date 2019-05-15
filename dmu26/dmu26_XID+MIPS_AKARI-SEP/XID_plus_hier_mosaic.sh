#! /bin/bash
#$ -S /bin/bash
#$ -o /its/home/mc741/git_hub/dmu_products/log/out
#$ -e /its/home/mc741/git_hub/dmu_products/log/err
cd /its/home/mc741/git_hub/dmu_products/dmu26/dmu26_XID+MIPS_AKARI-SEP/data/
echo "this is from the run script"

export PATH="/research/astro/fir/HELP/help_python/miniconda3/bin/":$PATH

module load use.own
module load fir/software

# Check folders 

ls -d */ > folders_file.dat
folder_list=$(sort -n folders_file.dat)
#delete=(output/)
#folder_list=( "${folder_list[@]/$delete}" )

echo ${folders}

# Read in number of large_tiles

c=0
echo "CREATING ARRAY"
taskArray=()
while read line
do
taskArray[$c]=$line # store line
c=$(($c + 1)) # increase counter by 1
done < large_tiles.csv


# Run hier on every SEIP-mosaic (folder)
echo "Iterating over folders"

n=0
folders=()
for folder in $folder_list; do
   cd $folder
   #echo ${folder::-1}
   SGE_TASK_ID=${taskArray[@]:n+1:1}
   export SGE_TASK_ID
   python ../../hierarchical.py $SGE_TASK_ID
   cd ..
   n=$(($n+1))
done

