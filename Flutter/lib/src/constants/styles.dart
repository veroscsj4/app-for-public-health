import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* Here you will find all the standard styles of the app. */ 

/* List of Colors */

const primaryColor = Color.fromARGB(255, 121, 136, 247);
const secondaryColor = const Color(0xFFF17732);
const blackColor = const Color(0xFF000000);
const whiteColor = const Color(0xFFFFFFFF);
const textColor = const Color.fromARGB(255, 0, 0, 0);
const titleColor = const Color(0xFF1F2278);
const lightGreyColor = Color.fromARGB(255, 220, 220, 220);

/* Sizes */

const defaultSize = 30.0;
const buttonHeight = 15.0;

/* Text Styles */
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor,
    brightness: Brightness.light,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: GoogleFonts.poppins(
        color: textColor,
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: GoogleFonts.poppins(
        color: textColor,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      headlineLarge: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 38,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: GoogleFonts.poppins(color: textColor, fontSize: 40),
      labelMedium: GoogleFonts.poppins(color: textColor, fontSize: 35),
      labelSmall: GoogleFonts.poppins(color: textColor, fontSize: 30),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        side: const BorderSide(color: primaryColor),
        backgroundColor: whiteColor,
        padding: const EdgeInsets.symmetric(vertical: buttonHeight),
        textStyle: const TextStyle(fontSize: 15, fontFamily: 'poppins'),
        foregroundColor: primaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      foregroundColor: whiteColor,
      backgroundColor: primaryColor,
      side: const BorderSide(color: primaryColor),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      textStyle: const TextStyle(fontSize: 15, fontFamily: 'poppins'),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      toolbarHeight: 100,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(40),
      bottomRight: Radius.circular(40))),
    )  
  );
}
