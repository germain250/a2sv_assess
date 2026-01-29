import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    cardColor: Colors.grey.shade100,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.plusJakartaSans(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(color: Colors.black87),
    ),

    iconTheme: const IconThemeData(color: Colors.black),

    dividerColor: Colors.grey,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    cardColor: Colors.grey.shade900,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(color: Colors.white70),
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    dividerColor: Colors.grey,
  );
}
