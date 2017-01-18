#!/bin/sh
# qsub directives
#$ -S /bin/sh
#$ -wd /srv/global/scratch/carsweshau
# this should always be 1
#$ -l h_slots=1
# set the maximum run time for in seconds - 86400=1 day
#$ -l s_rt=345600
# the maximum memory you expect the job to use
#$ -l mem_total=24G
# the total virtual memory you want set aside for the job
#$ -l virtual_free=24G
# the number of threads (cores) you want allocated to the job
#$ -pe smp 24
#$ -M carsweshau@myvuw.ac.nz

if [ -d /srv/local/work/$JOB_ID ]; then
        cd /srv/local/work/$JOB_ID
else
        echo "There's no job directory to change into "
        echo "Here's LOCAL WORK "
        ls -la /srv/local/work
        echo "Exiting"
        exit 1
fi
module load gatk
GATK=/srv/global/scratch/groups/sbs/GATK/3.5.0/GenomeAnalysisTK.jar
ANDY_COUNT=1
while [ $ANDY_COUNT -le 13 ]; do
for f in $GLOBAL_SCRATCH/AAA.TRIM/$ANDY_COUNT/*.recal.bam; do
java -jar $GATK \
     -T CallableLoci \
     -R $GLOBAL_SCRATCH/hg38.fa \
     -I $f \
     -summary table.txt \
     -o $GLOBAL_SCRATCH/AAA.TRIM/$ANDY_COUNT/callable_status.bed
done
ANDY_COUNT=$((ANDY_COUNT=ANDY_COUNT+1))
done
