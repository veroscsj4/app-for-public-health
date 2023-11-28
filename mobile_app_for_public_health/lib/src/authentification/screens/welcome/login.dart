import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import 'package:mobile_app_for_public_health/src/authentification/screens/main/dashboardMain.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Benutzername'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Passwort'),
              ),
              SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(()=>dashboardMain());
                          // TODO DB
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          print('Benutzername: $username, Passwort: $password');
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          foregroundColor: whiteColor,
                          backgroundColor: primaryColor,
                          side: BorderSide(color: primaryColor),
                          padding: EdgeInsets.symmetric(vertical: buttonHeight),
                        ),
                        child: Text("Anmelden".toUpperCase())),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: Text('Noch keine Konto? Registrieren Sie sich!',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  SizedBox(height: 32.0),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            foregroundColor: primaryColor,
                            backgroundColor: whiteColor,
                            side: BorderSide(color: primaryColor),
                            padding:
                                EdgeInsets.symmetric(vertical: buttonHeight),
                          ),
                          child: Text("Registrieren".toUpperCase()))),
                ],
              )
            ],
          )),
    );
  }
}
