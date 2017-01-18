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
java -jar $GATK \
   -T GenotypeGVCFs \
   -R $GLOBAL_SCRATCH/hg38.fa \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/1/ANDY_1.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/2/ANDY_2.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/3/ANDY_3.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/4/ANDY_4.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/5/ANDY_5.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/6/ANDY_6.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/7/ANDY_7.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/8/ANDY_8.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/10/ANDY_10.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/11/ANDY_11.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/12/ANDY_12.raw.snps.indels.g.vcf \
   --variant $GLOBAL_SCRATCH/AAA.TRIM/13/ANDY_13.raw.snps.indels.g.vcf \
   -o $GLOBAL_SCRATCH/raw_pooled_GVCF.vcf
