#!/bin/sh
# qsub directives
#$ -S /bin/sh
#$ -wd /srv/global/scratch/carsweshau
# this should always be 1
#$ -l h_slots=1
# set the maximum run time for in seconds - 86400=1 day
#$ -l s_rt=545600
# the maximum memory you expect the job to use
#$ -l mem_total=32G
# the total virtual memory you want set aside for the job
#$ -l virtual_free=32G
# the number of threads (cores) you want allocated to the job
#$ -pe smp 32
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
ANDY_COUNT=12
while [ $ANDY_COUNT -le 13 ]; do
for f in $GLOBAL_SCRATCH/AAA.TRIM/$ANDY_COUNT/*dedup.bam; do
java -jar $GATK \
   -T BaseRecalibrator \
   -R $GLOBAL_SCRATCH/hg38.fa \
   -I $f \
   -knownSites $GLOBAL_SCRATCH/dbsnp_148_sorted.vcf \
   -o $GLOBAL_SCRATCH/AAA.TRIM/$ANDY_COUNT/Andy${ANDY_COUNT}_recal_data.table
java -jar $GATK \
   -T PrintReads \
   -R $GLOBAL_SCRATCH/hg38.fa \
   -I $f \
   -BQSR $GLOBAL_SCRATCH/AAA.TRIM/$ANDY_COUNT/Andy${ANDY_COUNT}_recal_data.table \
   -o $GLOBAL_SCRATCH/AAA.TRIM/$ANDY_COUNT/ANDY_${ANDY_COUNT}.merged.dedup.recal.bam
done
ANDY_COUNT=$((ANDY_COUNT=ANDY_COUNT+1))
done
