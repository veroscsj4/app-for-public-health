import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_for_public_health/src/screens/subpages/searchFilter.dart';
import '../../constants/styles.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medication.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import '../../constants/general_functions.dart';
import 'package:mobile_app_for_public_health/src/screens/subpages/MedicineDescription.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({Key? key}) : super(key: key);

  @override
  MedicinePageState createState() => MedicinePageState();
}

class MedicinePageState extends State<MedicinePage> {
  late final List<GeneVariantMedication> geneVariantsMedications;
  late final List<GeneVariant> geneVariantList;
  List<dynamic> searchData = [];
  final searchController = TextEditingController();
  late final List<GeneVariantMedication> filteredMedications;

  /* 
  Initializes the state of the [MedicineTabelle] screen.
  This method is called when the widget is inserted into the widget tree.
  It loads the gene variants and gene variant medications asynchronously, and updates the state of the screen with the loaded data.

  The [loadGeneVariants] method loads the gene variants and assigns them to the [geneVariantList].
  The [loadGeneVariantsMedications] method loads the gene variant medications and assigns them to the [geneVariantsMedications].

  After loading the data, the [filterGeneVariantsMedications] method is called to filter the medications based on the gene variants.
  The filtered medications are assigned to the [filteredMedications] list, and the [searchData] is updated with the filtered medications.
  */
  void initState() {
    super.initState();
    loadGeneVariants().then((variants) {
      setState(() {
        geneVariantList = variants;
        filteredMedications = filterGeneVariantsMedications(
            geneVariantList, geneVariantsMedications);
        searchData = filteredMedications;
      });
    });
    loadGeneVariantsMedications().then((variants) {
      setState(() {
        geneVariantsMedications = variants;
        filteredMedications = filterGeneVariantsMedications(
            geneVariantList, geneVariantsMedications);
        searchData = filteredMedications;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Create an instance of the search handler
  final MedicationSearchHandler _searchHandler = MedicationSearchHandler();

  // Filter the list of medications based on the search text
  void onSearchTextChanged(String text) {
    setState(() {
      searchData = _searchHandler.filterMedications(text, filteredMedications);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List of Medications',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here you can find the list of medications that may be incompatible with your genetic variations, along with the associated side effects.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            //Search function
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 0.0),
              height: 50.0,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 14),
                  border: OutlineInputBorder(),
                ),
                onChanged: onSearchTextChanged,
              ),
            ),
            // Table with Medicine Information
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 8.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 224, 223, 223),
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0, // Adjust the spacing between columns
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => primaryColor), // Header background color
                  headingRowHeight: 70.0,
                  //horizontalMargin: 100.0,
                  columns: [
                    DataColumn(
                      label: Text(
                        'Variation',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Medication',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                  rows: searchData
                      .map(
                        (filteredMedications) => DataRow(
                          cells: [
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the subpage with the medicine name
                                  Get.to(MedicineDescription(
                                      drugs: filteredMedications.drugs));
                                },
                                child: Container(
                                  width:
                                      150, // Set the max width for the first column
                                  child: Text(
                                    filteredMedications.geneVariant,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the subpage with the medicine name
                                  Get.to(MedicineDescription(
                                      drugs: filteredMedications.drugs));
                                },
                                child: Container(
                                  width:
                                      150, // Set the max width for the second column
                                  child: Text(
                                    filteredMedications.drugs is List
                                        ? (filteredMedications.drugs
                                                as List<String>)
                                            .join(", ")
                                        : filteredMedications.drugs.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(fontSize: 13),
                                  ),
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
