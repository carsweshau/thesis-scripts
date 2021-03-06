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
    -T VariantFiltration \
    -R $GLOBAL_SCRATCH/hg38.fa \
    -V $GLOBAL_SCRATCH/raw_indels.vcf \
    --filterExpression "QD < 2.0 || FS > 500.0 || SOR > 10.0 || ReadPosRankSum < -8.0 || InbreedingCoeff < -0.8" \
    --filterName "QD:2,FS:500,SOR:10,RPRS:-8,InbreedingCoeff:-0.8" \
    -o $GLOBAL_SCRATCH/filtered_indels.vcf
