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
#WRK_DIR=$GLOBAL_SCRATCH/AAA.TRIM/10
#cd $WRK_DIR
module load bwa-kit
#for f in *.fastq; do
#STEM=$(basename "${f}" .fastq);
#bwa mem -Mp $GLOBAL_SCRATCH/hg38.fa $f > ${STEM}.sam
#done
WRK_DIR=$GLOBAL_SCRATCH/AAA.TRIM/11
cd $WRK_DIR
for f in *.fastq; do
STEM=$(basename "${f}" .fastq);
bwa mem -Mp $GLOBAL_SCRATCH/hg38.fa $f > ${STEM}.sam
done
