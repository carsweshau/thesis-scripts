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
GATK=/srv/global/scratch/groups/sbs/GATK/3.5.0/GenomeAnalysisTK.jar
java -jar $GATK \
   -T CombineGVCFs \
   -R $GLOBAL_SCRATCH/hg38.fa \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy1.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy2.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy3.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy4.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy5.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy6.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy7.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy8.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy10.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy11.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy12.vcf \
   --variant $GLOBAL_SCRATCH/restricted_filtered_call_andy13.vcf \
   -o $GLOBAL_SCRATCH/restricted_filtered_call_merged.vcf
