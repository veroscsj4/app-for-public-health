import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/screens/welcome/login.dart';
import 'package:mobile_app_for_public_health/src/screens/welcome/registration.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import '../../constants/img_path.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: const AssetImage(welcomePNG), height: height * 0.5),
            Column(
              children: [
                Text(
                  "GenoMedicine",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Medicines customised to your DNA",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(()=>const LoginScreen());
                    },
                    style: Theme.of(context).outlinedButtonTheme.style,
                    child: Text("Login".toUpperCase()),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(()=>const RegistrationPage());
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text("Register here".toUpperCase())
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
