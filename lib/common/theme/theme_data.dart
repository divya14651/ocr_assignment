import 'package:flutter/material.dart';
import 'package:ocr_assignment/common/theme/color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize:  Size(double.infinity, 55),
      ),
    ),

    textTheme: TextTheme(
      headlineMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),

      bodyMedium: TextStyle(
        fontSize: 16,
        color: AppColors.black54,
        height: 1.5,
      ),
    ),
  );
}