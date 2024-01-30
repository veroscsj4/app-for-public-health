import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import '../../constants/general_functions.dart';

class MedicineDescription extends StatefulWidget {
  final List<String> drugs;

  MedicineDescription({required this.drugs});

  @override
  MedicineDescriptionState createState() => MedicineDescriptionState();
}

class MedicineDescriptionState extends State<MedicineDescription> {
  Future<String>? information;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic>? result =
          await getInformation(widget.drugs, 'drugs');
      information = Future.value(result?['information']?.toString());

      setState(() {});
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    return Text(
                      'No information available',
                      style: Theme.of(context).textTheme.bodySmall,
                    );
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
