import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_for_public_health/src/screens/welcome/loadData.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';


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
          style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.white),
        ),
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
                Get.to(() => const UploadPage());
              },
              child: Text('Register'.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}