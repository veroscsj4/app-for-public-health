import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import 'package:mobile_app_for_public_health/src/screens/main/home_page.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Benutzername'),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Passwort'),
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(()=>const HomePage());
                          // TODO DB
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          print('Benutzername: $username, Passwort: $password');
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(),
                          foregroundColor: whiteColor,
                          backgroundColor: primaryColor,
                          side: const BorderSide(color: primaryColor),
                          padding: const EdgeInsets.symmetric(vertical: buttonHeight),
                        ),
                        child: Text("Anmelden".toUpperCase())),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: Text('Noch keine Konto? Registrieren Sie sich!',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                  const SizedBox(height: 32.0),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            foregroundColor: primaryColor,
                            backgroundColor: whiteColor,
                            side: const BorderSide(color: primaryColor),
                            padding:
                                const EdgeInsets.symmetric(vertical: buttonHeight),
                          ),
                          child: Text("Registrieren".toUpperCase()))),
                ],
              )
            ],
          )),
    );
  }
}
