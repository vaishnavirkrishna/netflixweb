import 'package:flutter/material.dart';

class AppTheme {
  static const Color netflixRed = Color(0xFFE50914);
  static const Color darkBg = Color(0xFF141414);
  static const Color cardBg = Color(0xFF1F1F1F);
  static const Color sidebarBg = Color(0xFF0D0D0D);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    primaryColor: netflixRed,
    colorScheme: const ColorScheme.dark(
      primary: netflixRed,
      onSurface: darkBg,
      
      surface: cardBg,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}