import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../constants/styles.dart';
import 'dart:convert';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import '../../constants/jsonLoad.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mobile_app_for_public_health/src/screens/subpages/genomeDescription.dart';
import 'package:mobile_app_for_public_health/src/screens/subpages/MedicineDescription.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<GeneVariantMedicament> geneVariantsMedicaments;
  late final List<GeneVariant> geneVariantList;
  List<dynamic> searchData = [];
  final searchController = TextEditingController();

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
void _onSearchTextChanged(String text) {
  setState(() {
    searchData = text.isEmpty
        ? geneVariantsMedicaments
        : geneVariantsMedicaments
            .where((item) =>
                item.geneVariant.toLowerCase().contains(text.toLowerCase()) ||
                item.drugs
                    .any((drug) => drug.toLowerCase().contains(text.toLowerCase())))
            .toList();
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
              backgroundImage: AssetImage(''), // TODO FOTO
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
              'Your genetic variations',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            // Show Variants in Container
            if (filteredMedicaments.isNotEmpty)
              ...(() {
                Set<String> uniqueGeneVariants = Set<String>();
                List<Widget> uniqueContainers = [];

                for (var medicament in filteredMedicaments) {
                  if (!uniqueGeneVariants.contains(medicament.geneVariant)) {
                    uniqueGeneVariants.add(medicament.geneVariant);

                    uniqueContainers.add(GestureDetector(
                      onTap: () {
                        // Navigate to another page when the container is tapped
                        Get.to(GenomeDescription(genome: medicament.geneVariant));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        padding: EdgeInsets.all(18.0),
                        width: double.infinity,
                        height: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          gradient: LinearGradient(
                            colors: [
                              primaryColor,
                              Color.fromARGB(255, 113, 215, 238),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                            medicament.geneVariant,
                            style:
                                Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: Colors.white,
                                    ),
                            ),
                          FaIcon(FontAwesomeIcons.ellipsisH, color: Colors.white),

                          ]
                        )
                      ),
                    ));
                  }
                }
                return uniqueContainers;
              })(),
            if (filteredMedicaments.isEmpty)
              Text(
                'No genetic variations found',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            const SizedBox(height: 16.0),
            Text(
              'List of Medicaments',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'Here you can find the list of medications that may be incompatible with your genetic variations, along with the associated side effects.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            //Search function
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 0.0),
              height: 50.0,
              child: TextField(
                controller:searchController,
                decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 14),
                border:OutlineInputBorder(),
                ),
                onChanged: _onSearchTextChanged,
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
                  headingRowColor: MaterialStateColor.resolveWith((states) => primaryColor), // Header background color
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
                        'Medikamente',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 14,  color: Colors.white),
                      ),
                    ),
                  ],
                  rows: filteredMedicaments
                      .map(
                        (filteredMedicaments) => DataRow(
                          cells: [
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the subpage with the medicine name
                                  Get.to(MedicineDescription(drugs: filteredMedicaments.drugs));
                                },
                                child: Container(
                                  width: 150, // Set the max width for the first column
                                  child: Text(
                                    filteredMedicaments.geneVariant,
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
                                  Get.to(MedicineDescription(drugs: filteredMedicaments.drugs));
                                },
                              child:Container(
                                width: 150, // Set the max width for the second column
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
