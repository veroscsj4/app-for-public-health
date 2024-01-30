import 'package:mobile_app_for_public_health/src/data/genome_variant_medication.dart';

/// A class that handles medication search and filtering.
class MedicationSearchHandler {
  /// Filters the list of [allMedications] based on the [searchText].
  ///
  /// If the [searchText] is empty, the [allMedications] list is returned as is.
  /// Otherwise, the [allMedications] list is filtered based on whether the
  /// [geneVariant] or any of the [drugs] in each [GeneVariantMedication] item
  /// contains the [searchText] (case-insensitive).
  ///
  /// Returns the filtered list of [GeneVariantMedication].
  List<GeneVariantMedication> filterMedications(
      String searchText, List<GeneVariantMedication> allMedications) {
    if (searchText.isEmpty) {
      return allMedications;
    } else {
      return allMedications
          .where((item) =>
              item.geneVariant
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) ||
              item.drugs.any((drug) =>
                  drug.toLowerCase().contains(searchText.toLowerCase())))
          .toList();
    }
  }
}
