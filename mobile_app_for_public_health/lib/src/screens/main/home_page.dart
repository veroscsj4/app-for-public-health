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
  int _length = 0;

  Future<List<GeneVariantMedicament>> loadGeneVariantsMedicaments() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/drug.json');
      List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        _length = jsonList.length;
        print('hier ist die länge von dem json');
        print(_length);
      });

      jsonList.forEach((json) {
        print(json);
      });
      return jsonList.map((json) => GeneVariantMedicament.fromJson(json)).toList();
    } catch (error) {
      print('Catch Error loading gene variants: $error');
      return [];
    }
  }
    Future<List<GeneVariant>> loadGeneVariants() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/drug.json');
      List<dynamic> jsonList = json.decode(jsonString);

      setState(() {
        _length = jsonList.length;
        print('hier ist die länge von dem json');
        print(_length);
      });

      jsonList.forEach((json) {
        print(json);
      });
      return jsonList.map((json) => GeneVariant.fromJson(json)).toList();
    } catch (error) {
      print('Catch Error loading gene variants: $error');
      return [];
    }
  }

@override
void initState() {
super.initState();
loadGeneVariantsMedicaments().then((variants) {
  setState(() {
    geneVariantsMedicaments = variants;
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
              backgroundImage:
                  AssetImage(''), // Füge den Pfad zum Benutzerfoto hinzu
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
              'Hier kannst du die Liste der Medikamente finden, die mit deinen genetischen Variationen unverträglich sein könnten, zusammen mit den dazugehörigen Nebenwirkungen.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // Table with Information
            DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Genetische Variation',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Medikamente',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Information',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 13),
                  ),
                ),
              ],
              rows: geneVariantsMedicaments
                  .map(
                    (geneVariantsMedicaments) => DataRow(
                      cells: [
                        DataCell(
                          Flexible(
                            child: Text(
                              geneVariantsMedicaments.geneVariant,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        DataCell(
                          Flexible(
                            child: Text(
                              geneVariantsMedicaments.drugs is List
                                  ? (geneVariantsMedicaments.drugs as List<String>).join(", ")
                                  : geneVariantsMedicaments.drugs.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                        DataCell(
                          Flexible(
                            child: Text(
                              geneVariantsMedicaments.drugs is List
                                  ? (geneVariantsMedicaments.drugs as List<String>).join(", ")
                                  : geneVariantsMedicaments.drugs.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
