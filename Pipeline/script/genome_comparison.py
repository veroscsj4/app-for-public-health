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


# Function to filter variants based on search criteria
def filter_variants(variants_df, search_values, search_positions, search_gene_variant):
    results = []

    for value, position, gene_variant in zip(search_values, search_positions, search_gene_variant):
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
# vcf_file = 'output_CYP2D6_CYP2C19.vcf'
vcf_file = 'output.vcf'

if os.path.exists(vcf_file):
    print("File exists.")
else:
    print("File does not exist.")

# Parse the VCF file and create the DataFrame
variants_df = parse_vcf(vcf_file)

# Apply the function to the 'CHROM' column
variants_df['#CHROM'] = variants_df['#CHROM'].apply(minimize_chrom)

# Convert the 'POS' column to numeric values, coercing errors to NaN.
variants_df['POS'] = pd.to_numeric(variants_df['POS'], errors='coerce')

# Define search criteria for genetic variants
# WIP [IMPORTANT]: search_positions are dummy data

search_values = ['NC_000016', 'NC_000001', 'NC_000007', 'NC_000001']
search_positions = [(28971111, 28971113), 28975712, 1641693, 28971111]
search_gene_variant = ['G6PD', 'CYP2D6', 'CYP2C19', 'MTHFR']

# Filter variants based on search criteria
final_result = filter_variants(variants_df, search_values, search_positions, search_gene_variant)

# Print the final DataFrame as a formatted string
#print(final_result.to_string(index=False))

# Extract the 'Gene variants found' column as a NumPy array
gene_variants_array = final_result['Gene variants found'].to_numpy()

# Print gene_variants_array
print(gene_variants_array)

#Output: gene variants in JSON for communication with Flutter frontend
# TO DO: SEND GENE_VARIANTS_JSON TO FLUTTER FRONTEND
gene_variants_json = numpy_array_to_json(gene_variants_array)
print(gene_variants_json)
