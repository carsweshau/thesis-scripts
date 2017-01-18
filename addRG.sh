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

module load picard-tools
PICARD=/srv/global/scratch/groups/sbs/picard-tools-2.1.0/picard.jar
shopt -s globstar
for dir in $GLOBAL_SCRATCH/AAA.TRIM/12/MERGE/*bam;do # dir == full path to ALL files in AAA.TRIM
# e.g. /srv/global/scratch/carsweshau/AAA.TRIM/9/L8.ACTGAT/Andy9_L8_ACTGAT_Lib9.bam
[[ -d $dir ]] && continue # if directory then skip
if [ ${dir: -4} == ".bam" ]; then
name=${dir%.*} # removes extension
filename=${dir##*/} # removes path prefix
filenoext=${name##*/}
sep=$(echo $filenoext | tr "_" "\n")
infor=( $sep ) # ${infor[2]} corresponds to ACTGAT in the above example
sample=${infor[0]}
unit=${infor[1]}
library=${infor[3]}

java -jar $PICARD AddOrReplaceReadGroups INPUT=${dir} OUTPUT=${name}_RG.bam RGID=$filenoext RGLB=$library RGPL=illumina RGPU=$unit RGSM=$sample 	
fi
done

for dir in $GLOBAL_SCRATCH/AAA.TRIM/13/MERGE/*bam;do # dir == full path to ALL files in AAA.TRIM
# e.g. /srv/global/scratch/carsweshau/AAA.TRIM/9/L8.ACTGAT/Andy9_L8_ACTGAT_Lib9.bam
[[ -d $dir ]] && continue # if directory then skip
if [ ${dir: -4} == ".bam" ]; then
name=${dir%.*} # removes extension
filename=${dir##*/} # removes path prefix
filenoext=${name##*/}
sep=$(echo $filenoext | tr "_" "\n")
infor=( $sep ) # ${infor[2]} corresponds to ACTGAT in the above example
sample=${infor[0]}
unit=${infor[1]}
library=${infor[3]}

java -jar $PICARD AddOrReplaceReadGroups INPUT=${dir} OUTPUT=${name}_RG.bam RGID=$filenoext RGLB=$library RGPL=illumina RGPU=$unit RGSM=$sample 	
fi
done
