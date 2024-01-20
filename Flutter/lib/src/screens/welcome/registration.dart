import 'package:flutter/material.dart';


class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? chooseSex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration', 
        style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name', 
              labelStyle: Theme.of(context).textTheme.bodySmall),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-Mail Address', 
              labelStyle: Theme.of(context).textTheme.bodySmall),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password', 
              labelStyle: Theme.of(context).textTheme.bodySmall),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age', 
              labelStyle: Theme.of(context).textTheme.bodySmall),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: chooseSex,
              hint: Text('Select Sex',
              style: Theme.of(context).textTheme.bodySmall),
              onChanged: (value) {
                setState(() {
                  chooseSex = value;
                });
              },
              items: ['Masculine', 'Feminine'].map((sex) {
                return DropdownMenuItem<String>(
                  value: sex,
                  child: Text(sex, style: Theme.of(context).textTheme.bodySmall),
                );
              }).toList(),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                // Hier Registrierungslogik implementieren
                Beispiel: print('Name: ${nameController.text}');
              },
              child: Text('Register'.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}