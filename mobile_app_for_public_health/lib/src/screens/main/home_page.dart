import 'package:flutter/material.dart';

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
              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
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
            const Text(
              'Welcome, Mustermann!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Hier können Sie die Liste der Medikamente finden, die mit Ihren genetischen Variationen unverträglich sein könnten, zusammen mit den dazugehörigen Nebenwirkungen.',
            ),
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
