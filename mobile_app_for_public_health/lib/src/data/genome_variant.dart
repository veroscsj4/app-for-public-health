class GeneVariant {
  String geneVariant;

  GeneVariant({
    required this.geneVariant,
  });

  factory GeneVariant.fromJson(Map<String, dynamic> json) {
    return GeneVariant(
      geneVariant: json['GeneVariant'] ?? '',
    );
  }
}