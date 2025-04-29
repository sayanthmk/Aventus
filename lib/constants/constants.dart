import 'package:flutter/material.dart';

class AppThemes {
  static final appTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.grey[100],
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepOrange,
    cardColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.grey[900],
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    ),
  );
}
