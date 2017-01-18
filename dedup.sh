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

# Now we are in the job-specific directory
module load picard-tools
PICARD=/srv/global/scratch/groups/sbs/picard-tools-2.1.0/picard.jar
shopt -s globstar
dir=$(echo "$GLOBAL_SCRATCH/AAA.TRIM/10/**")
#if [ ${dir: -4} == ".bam" ]; then
#[[ -d $dir ]] && continue # if directory then skip
#name=${dir%.*}
#echo $dir
java -jar $PICARD MarkDuplicates \
      I="$dir" \
      O=DHK_dedup.bam \
      METRICS_FILE=metrics.txt
#fi
#done
dir=$(echo "$GLOBAL_SCRATCH/AAA.TRIM/11/**")
#if [ ${dir: -4} == ".bam" ]; then
#[[ -d $dir ]] && continue # if directory then skip
#name=${dir%.*}
#echo $dir
java -jar $PICARD MarkDuplicates \
      I="$dir" \
      O=SAK_dedup.bam \
      METRICS_FILE=metrics.txt
#fi
#done
