import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker/services/theme_service.dart'; // Update with actual package path

void main() {
  group('ThemeService', () {
    test('Light Theme - primary colors and general settings', () {
      final lightTheme = ThemeService.lightTheme;

      // General Theme Checks
      expect(lightTheme.brightness, Brightness.light);
      expect(lightTheme.primaryColor, AppColors.primaryColor);
      expect(lightTheme.scaffoldBackgroundColor, AppColors.backgroundLight);

      // Color Scheme
      final lightColorScheme = lightTheme.colorScheme;
      expect(lightColorScheme.primary, AppColors.primaryColor);
      expect(lightColorScheme.onPrimary, Colors.white);
      expect(lightColorScheme.secondary, AppColors.secondaryColor);
      expect(lightColorScheme.onSecondary, AppColors.onSecondaryColor);
      expect(lightColorScheme.tertiary, AppColors.tertiary);
      expect(lightColorScheme.error, AppColors.errorColor);
      expect(lightColorScheme.onError, Colors.white);
      expect(lightColorScheme.surface, AppColors.surfaceLight);
      expect(lightColorScheme.onSurface, Colors.black);
    });

    test('Light Theme - AppBar theme', () {
      final lightTheme = ThemeService.lightTheme;

      final appBarTheme = lightTheme.appBarTheme;
      expect(appBarTheme.backgroundColor, AppColors.primaryColor);
      expect(appBarTheme.foregroundColor, Colors.white);
      expect(appBarTheme.elevation, 0);
    });

    test('Light Theme - Text styles', () {
      final lightTheme = ThemeService.lightTheme;

      final textTheme = lightTheme.textTheme;
      expect(textTheme.displayLarge?.fontSize, 57);
      expect(textTheme.displayLarge?.fontWeight, FontWeight.bold);
      expect(textTheme.displayLarge?.color, AppColors.onPrimaryColor);

      expect(textTheme.titleMedium?.fontSize, 16);
      expect(textTheme.titleMedium?.fontWeight, FontWeight.w400);
      expect(textTheme.titleMedium?.color, AppColors.onPrimaryColor);

      expect(textTheme.bodySmall?.fontSize, 12);
      expect(textTheme.bodySmall?.fontWeight, FontWeight.w400);
      expect(textTheme.bodySmall?.color, AppColors.onPrimaryColor);
    });

    test('AppColors - Ensure consistency', () {
      expect(AppColors.primaryColor, Colors.black);
      expect(AppColors.onPrimaryColor, Colors.white);
      expect(AppColors.secondaryColor, Colors.white);
      expect(AppColors.onSecondaryColor, Colors.black);
      expect(AppColors.tertiary, Colors.grey);
      expect(AppColors.errorColor, const Color(0xFFB00020));
      expect(AppColors.successColor, Colors.green);
      expect(AppColors.highLightColor, Colors.blue);
      expect(AppColors.backgroundLight, Colors.black);
      expect(AppColors.surfaceLight, Colors.black);
    });
  });
}
