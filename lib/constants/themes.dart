import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: const Color(0xFF00CCFF), // Background color
  scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Background color
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white, // White text color
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1A1A), // Background color for app bar
    foregroundColor: Colors.white, // Text color for app bar
    iconTheme: IconThemeData(color: Colors.white), // Icon color for app bar
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF1A1A1A)),
  // Add more theme properties as needed
);
