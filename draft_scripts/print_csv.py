import pandas as pd
import os, subprocess

class cd:
    """Context manager for changing the current working directory"""
    def __init__(self, newPath):
        self.newPath = os.path.expanduser(newPath)

    def __enter__(self):
        self.savedPath = os.getcwd()
        os.chdir(self.newPath)

    def __exit__(self, etype, value, traceback):
        os.chdir(self.savedPath)

filename = '016.hg38.exome_summary.csv'
tmems = {}

with cd('/media/chemgen/Elements/VCFFILES'):
    df = pd.read_csv(filename)
    genes = df['Gene.refgene']

for gene in genes:
    if 'TMEM' in gene:
        if gene not in tmems:
            tmems[gene] = 1
        else:
            tmems[gene] += 1

with cd('/media/chemgen/Elements/VCFFILES'):
    with open(filename.split('.')[0]+'.TMEM.txt', 'w') as f:
        f.write(str(tmems.items()))
        f.write('\n# of TMEMs: '+str(len(tmems.items())))