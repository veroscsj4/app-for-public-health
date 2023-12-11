import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* List of Colors */

const primaryColor = Color(0xFF565ACF);
const secondaryColor = Color(0xFFF17732);
const blackColor = Color(0xFF000000);
const whiteColor = Color(0xFFFFFFFF);
const textColor = Color.fromARGB(255, 0, 0, 0);
const titleColor = Color(0xFF1F2278);

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
        fontSize: 50,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: GoogleFonts.poppins(color: textColor, fontSize: 40),
      labelMedium: GoogleFonts.poppins(color: textColor, fontSize: 35),
      labelSmall: GoogleFonts.poppins(color: textColor, fontSize: 30),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        side: BorderSide(color: primaryColor),
        backgroundColor: whiteColor,
        padding: EdgeInsets.symmetric(vertical: buttonHeight),
        textStyle: TextStyle(fontSize: 15, fontFamily: 'poppins'),
        foregroundColor: primaryColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: whiteColor,
      backgroundColor: primaryColor,
      side: const BorderSide(color: primaryColor),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
      textStyle: TextStyle(fontSize: 15, fontFamily: 'poppins'),
      ),
    ),
  );
}
