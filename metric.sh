#!/bin/sh
# qsub directives
#$ -S /bin/sh
#$ -wd /srv/global/scratch/carsweshau
# this should always be 1
#$ -l h_slots=1
# set the maximum run time for in seconds - 86400=1 day
#$ -l s_rt=43200
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

module load picard-tools
PICARD=/srv/global/scratch/groups/sbs/picard-tools-2.1.0/picard.jar
ANDY_COUNT=1
while [ $ANDY_COUNT -le 13 ]; do
SAMPLE=Andy${ANDY_COUNT}
if [ $ANDY_COUNT -eq 10 ]; then
	SAMPLE="DHK"
fi
if [ $ANDY_COUNT -eq 11 ]; then
	SAMPLE="SAK"
fi
if [ $ANDY_COUNT -eq 12 ]; then
	SAMPLE="TAF"
fi
if [ $ANDY_COUNT -eq 13 ]; then
	SAMPLE="TEF"
fi
java -jar $PICARD CollectVariantCallingMetrics I=$GLOBAL_SCRATCH/raw_andy${ANDY_COUNT}.vcf DBSNP=$GLOBAL_SCRATCH/1000G_phase1.snps.high_confidence.hg38.pl.vcf GVCF_INPUT=true O=$GLOBAL_SCRATCH/andy${ANDY_COUNT}_raw_metrics
ANDY_COUNT=$((ANDY_COUNT=ANDY_COUNT+1))
done

