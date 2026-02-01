import 'package:flutter/material.dart';

/// Tema aplicației și constantele de culori
/// Centralizează toate culorile și stilurile pentru consistență
class AppTheme {
  // Constructor privat
  AppTheme._();

  // Culori principale
  static const Color primaryDark = Color(0xFF223843);
  static const Color primaryDarkGradientStart = Color(0xFF1a2930);
  static const Color primaryDarkGradientEnd = Color(0xFF223843);

  static const Color accent = Color(0xFFD77A61);
  static const Color accentDark = Color(0xFFc96a51);

  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;

  static const Color secondaryLight = Color(0xFFD8B4A0);
  static const Color secondaryLightGradient = Color(0xFFe5c4b0);

  // Shadow Colors
  static Color get shadowLight => Colors.black.withValues(alpha: 0.04);
  static Color get shadowMedium => Colors.black.withValues(alpha: 0.08);
  static Color get shadowDark => Colors.black.withValues(alpha: 0.2);

  // Border Colors
  static Color get borderLight => Colors.grey[200]!;
  static Color get borderMedium => Colors.grey[300]!;

  // Text Colors
  static Color get textPrimary => primaryDark;
  static Color get textSecondary => Colors.grey[600]!;
  static Color get textLight => Colors.grey[400]!;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDarkGradientStart, primaryDarkGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentDark],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondaryLight, secondaryLightGradient],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Border Radius
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;
  static const double radiusRound = 30.0;

  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 12.0;
  static const double spacingLarge = 16.0;
  static const double spacingXLarge = 24.0;
  static const double spacingXXLarge = 32.0;

  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeRegular = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeXLarge = 20.0;
  static const double fontSizeXXLarge = 24.0;
  static const double fontSizeTitle = 32.0;
  static const double fontSizeHero = 38.0;

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeLarge = 24.0;
  static const double iconSizeXLarge = 32.0;
  static const double iconSizeHero = 64.0;

  // Elevation (Shadow blur)
  static const double elevationSmall = 4.0;
  static const double elevationMedium = 8.0;
  static const double elevationLarge = 12.0;
  static const double elevationXLarge = 15.0;

  /// Tema globală a aplicației
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryDark,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDark,
        primary: primaryDark,
        secondary: accent,
      ),
      useMaterial3: true,
    );
  }

  /// BoxShadow pentru carduri
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: shadowMedium,
          blurRadius: elevationXLarge,
          offset: const Offset(0, 8),
          spreadRadius: 0,
        ),
        BoxShadow(
          color: shadowLight,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  /// BoxShadow pentru butoane
  static List<BoxShadow> buttonShadow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.4),
          blurRadius: elevationLarge,
          offset: const Offset(0, 6),
        ),
      ];
}
