import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_for_public_health/src/screens/subpages/searchFilter.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medication.dart';

void main() {
  group('MedicationSearchHandler Tests', () {
    final MedicationSearchHandler searchHandler = MedicationSearchHandler();
    final List<GeneVariantMedication> testMedications = [
      GeneVariantMedication(geneVariant: "VariantA", drugs: [
        "Drug1",
        "Drug2"
      ], effectOnDrugResponse: [
        "Influences pain perception and treatment efficacy"
      ]),
      GeneVariantMedication(
          geneVariant: "VariantB",
          drugs: ["Drug3"],
          effectOnDrugResponse: ["Testing Effects still!"]),
    ];

    test('Empty search text returns all medications', () {
      var result = searchHandler.filterMedications('', testMedications);
      expect(result.length, testMedications.length);
    });

    test('Non-empty search text returns filtered medications', () {
      var result = searchHandler.filterMedications('VariantA', testMedications);
      expect(result.length, 1);
      expect(result[0].geneVariant, 'VariantA');
    });

    test('Search is case-insensitive', () {
      var result = searchHandler.filterMedications('varianta', testMedications);
      expect(result.length, 1);
      expect(result[0].geneVariant, 'VariantA');
    });
  });
}
