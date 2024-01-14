import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';

//read json file from drug.json
  Future<List<GeneVariantMedicament>> loadGeneVariantsMedicaments() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/drug.json');
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList
          .map((json) => GeneVariantMedicament.fromJson(json))
          .toList();
    } catch (error) {
      print('Catch Error loading gene variants: $error');
      return [];
    }
  }

//read json file from genomeVariant.json
  Future<List<GeneVariant>> loadGeneVariants() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/data/genomeVariant.json');
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => GeneVariant.fromJson(json)).toList();
    } catch (error) {
      print('Catch Error loading gene variants: $error');
      return [];
    }
  }

  // Filter data between geneVariant and geneVariantsMedicaments
  List<GeneVariantMedicament> filterGeneVariantsMedicaments(
      List<GeneVariant> geneVariantList,
      List<GeneVariantMedicament> geneVariantsMedicaments) {
    List<GeneVariantMedicament> filteredData = [];

    for (var geneVariantMedicament in geneVariantsMedicaments) {
      for (var geneVariant in geneVariantList) {
        if (geneVariant.geneVariant == geneVariantMedicament.geneVariant) {
          filteredData.add(geneVariantMedicament);
          break;
        }
      }
    }

    return filteredData;
  }
Future<String> getInformation(List<String> medicineNames) async {
  try {
    List<GeneVariantMedicament> geneVariantsMedicaments =
        await loadGeneVariantsMedicaments();

    for (var medicine in geneVariantsMedicaments) {
      if (medicineNames.toString() == medicine.drugs.toString()) {
        return medicine.effectOnDrugResponse.join(',');
      }
    }

    // Return a default value or handle the case when the medicine is not found
    return 'Medicine information not found';
  } catch (error) {
    print('Error loading gene variants: $error');
    // Handle the error as needed
    return 'Error loading gene variants';
  }
}


