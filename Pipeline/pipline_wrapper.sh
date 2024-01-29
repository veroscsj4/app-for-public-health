#!/bin/bash

# Exit script on any error
set -e

# Define data directory
DATA_DIR="/data"


# Step 1: Indexing with Bowtie
echo "Running Bowtie Indexing..."

# Parameters:
# - GCF_000001405.40_GRCh38.p14_genomic_140000-160000.fa: Reference genome file to be indexed.
# - $DATA_DIR/reference_index: Output directory and prefix for the indexed reference.
bowtie2-build GCF_000001405.40_GRCh38.p14_genomic_140000-160000.fa $DATA_DIR/reference_index


# Step 2: Simulate Reads with wgsim
echo "Simulating Reads with wgsim..."

# Parameters:
# - GCF_000001405.40_GRCh38.p14_genomic_140000-160000_MTHFR.fa: Mutated reference genome file for read simulation.
# - $DATA_DIR/read1.fq, $DATA_DIR/read2.fq: Output files for simulated paired-end reads.
# - -1 100 -2 100: Read lengths of 100 base pairs for both ends.
# - -d 300: Mean fragment size of 300 base pairs.
# - -N 600000: Number of read pairs to simulate
#- -e 0 -r 0 -R 0 -X 0 : Error ratio in reads
wgsim -1 100 -2 100 -d 300 -e 0 -r 0 -R 0 -X 0 -N 600000  GCF_000001405.40_GRCh38.p14_genomic_140000-160000_MTHFR.fa $DATA_DIR/read1.fq $DATA_DIR/read2.fq

# Step 3: Pre-processing Reads with fastp
echo "Pre-processing Reads with fastp..."

# Parameters:
# --in1, --in2: Input fastq files containing paired-end reads.
# --out1, --out2: Output files for pre-processed reads.
fastp --in1 $DATA_DIR/read1.fq --in2 $DATA_DIR/read2.fq --out1 $DATA_DIR/output1.fastq --out2 $DATA_DIR/output2.fastq


# Step 4: Aligning Reads with Bowtie2
echo "Aligning Reads with Bowtie2..."

# Parameters:
# -p 8: Number of processors to use.
# -x $DATA_DIR/reference_index: Bowtie2 index file.
# -1, -2: Input fastq files containing paired-end reads.
# -S $DATA_DIR/output.sam: Output SAM file.
bowtie2 -p 8 -x $DATA_DIR/reference_index -1 $DATA_DIR/output1.fastq -2 $DATA_DIR/output2.fastq -S $DATA_DIR/output.sam

# Step 5: Processing Aligned Reads with SAMtools
echo "Processing Aligned Reads with SAMtools..."

# Parameters:
# view -bS: Convert SAM to BAM.
# sort: Sort BAM file.
# index: Create index for sorted BAM.
samtools view -bS $DATA_DIR/output.sam > $DATA_DIR/output.bam
samtools sort $DATA_DIR/output.bam -o $DATA_DIR/sorted_output.bam
samtools index $DATA_DIR/sorted_output.bam

# # Step 6: Variant Calling with Freebayes
echo "Variant Calling with Freebayes..."

# Parameters:
# -f GCF_000001405.40_GRCh38.p14_genomic_140000-160000.fa: Reference genome file for variant calling.
# - $DATA_DIR/sorted_output.bam: Sorted and indexed BAM file containing aligned reads.
# > $DATA_DIR/output.vcf: Output VCF (Variant Call Format) file for storing variant calls.
freebayes -f GCF_000001405.40_GRCh38.p14_genomic_140000-160000.fa $DATA_DIR/sorted_output.bam > $DATA_DIR/output.vcf

# Step 7: Comaparison
python3 /usr/local/bin/genome_comparison.py

echo "Pipeline completed successfully!"
