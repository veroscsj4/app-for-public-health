import csv
from Bio import SeqIO
from Bio.Seq import MutableSeq
from Bio.SeqRecord import SeqRecord

# Pfad zur TSV-Datei mit den Mutationen
mutations_file = 'mutationen.tsv'

# Pfad zur FASTA-Datei des Referenzgenoms
reference_genome = 'referenz.fasta'

# Lesen der FASTA-Datei
with open(reference_genome, 'r') as fasta_file:
    genome = list(SeqIO.parse(fasta_file, 'fasta'))

# Erstellen eines Dictionaries für schnelleren Zugriff auf die Sequenzen
genome_dict = {record.id: MutableSeq(record.seq) for record in genome}

# Mutationen einlesen und anwenden
with open(mutations_file, 'r') as file:
    reader = csv.DictReader(file, delimiter='\t')
    for row in reader:
        chrom = row['Chromosom']
        pos = int(row['Position']) - 1  # Anpassung an 0-basierten Index
        mut_base = row['Mut_Base']
        
        if genome_dict[chrom][pos] == row['Ref_Base']:
            genome_dict[chrom][pos] = mut_base
        else:
            print(f"Warnung: Basenpaar an {chrom}:{pos+1} stimmt nicht mit der Referenz überein.")

# Speichern der mutierten Sequenzen in einer neuen FASTA-Datei
mutated_genome = [SeqRecord(genome_dict[chrom], id=chrom) for chrom in genome_dict]
with open('mutiertes_genom.fasta', 'w') as output_file:
    SeqIO.write(mutated_genome, output_file, 'fasta')

print("Mutationen wurden ins Genom eingefügt und in 'mutiertes_genom.fasta' gespeichert.")
