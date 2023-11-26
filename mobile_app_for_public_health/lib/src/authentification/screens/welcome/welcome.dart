import 'package:flutter/material.dart';
import 'package:mobile_app_for_public_health/src/constants/styles.dart';
import '../../../constants/img_path.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(defaultSize),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(image: AssetImage(welcomePNG), height: height * 0.5),
            Column(
              children: [
                Text(
                  "Willkommen",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Willkommen",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Lorem ipsum dolor sit amet",
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: primaryColor,
                        backgroundColor: whiteColor,
                        side:BorderSide(color: primaryColor ),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight),
                      ), 
                      child: Text("Anmelden".toUpperCase()),
                      ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(

                  child: ElevatedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: whiteColor,
                        backgroundColor: primaryColor,
                        side:BorderSide(color: primaryColor),
                        padding: EdgeInsets.symmetric(vertical: buttonHeight),
                      ), 
                      child: Text("Registrieren".toUpperCase())),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
