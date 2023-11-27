#!/bin/bash

# Exit script on any error
set -e

# Define data directory
DATA_DIR="/data"

# Step 1: Indexing with Bowtie
# echo "Running Bowtie Indexing..."
# bowtie2-build GCA_000001405.15_GRCh38_genomic.fasta $DATA_DIR/reference_index

# Step 2: Simulate Reads with wgsim
# echo "Simulating Reads with wgsim..."
# wgsim -e 0 -1 100 -2 100 -r 0.001 -R 0 -X 0 -d 300 -N 10000 -s 50 GCA_000001405.15_GRCh38_genomic.fasta $DATA_DIR/read1.fq $DATA_DIR/read2.fq

# Step 3: Pre-processing Reads with fastp
# echo "Pre-processing Reads with fastp..."
# fastp --in1 $DATA_DIR/read1.fq --in2 $DATA_DIR/read2.fq --out1 $DATA_DIR/output1.fastq --out2 $DATA_DIR/output2.fastq

# Step 4: Aligning Reads with Bowtie2
echo "Aligning Reads with Bowtie2..."
bowtie2 -x $DATA_DIR/reference_index -1 $DATA_DIR/output1.fastq -2 $DATA_DIR/output2.fastq -S $DATA_DIR/output.sam

# Step 5: Processing Aligned Reads with SAMtools
echo "Processing Aligned Reads with SAMtools..."
samtools view -bS $DATA_DIR/output.sam > $DATA_DIR/output.bam
samtools sort $DATA_DIR/output.bam -o $DATA_DIR/sorted_output.bam
samtools index $DATA_DIR/sorted_output.bam

# Step 6: Variant Calling with Freebayes
echo "Variant Calling with Freebayes..."
freebayes -f GCA_000001405.15_GRCh38_genomic.fasta $DATA_DIR/sorted_output.bam > $DATA_DIR/output.vcf

echo "Pipeline completed successfully!"
