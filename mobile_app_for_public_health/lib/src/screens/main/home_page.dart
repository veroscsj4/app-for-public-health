import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import '../../constants/img_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF565ACF),
        title: Row(children: [
          CircleAvatar(
            backgroundImage: AssetImage(''),
            radius: 20.0,
          ),
          SizedBox(width: 10.0),
          Text('Hallo Mustermann',
           style: Theme.of(context).textTheme.titleSmall,
           textAlign: TextAlign.center),
        ],)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display User's Name at the Top
            const Text(
              'Welcome, Mustermann!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Hier können Sie die Liste der Medikamente finden, die mit Ihren genetischen Variationen unverträglich sein könnten, zusammen mit den dazugehörigen Nebenwirkungen.'),
            // Table with Information
            DataTable(
              columns: const [
                DataColumn(label: Text('Medikamente')),
                DataColumn(label: Text('Information')),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('Name')),
                  DataCell(Text('John Doe')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Age')),
                  DataCell(Text('30')),
                ]),
                DataRow(cells: [
                  DataCell(Text('Location')),
                  DataCell(Text('City')),
                ]),
                // Add more rows as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

