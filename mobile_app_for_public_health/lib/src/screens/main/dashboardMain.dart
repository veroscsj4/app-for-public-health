import 'package:flutter/material.dart';
import 'package:get/get.dart';

//gridDelegate = wie breit oder hoch das element sein wird.
class dashboardMain extends StatefulWidget {
  @override
  _dashboardMain createState() => _dashboardMain();
}

class _dashboardMain extends State<dashboardMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hallo Mustermann'),
      ),
      
    );
  }
}
