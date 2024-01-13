import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MedicineDescription extends StatelessWidget {
  final List<String> drugs;

  MedicineDescription({required this.drugs});

  @override
  Widget build(BuildContext context) {
    // Your widget implementation here
    // You can use the drugs list in your widget
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Drugs: ${drugs.join(", ")}'),
            // Add UI elements for other details if needed
          ],
        ),
      ),
    );
  }
}
