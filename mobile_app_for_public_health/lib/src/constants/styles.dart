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
        fontSize: 45,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: GoogleFonts.poppins(
        color: textColor,
        fontSize: 30), 
    ),
  );
}