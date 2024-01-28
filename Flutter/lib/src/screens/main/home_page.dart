import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobile_app_for_public_health/src/screens/subpages/medicineTabelle.dart';
import '../../constants/styles.dart';
import '../../constants/img_path.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import '../../constants/jsonLoad.dart';
import 'package:mobile_app_for_public_health/src/screens/subpages/genomeDescription.dart';

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
  late final List<GeneVariantMedicament> filteredMedicaments;
  @override
  void initState() {
    super.initState();
    loadGeneVariants().then((variants) {
      setState(() {
        geneVariantList = variants;
        filteredMedicaments = filterGeneVariantsMedicaments(
            geneVariantList, geneVariantsMedicaments);
        searchData = filteredMedicaments;
      });
    });
    loadGeneVariantsMedicaments().then((variants) {
      setState(() {
        geneVariantsMedicaments = variants;
        filteredMedicaments = filterGeneVariantsMedicaments(
            geneVariantList, geneVariantsMedicaments);
        searchData = filteredMedicaments;
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
          ? filteredMedicaments
          : filteredMedicaments
              .where((item) =>
                  item.geneVariant.toLowerCase().contains(text.toLowerCase()) ||
                  item.drugs.any((drug) =>
                      drug.toLowerCase().contains(text.toLowerCase())))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          toolbarHeight: 100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40)
            )
          ),
          title: Container(   
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35.0,
                  backgroundColor: whiteColor,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(userImage),
                    radius: 30.0,
                  )
                ),
                const SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Ana!',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'nice to have you back',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                      if (!uniqueGeneVariants
                          .contains(medicament.geneVariant)) {
                        uniqueGeneVariants.add(medicament.geneVariant);
                        uniqueContainers.add(GestureDetector(
                          onTap: () {
                            // Navigate to another page when the container is tapped
                            Get.to(GenomeDescription(
                                genome: medicament.geneVariant));
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
                                    const Color.fromARGB(255, 113, 215, 238),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      medicament.geneVariant,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                    FaIcon(FontAwesomeIcons.ellipsisH,
                                        color: Colors.white),
                                  ])),
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

                GestureDetector(
                    onTap: () {
                      Get.to(() => const MedicinePage());
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      padding: EdgeInsets.all(18.0),
                      width: double.infinity,
                      height: 180.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(medicine),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4),
                            BlendMode.darken
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                        Text('List of Medicaments', 
                          style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                              color: Colors.white,
                            ) ,
                          )
                        ]
                      ),
                    )
                  ),
              ],
            ),
          ),
        ));
  }
}
