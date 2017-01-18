#!/usr/bin/env python
import glob, os, subprocess
 
template = """[general]
 
chrLenFile = /media/chemgen/Elements/hg19.len
ploidy = 2
chrFiles = /media/chemgen/Angiogenesis/EXOME_PIPE/bwa.kit/hg19
window = 500
step = 250
maxThreads = 4
noisyData = TRUE
readCountThreshold = 50
breakPointType = 4
printNA = False
breakPointThreshold = 1.5 
 
[sample]
 
mateFile = {matefile}
inputFormat = BAM
mateOrientation = FR

[BAF]

SNPfile = /media/chemgen/Elements/allsnp142.bed
 
[control]

mateFile = /media/chemgen/Elements/DMF_control/MFIXED_DMF/mfixed_dmf.bam

[target]

captureRegions = /media/chemgen/Elements/FINALBAMFILES/20130108.exome.targets.bed"""

dir_count = 1
while dir_count <= 9:
	target_dir = "/media/chemgen/Elements/SAI/Output_Andy%s/BAM_Andy%s" % (dir_count, dir_count)
	os.chdir(target_dir) 
	matefiles = glob.glob('*.bam')
	config_filename = "config%s.txt" % dir_count
 
	for matefile in matefiles:
	    with open(config_filename, 'w') as f:
	        f.write(template.format(matefile=matefile))
 
	    subprocess.Popen(['/home/chemgen/FREEC/freec', '-conf', config_filename])
	dir_count += 1

