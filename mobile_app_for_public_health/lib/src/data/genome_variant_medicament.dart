class GeneVariant {
  final String geneVariant;
  final List<String> drugs;
  final List<String> effectOnDrugResponse;

  GeneVariant({
    required this.geneVariant,
    required this.drugs,
    required this.effectOnDrugResponse,
  });

  factory GeneVariant.fromJson(Map<String, dynamic> json) {
    return GeneVariant(
      geneVariant: json['GeneVariant'],
      drugs: List<String>.from(json['Drug']),
      effectOnDrugResponse: List<String>.from(json['EffectOnDrugResponse']),
    );
  }
}
