import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<List<GeneVariant>> loadGeneVariants() async {
  try {
    String jsonString = await rootBundle.loadString('./src/data/drug.json');
    List<dynamic> jsonList = json.decode(jsonString);
    print('hier');
    return jsonList.map((json) => GeneVariant.fromJson(json)).toList();
  } catch (error) {
    print('Error loading gene variants: $error');
    return [];
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<GeneVariant> geneVariants;

  @override
  void initState() {
    print('hier sind wir');
    super.initState();
    geneVariants = [];
    loadGeneVariants().then((variants) {
      setState(() {
        geneVariants = variants;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF565ACF),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(''), // Füge den Pfad zum Benutzerfoto hinzu
              radius: 20.0,
            ),
            const SizedBox(width: 10.0),
            Text(
              'Hallo Mustermann',
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
              'Deine genetischen Variationen sind:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Hier können Sie die Liste der Medikamente finden, die mit Ihren genetischen Variationen unverträglich sein könnten, zusammen mit den dazugehörigen Nebenwirkungen.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // Table with Information
            DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Genetische Variation',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Medikamente',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Information',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
              rows: geneVariants.map(
                (geneVariant) => DataRow(
                  cells: [
                    DataCell(
                      Flexible(
                        child: Text(
                          geneVariant.geneVariant,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    DataCell(
                      Flexible(
                        child: Text(
                          geneVariant.drugs.join(", "),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    DataCell(
                      Flexible(
                        child: Text(
                          geneVariant.effectOnDrugResponse.join("\n"),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}