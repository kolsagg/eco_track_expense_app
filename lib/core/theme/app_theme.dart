import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ColorConstants.primary,
        onPrimary: ColorConstants.textLight,
        primaryContainer: ColorConstants.primaryLight,
        onPrimaryContainer: ColorConstants.textPrimary,
        secondary: ColorConstants.secondary,
        onSecondary: ColorConstants.textLight,
        secondaryContainer: ColorConstants.accent,
        onSecondaryContainer: ColorConstants.textLight,
        tertiary: ColorConstants.accent,
        onTertiary: ColorConstants.textLight,
        tertiaryContainer: ColorConstants.accent,
        onTertiaryContainer: ColorConstants.textLight,
        error: ColorConstants.error,
        onError: ColorConstants.textLight,
        background: ColorConstants.background,
        onBackground: ColorConstants.textPrimary,
        surface: ColorConstants.surface,
        onSurface: ColorConstants.textPrimary,
        surfaceVariant: ColorConstants.cardBackground,
        onSurfaceVariant: ColorConstants.textSecondary,
      ),
      scaffoldBackgroundColor: ColorConstants.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorConstants.primary,
        foregroundColor: ColorConstants.textLight,
        titleTextStyle: TextStyle(
          color: ColorConstants.textLight,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: ColorConstants.cardBackground,
        shadowColor: ColorConstants.shadow,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorConstants.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstants.primary.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstants.primary.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstants.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstants.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: ColorConstants.primary,
          foregroundColor: ColorConstants.textLight,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: ColorConstants.primary,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.primary,
        foregroundColor: ColorConstants.textLight,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorConstants.surface,
        selectedItemColor: ColorConstants.primary,
        unselectedItemColor: ColorConstants.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: DividerThemeData(
        color: ColorConstants.textSecondary.withOpacity(0.1),
        thickness: 1,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: ColorConstants.textPrimary),
        displayMedium: TextStyle(color: ColorConstants.textPrimary),
        displaySmall: TextStyle(color: ColorConstants.textPrimary),
        headlineLarge: TextStyle(color: ColorConstants.textPrimary),
        headlineMedium: TextStyle(color: ColorConstants.textPrimary),
        headlineSmall: TextStyle(color: ColorConstants.textPrimary),
        titleLarge: TextStyle(color: ColorConstants.textPrimary),
        titleMedium: TextStyle(color: ColorConstants.textPrimary),
        titleSmall: TextStyle(color: ColorConstants.textPrimary),
        bodyLarge: TextStyle(color: ColorConstants.textPrimary),
        bodyMedium: TextStyle(color: ColorConstants.textPrimary),
        bodySmall: TextStyle(color: ColorConstants.textSecondary),
        labelLarge: TextStyle(color: ColorConstants.textPrimary),
        labelMedium: TextStyle(color: ColorConstants.textPrimary),
        labelSmall: TextStyle(color: ColorConstants.textSecondary),
      ),
    );
  }

  static ThemeData get darkTheme {
    // Dark theme will be implemented later
    return lightTheme;
  }
} 