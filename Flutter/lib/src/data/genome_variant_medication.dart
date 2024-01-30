class GeneVariantMedication {
  String geneVariant;
  List<String> drugs;
  List<String> effectOnDrugResponse;

  GeneVariantMedication({
    required this.geneVariant,
    required this.drugs,
    required this.effectOnDrugResponse,
  });

  factory GeneVariantMedication.fromJson(Map<String, dynamic> json) {
    // Handle the case where 'Drug' and 'EffectOnDrugResponse' can be single values or lists
    var drugsList = json['Drug'];
    var effectsList = json['EffectOnDrugResponse'];

    return GeneVariantMedication(
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
