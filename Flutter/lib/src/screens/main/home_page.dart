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
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                    )),
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
                const SizedBox(height: 16.0),
                Text(
                  'Your genetic variations',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'In our analysis, we discovered the following genetic variations in your genome. Click on each box for more detailed information about each one',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                // Show Variants in Container
                Container(
                  height: geneVariantList.length == 2 ? 100.0 : 200.0,
                  child: ListView.builder(
                    itemCount: (geneVariantList.length / 2)
                        .ceil(), // Ensure you have even or odd number of items
                    itemBuilder: (BuildContext context, int index) {
                      int startIndex = index * 2;
                      int endIndex = (index + 1) * 2;
                      if (endIndex > geneVariantList.length) {
                        endIndex = geneVariantList.length;
                      }

                      return Row(
                        children: [
                          for (int i = startIndex; i < endIndex; i++)
                            GestureDetector(
                              onTap: () {
                                // Navigate to GenomeDescription screen when tapped
                                Get.to(() => GenomeDescription(
                                    genome: geneVariantList[i].geneVariant));
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: i.isEven
                                      ? 16.0
                                      : 0.0, // Add margin only to even indices
                                ),
                                padding: EdgeInsets.all(18.0),
                                width: 150.0,
                                height: 90.0,
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
                                      geneVariantList[i].geneVariant,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.0), 
                                      ),
                                      padding: EdgeInsets.only(top:8, bottom:8, right:10, left:10),
                                      child: FaIcon(
                                        FontAwesomeIcons.angleRight,
                                        color:primaryColor, 
                                        size: 15.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                if (filteredMedicaments.isEmpty)
                  Text(
                    'No genetic variations found',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                const SizedBox(height: 16.0),
                Text(
                  'Incompatible medicines',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'By analyzing your genome, we identify drugs that may not be compatible with your genetic makeup.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                GestureDetector(
                    onTap: () {
                      Get.to(() => const MedicinePage());
                    },
                    child: Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        padding: const EdgeInsets.all(18.0),
                        width: double.infinity,
                        height: 180.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: const AssetImage(medicine),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken),
                          ),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'List of Medicaments',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.only(top:8, bottom:8, right:10, left:10),
                                child: FaIcon(
                                  FontAwesomeIcons.angleRight,
                                  color: primaryColor,
                                ),
                              ),
                            ]))),
              ],
            ),
          ),
        ));
  }
}
