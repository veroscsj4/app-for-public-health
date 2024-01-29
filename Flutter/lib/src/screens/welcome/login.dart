import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/screens/main/homePage.dart';
import 'package:mobile_app_for_public_health/src/screens/welcome/registration.dart';
import 'package:get/get.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: Theme.of(context).textTheme.bodySmall),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Theme.of(context).textTheme.bodySmall),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const HomePage());
                          // TODO DB
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          print('Username: $username, Password: $password');
                        },
                        style: Theme.of(context).outlinedButtonTheme.style,
                        child: Text("Login".toUpperCase())),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: Text('No account yet? Register now!',
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                  const SizedBox(height: 32.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const RegistrationPage());
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text("Register here".toUpperCase())
                    )
                  ),
                ],
              )
            ],
          )),
    );
  }
}
