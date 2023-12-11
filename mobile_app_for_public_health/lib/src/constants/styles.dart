import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* List of Colors */

const primaryColor = Color(0xFF565ACF);
const secondaryColor = Color(0xFFF17732);
const blackColor = Color(0xFF000000);
const whiteColor = Color(0xFFFFFFFF);
const textColor = Color(0xFF444444);
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
      bodyLarge: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
       bodyMedium: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
       bodySmall: GoogleFonts.montserrat(
        color: titleColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.poppins(color: textColor, fontSize: 50),
      headlineMedium: GoogleFonts.poppins(color: textColor, fontSize: 45),
      headlineSmall: GoogleFonts.poppins(color: textColor, fontSize: 40),
      titleLarge: GoogleFonts.poppins(color: textColor, fontSize: 45),
      titleMedium: GoogleFonts.poppins(color: textColor, fontSize: 40),
      titleSmall: GoogleFonts.poppins(color: textColor, fontSize: 35),
      labelLarge: GoogleFonts.poppins(color: textColor, fontSize: 40),
      labelMedium: GoogleFonts.poppins(color: textColor, fontSize: 35),
      labelSmall: GoogleFonts.poppins(color: textColor, fontSize: 30),
    ),
  );
}
