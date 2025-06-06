import 'package:flutter/material.dart';

class Tcolor {
  // Primary colors
  static Color get primary => Color.fromRGBO(221, 145, 0, 1);
  static Color get primaryDark => Color.fromRGBO(189, 124, 0, 1);
  static Color get primaryLight => Color.fromRGBO(255, 183, 51, 1);

  // Text colors
  static Color get primaryText => Color.fromRGBO(96, 81, 72, 1);
  static Color get secondaryText => Color.fromRGBO(128, 85, 59, 1);
  static Color get lightText => Color.fromRGBO(149, 147, 147, 1);

  // UI element colors
  static Color get textfield => Color.fromRGBO(217, 217, 217, 1);
  static Color get placeholder => Color.fromRGBO(149, 147, 147, 1);
  static Color get background => Color.fromRGBO(255, 252, 247, 1);
  static Color get card => Color.fromRGBO(255, 248, 235, 1);

  // Accent colors
  static Color get accent => Color.fromRGBO(77, 135, 237, 1); // Blue accent
  static Color get success =>
      Color.fromRGBO(75, 181, 67, 1); // Green for success states
  static Color get error =>
      Color.fromRGBO(233, 86, 63, 1); // Red for error states

  // Standard colors
  static const Color white = Colors.white;
  static const Color black = Colors.black87;

  // Gradient colors
  static List<Color> get primaryGradient => [
        Color.fromRGBO(221, 145, 0, 1),
        Color.fromRGBO(255, 183, 51, 1),
      ];
}
