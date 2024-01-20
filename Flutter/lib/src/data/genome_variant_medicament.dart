class GeneVariantMedicament {
  String geneVariant;
  List<String> drugs;
  List<String> effectOnDrugResponse;

  GeneVariantMedicament({
    required this.geneVariant,
    required this.drugs,
    required this.effectOnDrugResponse,
  });

  factory GeneVariantMedicament.fromJson(Map<String, dynamic> json) {
    // Handle the case where 'Drug' and 'EffectOnDrugResponse' can be single values or lists
    var drugsList = json['Drug'];
    var effectsList = json['EffectOnDrugResponse'];

    return GeneVariantMedicament(
      geneVariant: json['GeneVariant'] ?? '',
      drugs: _parseStringList(drugsList),
      effectOnDrugResponse: _parseStringList(effectsList),
    );
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value.cast<String>().toList();
    } else if (value is String) {
      return [value];
    } else {
      return [];
    }
  }
}
