import pandas as pd
import numpy as np
import json
import os


# Function to parse VCF file and create a Pandas DataFrame
def parse_vcf(vcf_file):
    variants = []

    with open(vcf_file, 'r') as file:
        for line in file:
            # Skip header lines '##'
            if line.startswith('##'):
                continue
            # Extract column header
            elif line.startswith('#CHROM'):
                headers = line.strip().split('\t')
            else:
                # Extract variant information
                data = line.strip().split('\t')
                variant = dict(zip(headers, data))
                variants.append(variant)

    return pd.DataFrame(variants)


# Function to clean the 'CHROM' column
def minimize_chrom(obj):
    try:
        return str(obj).split('.')[0] if '.' in str(obj) else obj
    except Exception as e:
        return np.nan  # Return NaN in case of errors (NaN value)


# Function to convert NumPy array to JSON
def numpy_array_to_json(numpy_array):
    python_list = numpy_array.tolist()
    return json.dumps(python_list)


# # Function to detect variants based on position and chromosom
def identify_variants(variants_df, chrom, position, gene_variant):
    results = []

    for value, position, gene_variant in zip(chrom, position, gene_variant):
        if isinstance(position, tuple):  # Check if the position is a range
            result_df = variants_df[(variants_df['#CHROM'] == value) & (variants_df['POS'].between(*position))].copy()
        else:
            result_df = variants_df[(variants_df['#CHROM'] == value) & (variants_df['POS'] == position)].copy()

        if not result_df.empty:
            result_df['Gene variants found'] = gene_variant
            results.append(result_df)
    print(results)
    return pd.concat(results, ignore_index=True)


# VCF file name
vcf_file = '../data/output.vcf'

# Parse the VCF file and create the DataFrame
variants_df = parse_vcf(vcf_file)

# Apply the function to the 'CHROM' column
variants_df['#CHROM'] = variants_df['#CHROM'].apply(minimize_chrom)

# Convert the 'POS' column to numeric values, coercing errors to NaN.
variants_df['POS'] = pd.to_numeric(variants_df['POS'], errors='coerce')

# Search criteria for genetic variants
chrom = ['NC_000022', 'NC_000007']
position = [(42125531, 42130881), (99756967,99784184)]
gene_variant = ['CYP2D6', 'CYP3A4']

# Filter variants based on search criteria
final_result = identify_variants(variants_df, chrom, position, gene_variant)

# Extract the 'Gene variants found' column as a NumPy array
gene_variants_array = final_result['Gene variants found'].to_numpy()

# Convert the NumPy array to a Python list
gene_variants_list = gene_variants_array.tolist()

# Create a list of dictionaries with specified format
formatted_gene_variants = [{"GeneVariant": gene} for gene in gene_variants_list]

# Define file path 
json_file_path = '../../Flutter/assets/data/genomeVariant.json'

# Save the list as JSON
with open(json_file_path, 'w') as json_file:
    json.dump(formatted_gene_variants, json_file, indent=2)  # indent for pretty formatting

# Print gene_variants_array
print(gene_variants_array)

