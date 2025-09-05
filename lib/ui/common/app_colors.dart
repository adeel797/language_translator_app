import 'package:flutter/material.dart';

/// Centralized color definitions for Light and Dark themes.
class AppColors {
  // 🌞 Light Theme Colors
  static const Color lightPrimary = Color(0xFF4A90E2); // Blue
  static const Color lightSecondary = Color(0xFF50E3C2); // Teal
  static const Color lightBackground = Colors.white;
  static const Color lightText = Colors.black87;
  static const Color lightHint = Colors.black54;

  // 🌙 Dark Theme Colors
  static const Color darkPrimary = Color(0xFF1E3A8A); // Dark blue
  static const Color darkSecondary = Color(0xFF065F46); // Deep teal
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkText = Colors.white;
  static const Color darkHint = Colors.white70;

  /// Gradient for backgrounds
  static LinearGradient lightGradient = const LinearGradient(
    colors: [lightPrimary, lightSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient darkGradient = const LinearGradient(
    colors: [darkPrimary, darkSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
