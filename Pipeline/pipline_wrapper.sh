#!/bin/bash

# Exit script on any error
set -e

# Define data directory
DATA_DIR="/data"


# Step 1: Indexing with Bowtie
echo "Running Bowtie Indexing..."
bowtie2-build GCF_000001405.40_GRCh38.p14_genomic_140000-160000.fa $DATA_DIR/reference_index


# Step 2: Simulate Reads with wgsim
echo "Simulating Reads with wgsim..."
wgsim -1 100 -2 100 -d 300 -e 0 -r 0 -R 0 -X 0 -N 480024  GCF_000001405.40_GRCh38.p14_genomic_140000-160000_MTHFR.fa $DATA_DIR/read1.fq $DATA_DIR/read2.fq
# wgsim -1 100 -2 100 -d 300 -e 0 -r 0 -R 0 -X 0 -N 72510000  GCF_000001405.40_GRCh38.p14_genomic_part_mut.fa $DATA_DIR/read1.fq $DATA_DIR/read2.fq

# Step 3: Pre-processing Reads with fastp
echo "Pre-processing Reads with fastp..."
fastp --in1 $DATA_DIR/read1.fq --in2 $DATA_DIR/read2.fq --out1 $DATA_DIR/output1.fastq --out2 $DATA_DIR/output2.fastq


# Step 4: Aligning Reads with Bowtie2

echo "Aligning Reads with Bowtie2..."
bowtie2 -p 8 -x $DATA_DIR/reference_index -1 $DATA_DIR/output1.fastq -2 $DATA_DIR/output2.fastq -S $DATA_DIR/output.sam

# Step 5: Processing Aligned Reads with SAMtools
echo "Processing Aligned Reads with SAMtools..."
samtools view -bS $DATA_DIR/output.sam > $DATA_DIR/output.bam
samtools sort $DATA_DIR/output.bam -o $DATA_DIR/sorted_output.bam
samtools index $DATA_DIR/sorted_output.bam

# Step 6: Variant Calling with Freebayes
echo "Variant Calling with Freebayes..."
freebayes -f GCF_000001405.40_GRCh38.p14_genomic_140000-160000.fa $DATA_DIR/sorted_output.bam > $DATA_DIR/output.vcf

echo "Pipeline completed successfully!"
