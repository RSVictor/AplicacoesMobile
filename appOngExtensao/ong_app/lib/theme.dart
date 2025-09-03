import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.pink,
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 14),
      textStyle: TextStyle(fontSize: 16),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  ),
);
