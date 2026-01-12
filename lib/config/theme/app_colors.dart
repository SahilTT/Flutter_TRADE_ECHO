import 'package:flutter/material.dart';

class AppColors {
  // Common
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // Material Palette (Consolidated from constants.dart)
  static const Color primary = Color(0xFF4CAF50);
  static const Color secondary = Color(0xFF2E7D32);
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF121212);
  static const Color error = Color(0xFFD32F2F);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);

  // Light mode
  static const Color lightBackground = Colors.white;
  static final Color lightCard = Colors.grey[100]!;
  static final Color lightSubCard = Colors.grey[200]!;
  static const Color lightText = Colors.black;
  static const Color lightAppBar = Colors.white;
  static const Color lightSubText = Colors.black54;
  static final Color lightBorder = Colors.grey.withValues(alpha: 0.3);
  static final Color lightShadow = Colors.black.withValues(alpha: 0.1);
  static final Color lightErrorBackground = Colors.red.withValues(alpha: 0.15);
  static final Color lightWarning = Colors.amber[700]!;

  // Dark mode
  static const Color darkBackground = Colors.black;
  static final Color darkCard = Colors.grey[900]!;
  static final Color darkSubCard = Colors.grey[850]!;
  static const Color darkText = Colors.white;
  static const Color darkAppBar = Colors.black;
  static const Color darkSubText = Colors.white60;
  static final Color darkBorder = Colors.grey.withValues(alpha: 0.2);
  static final Color darkShadow = Colors.black.withValues(alpha: 0.1);
  static final Color darkErrorBackground = Colors.red.withValues(alpha: 0.08);
  static final Color darkWarning = Colors.yellow;

  static final Color lightGreyBackground = Colors.grey.withValues(alpha: 0.08);
  static final Color darkGreyBackground = Colors.grey.withValues(alpha: 0.08);
  static final Color lightGreenOpacity = green.withValues(alpha: 0.15);
  static final Color darkGreenOpacity = green.withValues(alpha: 0.6);
  static final Color lightRedOpacity = Colors.red.withValues(alpha: 0.05);

  // Hex color utility
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
