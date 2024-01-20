import 'package:flutter/material.dart';
import 'src/constants/styles.dart';
import 'package:get/get.dart';
import 'package:mobile_app_for_public_health/src/screens/welcome/welcome.dart';



void main() {
  runApp(const App()); //Start die App
}
class App extends StatelessWidget{
  const App ({Key? key}): super(key:key);
  
  @override
  Widget build(BuildContext context){
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      home: const WelcomePage(),
      //home: LoginScreen(),
    );
  }
}


