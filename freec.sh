#!/bin/sh
# qsub directives
#$ -S /bin/sh
#$ -wd /srv/global/scratch/carsweshau
# this should always be 1
#$ -l h_slots=1
# set the maximum run time for in seconds - 86400=1 day
#$ -l s_rt=86400
# the maximum memory you expect the job to use
#$ -l mem_total=24G
# the total virtual memory you want set aside for the job
#$ -l virtual_free=24G
# the number of threads (cores) you want allocated to the job
#$ -pe smp 32

if [ -d /srv/local/work/$JOB_ID ]; then
        cd /srv/local/work/$JOB_ID
else
        echo "There's no job directory to change into "
        echo "Here's LOCAL WORK "
        ls -la /srv/local/work
        echo "Exiting"
        exit 1
fi

# Now we are in the job-specific directory

i=1
while [ $i -le 9 ]; do
$GLOBAL_SCRATCH/FREEC/src/freec -conf config${i}.txt
i=$((i=i+1))
done
$GLOBAL_SCRATCH/FREEC/src/freec -conf configSAK.txt
$GLOBAL_SCRATCH/FREEC/src/freec -conf configDHK.txt

# Create a job-specific directory back on the
#  globally visible scratch area

#mkdir -p /srv/global/scratch/carsweshau/$JOB_ID

# Finally, move any local files you want to keep across to the scratch area
# before the job ends

# cp some_file.ext /srv/global/scratch/carsweshau/$JOB_ID
