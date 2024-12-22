import 'package:flutter/material.dart';

/// A service to provide theme data for the application.
///
/// This service supports light and dark themes with a consistent color palette
/// and typography designed for an expense tracker app.
class ThemeService {
  /// Returns the light theme for the application.
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        onPrimary: Colors.white,
        secondary: AppColors.secondaryColor,
        onSecondary: AppColors.onSecondaryColor,
        tertiary: AppColors.tertiary,
        error: AppColors.errorColor,
        onError: Colors.white,
        surface: AppColors.surfaceLight,
        onSurface: Colors.black,
      ),
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.surfaceLight,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  /// Returns the dark theme for the application.
  // static ThemeData get darkTheme {
  //   return ThemeData(
  //     brightness: Brightness.dark,
  //     primaryColor: AppColors.primaryColor,
  //     scaffoldBackgroundColor: AppColors.backgroundDark,
  //     colorScheme: const ColorScheme.dark(
  //       primary: AppColors.primaryColor,
  //       onPrimary: Colors.white,
  //       secondary: AppColors.secondaryColor,
  //       onSecondary: Colors.white,
  //       error: AppColors.errorColor,
  //       onError: Colors.white,
  //       surface: AppColors.surfaceDark,
  //       onSurface: AppColors.backgroundDark,
  //     ),
  //     textTheme: _textTheme,
  //     appBarTheme: const AppBarTheme(
  //       backgroundColor: AppColors.backgroundDark,
  //       foregroundColor: Colors.white,
  //       elevation: 0,
  //     ),
  //     buttonTheme: const ButtonThemeData(
  //       buttonColor: AppColors.primaryColor,
  //       textTheme: ButtonTextTheme.primary,
  //     ),
  //   );
  // }

  /// Defines the shared text theme across the app.
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.bold,
      color: AppColors.onPrimaryColor,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w600,
      color: AppColors.onPrimaryColor,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w500,
      color: AppColors.onPrimaryColor,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.onPrimaryColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.onPrimaryColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.onPrimaryColor,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: AppColors.onPrimaryColor,
    ),
    titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.onPrimaryColor),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.onPrimaryColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.onPrimaryColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.onPrimaryColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.onPrimaryColor,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.onPrimaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.onPrimaryColor,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.onPrimaryColor,
    ),
  );
}

/// A class to manage color palette for the app.
class AppColors {
  static const primaryColor = Colors.black; // Purple
  static const onPrimaryColor = Colors.white;
  static const secondaryColor = Colors.white; // Teal
  static const onSecondaryColor = Colors.black;
  static const tertiary = Colors.grey;
  static const errorColor = Color(0xFFB00020); // Red
  static const successColor = Colors.green;
  static const highLightColor = Colors.blue;

  static const backgroundLight = Colors.black;
  static const surfaceLight = Colors.black;
}
