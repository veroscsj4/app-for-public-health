
class GeneVariantInformation {
  String geneVariant;
  List<String> information;
  List<String> link;

  GeneVariantInformation({
    required this.geneVariant,
    required this.information,
    required this.link,
  });

  factory GeneVariantInformation.fromJson(Map<String, dynamic> json) {
    var linkList = json['Link'];
    var informationList = json['Information'];

    return GeneVariantInformation(
      geneVariant: json['GeneVariant'] ?? '',
      information: _parseStringList(informationList),
      link: _parseStringList(linkList),
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
