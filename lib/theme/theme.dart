import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Color(0xFFDDE6ED),  // Backgound color
    primary: Colors.black,
    secondary: Colors.deepOrange.shade100,
    shadow: Colors.black,
    primaryContainer: Color(0xFF9DB2BF),  // for containers like KPI
    secondaryContainer: Color(0xFF9DB2BF),  // for containers like KPI
    tertiary: Color(0xFF26374D), // for text
    tertiaryFixedDim: Color.fromRGBO(82, 109, 130, 0.8), // for text light like Kpi titles
  ),
  
  
  
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(93, 160, 118, 1.0), // primary color in dark
      foregroundColor: Colors.black, // text/icon color
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  
);



ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF0A1931),  // Backgound color
    primary: Colors.black,
    secondary: Colors.deepOrange.shade100,
    shadow: Colors.black,
    primaryContainer: Color(0xFF1A3D63),  // for containers like KPI
    secondaryContainer: Color(0xFF1A3D63),  // for containers like KPI
    tertiary: Color(0xFFB3CFE5), // for text
    tertiaryFixedDim: Color.fromRGBO(167, 201, 223, 0.8), // for text light like Kpi titles

    // surface: Color(0xFF26425A),
    // primary: Colors.white,
    // secondary: Colors.white,
    // shadow: Colors.white,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(243, 111, 33, 1.0), // primary color in dark
      foregroundColor: Colors.white, // text/icon color
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),

);