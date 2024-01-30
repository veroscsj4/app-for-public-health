import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medication.dart';

void main() {
  group('GeneVariantMedication Tests', () {
    test('fromJson with list values', () {
      var json = {
        'GeneVariant': 'Variant1',
        'Drug': ['Drug1', 'Drug2'],
        'EffectOnDrugResponse': ['Effect1', 'Effect2'],
      };

      var medication = GeneVariantMedication.fromJson(json);
      expect(medication.geneVariant, 'Variant1');
      expect(medication.drugs, equals(['Drug1', 'Drug2']));
      expect(medication.effectOnDrugResponse, equals(['Effect1', 'Effect2']));
    });

    test('fromJson with single string values', () {
      var json = {
        'GeneVariant': 'Variant2',
        'Drug': 'Drug3',
        'EffectOnDrugResponse': 'Effect3',
      };

      var medication = GeneVariantMedication.fromJson(json);
      expect(medication.geneVariant, 'Variant2');
      expect(medication.drugs, equals(['Drug3']));
      expect(medication.effectOnDrugResponse, equals(['Effect3']));
    });

    test('fromJson with missing fields', () {
      var json = {
        'GeneVariant': 'Variant3',
      };

      var medication = GeneVariantMedication.fromJson(json);
      expect(medication.geneVariant, 'Variant3');
      expect(medication.drugs, isEmpty);
      expect(medication.effectOnDrugResponse, isEmpty);
    });

    test('fromJson with missing GeneVariant', () {
      var json = {
        'Drug': ['Drug4'],
        'EffectOnDrugResponse': ['Effect4'],
      };

      var medication = GeneVariantMedication.fromJson(json);
      expect(medication.geneVariant, '');
      expect(medication.drugs, equals(['Drug4']));
      expect(medication.effectOnDrugResponse, equals(['Effect4']));
    });
  });
}
