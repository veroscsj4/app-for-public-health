import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import '../../constants/jsonLoad.dart';

class GenomeDescription extends StatefulWidget {
  String genome;

  GenomeDescription({required this.genome});

  @override
  _GenomeDescriptionState createState() => _GenomeDescriptionState();
}

class _GenomeDescriptionState extends State<GenomeDescription> {
  late Future<String> information;

  @override
  void initState() {
    super.initState();
    information = getInformation(widget.genome, 'genome');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Genome Description',
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
            Text('${widget.genome}',
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
