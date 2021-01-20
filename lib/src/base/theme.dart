import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static final secondaryTextTheme = GoogleFonts.pacifico();

  static const primaryColor = Colors.blue;
  static final primaryButtonTheme = TextButton.styleFrom(
    shape: StadiumBorder(),
    primary: primaryColor,
    onSurface: primaryColor,
    backgroundColor: Colors.white,
    minimumSize: Size.fromHeight(50),
    textStyle: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
  );

  static final data = ThemeData(
    primaryColor: primaryColor,
  );
}
