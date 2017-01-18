from Bio import Entrez, SeqIO

Entrez.email = "carsweshau@gmail.com"
data = ['FJ817486 JX069768 JX469983']
handle  = Entrez.efetch(db="nucleotide", id=data, rettype="fasta")
strands = SeqIO.parse(handle, "fasta")
print min(strands, key=lambda s: len(s.seq)).format("fasta")