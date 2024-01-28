import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import '../../constants/jsonLoad.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GenomeDescription extends StatefulWidget {
  String genome;

  GenomeDescription({required this.genome});

  @override
  GenomeDescriptionState createState() => GenomeDescriptionState();
}

class GenomeDescriptionState extends State<GenomeDescription> {
  Future<String>? information;
  Future<String>? chromosome;

  @override
  void initState() {
    super.initState();
    fetchData();
    //information = getInformation(widget.genome, 'genome');
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic>? result =
          await getInformation(widget.genome, 'genome');
      information = Future.value(result?['information']?.toString());
      chromosome = Future.value(result?['chromosome']?.toString());
      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(information);
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
            Text('Chromosome', style: Theme.of(context).textTheme.titleSmall),
            Text('${widget.genome}',
                style: Theme.of(context).textTheme.titleSmall),
            SizedBox(height: 20),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.dna, color: primaryColor),
                SizedBox(
                    width: 8),
                Expanded(
                  child: FutureBuilder<String>(
                    future: chromosome,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.data != null) {
                          return Text(
                            'The variant was found on the chromosome ' +
                                snapshot.data.toString(),
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        } else {
                          return Text(
                            'No information available',
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            FutureBuilder<String>(
              future: information,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  if (snapshot.data != null) {
                    return Text(
                      snapshot.data.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  } else {
                    return Text('No information available',
                        style: Theme.of(context).textTheme.bodySmall);
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
