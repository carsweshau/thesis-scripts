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
module load blast+/2.4.0
cd /srv/global/scratch/groups/sbs/NCBI_BLAST/nt

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/1/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/1/andy1_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/2/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/2/andy2_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/3/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/3/andy3_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/4/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/4/andy4_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/5/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/5/andy5_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/6/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/6/andy6_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/7/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/7/andy7_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/8/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/8/andy8_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/10/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/10/andy10_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/11/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/11/andy11_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/12/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/12/andy12_cln3.blast

awk -F' ' '{printf(">%s/%s\n%s\n",$1,(and(int($2),0x40)?1:2),$10);}' $GLOBAL_SCRATCH/AAA.TRIM/13/*cln3.bam | blastn -db nt -out $GLOBAL_SCRATCH/AAA.TRIM/13/andy13_cln3.blast
