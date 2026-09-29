import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF22C55E);
  static const primaryLight = Color(0xFFE9F9EF);
  static const dark = Color(0xFF0D0D12);
  static const grey = Color(0xFF818898);
  static const grey300 = Color(0xFFA4ACB9);
  static const grey200 = Color(0xFFC1C7D0);
  static const border = Color(0xFFDFE1E7);
  static const surface = Color(0xFFF6F8FA);
}

// Stilurile de text din Figma: majoritatea au letter spacing -2%,
// titlurile au 0.
TextStyle textStyle(
  double size,
  FontWeight weight,
  Color color, {
  double height = 1.55,
  double spacing = -0.02,
}) {
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    letterSpacing: size * spacing,
  );
}
