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
module load gatk
module load picard-tools
GATK=/srv/global/scratch/groups/sbs/GATK/3.5.0/GenomeAnalysisTK.jar
PICARD=/srv/global/scratch/groups/sbs/picard-tools-2.1.0/picard.jar
#GQ=(93 92 93 98 92 92 94 94 92 92 92 92) #GQ FOR ANDY1...ANDY13
#ANDY_COUNT=10 # <-- CHANGE THIS TO 10
#GQ_COUNT=8 # < -- CHANGE THIS TO 8
#while [ $ANDY_COUNT -le 13 ]; do # <-- CHANGE THIS TO 13
java -jar $GATK \
    -T VariantFiltration \
    -R $GLOBAL_SCRATCH/hg38.fa \
    -V $GLOBAL_SCRATCH/raw_pooled_GVCF.vcf \
    --filterExpression "QD < 10.0 || FS > 40.0 || MQ < 59.0 || SOR > 2.0 || MQRankSum < -4.0 || ReadPosRankSum < -3.0 || DP < 30 || GQ < 98 || DP < 30 && GQ < 98" \
    -o $GLOBAL_SCRATCH/filtered_call_merged.vcf

java -jar $GATK \
	-R $GLOBAL_SCRATCH/hg38.fa \
	-T SelectVariants \
	--variant $GLOBAL_SCRATCH/filtered_call_merged.vcf \
	-o $GLOBAL_SCRATCH/restricted_filtered_call_merged.vcf \
	-L $GLOBAL_SCRATCH/UCSC.interval_list

java -jar $PICARD CollectVariantCallingMetrics I=$GLOBAL_SCRATCH/restricted_filtered_call_merged.vcf DBSNP=$GLOBAL_SCRATCH/1000G_phase1.snps.high_confidence.hg38.pl.vcf O=$GLOBAL_SCRATCH/call_merged_metrics
#ANDY_COUNT=$((ANDY_COUNT=ANDY_COUNT+1))
#GQ_COUNT=$((GQ_COUNT=GQ_COUNT+1))
#done
