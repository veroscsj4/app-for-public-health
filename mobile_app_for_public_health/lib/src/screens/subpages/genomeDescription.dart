import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant_medicament.dart';
import 'package:mobile_app_for_public_health/src/data/genome_variant.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class GenomeDescription extends StatelessWidget {
  final String geneVariant;

  GenomeDescription(this.geneVariant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genome Description'),
      ),
      body: Center(
        child: Text('Gene Variant: $geneVariant'),
      ),
    );
  }
}