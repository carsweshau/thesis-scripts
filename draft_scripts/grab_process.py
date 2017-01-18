from Bio import ExPASy, SwissProt

def get_process(uniprot_id):
    handle = ExPASy.get_sprot_raw(uniprot_id)
    record = SwissProt.read(handle)
    for item in record.cross_references:
        if item[0] == 'GO':
            if 'P:' in item[2]: #then we're looking at a process
                print item[2][2:]

sample = 'Q9JT70'
get_process(sample)