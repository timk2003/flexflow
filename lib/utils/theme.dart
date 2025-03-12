import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}