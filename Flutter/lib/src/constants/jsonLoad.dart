import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_information.dart';
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
  //read json file from genomeVariantInformation.json
  Future<List<GeneVariantInformation>> loadGeneVariantInformation() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/data/genomeVariantInformation.json');
      List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => GeneVariantInformation.fromJson(json)).toList();
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
Future<Map<String, dynamic>?> getInformation(dynamic searchObject, String typeOfInformation) async {
  if(typeOfInformation == "genome"){
    print(searchObject);
    try {
       List<GeneVariantInformation> geneVariantInformation = await loadGeneVariantInformation();
       //print('hier!!!!' + searchObject);
      for (var genome in geneVariantInformation) {   
        //print(genome.geneVariant + '     ' + genome.information.join(',') + '    ' + genome.chromosome + '    ' + genome.link.join(','));   
        if (searchObject != null && searchObject == genome.geneVariant) {
           print('genomeVariant = '+genome.chromosome);
          return {'information':genome.information.join(','), 'chromosome': genome.chromosome.toString()};
        }
      }
      // Return a default value or handle the case when the medicine is not found
      return {'information':'Genome information not found'};
    } catch (error) {
      print('Error loading genome variants: $error');
      // Handle the error as needed
      return {'information':'Error loading gene variants'};
    }
  }else{
    try {
      List<GeneVariantMedicament> geneVariantsMedicaments =
          await loadGeneVariantsMedicaments();

      for (var medicine in geneVariantsMedicaments) {
        if (searchObject.toString() == medicine.drugs.toString()) {
          return {'information':medicine.effectOnDrugResponse.join(',')};
        }
      }

      // Return a default value or handle the case when the medicine is not found
      return {'information':'Medicine information not found'};
    } catch (error) {
      print('Error loading gene variants: $error');
      // Handle the error as needed
      return {'information':'Error loading gene variants'};
    }
  }
}


