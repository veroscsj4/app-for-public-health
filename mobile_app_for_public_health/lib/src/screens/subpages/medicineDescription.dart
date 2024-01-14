import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import '../../constants/jsonLoad.dart';

class MedicineDescription extends StatefulWidget {
  final List<String> drugs;

  MedicineDescription({required this.drugs});

  @override
  _MedicineDescriptionState createState() => _MedicineDescriptionState();
}

class _MedicineDescriptionState extends State<MedicineDescription> {
  late Future<String> information;

  @override
  void initState() {
    super.initState();
    information = getInformation(widget.drugs);
    print('hier');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Medicine Description',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('${widget.drugs.join(", ")}',
                style: Theme.of(context).textTheme.titleSmall),
            FutureBuilder(
              future: information,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('${snapshot.data}', style: Theme.of(context).textTheme.bodySmall);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
