import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<GeneVariantMedicament> geneVariantsMedicaments;
  late final List<GeneVariant> geneVariantList;
  //int _length = 0;

//read json file from drug.json
  Future<List<GeneVariantMedicament>> loadGeneVariantsMedicaments() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/drug.json');
      List<dynamic> jsonList = json.decode(jsonString);

      /*setState(() {
      _length = jsonList.length;
      print('hier ist die Länge von dem JSON');
      print(_length);
    });

    jsonList.forEach((json) {
      print(json);
    });*/
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

  @override
  void initState() {
    super.initState();
    loadGeneVariants().then((variants) {
      setState(() {
        geneVariantList = variants;
      });
    });
    loadGeneVariantsMedicaments().then((variants) {
      setState(() {
        geneVariantsMedicaments = variants;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<GeneVariantMedicament> filteredMedicaments =
        filterGeneVariantsMedicaments(geneVariantList, geneVariantsMedicaments);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF565ACF),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage:
                  AssetImage(''), // Füge den Pfad zum Benutzerfoto hinzu
              radius: 20.0,
            ),
            const SizedBox(width: 10.0),
            Text(
              'Hi Ana!',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display User's Name at the Top
            Text(
              'Your genetic variations are:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            if (filteredMedicaments.isNotEmpty)
              ...filteredMedicaments.map((medicament) => Text(
                    medicament.geneVariant,
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
            if (filteredMedicaments.isEmpty)
              Text(
                'No genetic variations found',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            const SizedBox(height: 16.0),
            Text(
              'Here you can find the list of medications that may be incompatible with your genetic variations, along with the associated side effects.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // Table with Information
            Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0, // Adjust the spacing between columns
                  columns: [
                    DataColumn(
                      label: Text(
                        'Genetische Variation',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 13),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Medikamente',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 13),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Information',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                  rows: filteredMedicaments
                      .map(
                        (filteredMedicaments) => DataRow(
                          cells: [
                            DataCell(
                              Container(
                                width:
                                    80, // Set the max width for the first column
                                child: Text(
                                  filteredMedicaments.geneVariant,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width:
                                    100, // Set the max width for the second column
                                child: Text(
                                  filteredMedicaments.drugs is List
                                      ? (filteredMedicaments.drugs
                                              as List<String>)
                                          .join(", ")
                                      : filteredMedicaments.drugs.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 13),
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                width:
                                    150, // Set the max width for the third column
                                child: Text(
                                  filteredMedicaments.effectOnDrugResponse
                                          is List
                                      ? (filteredMedicaments
                                                  .effectOnDrugResponse
                                              as List<String>)
                                          .join(", ")
                                      : filteredMedicaments.effectOnDrugResponse
                                          .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
