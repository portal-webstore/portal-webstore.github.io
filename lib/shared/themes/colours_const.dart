import 'package:flutter/material.dart'
    show Color, MaterialAccentColor, MaterialColor;

/// From quick colour wheel calculator generator given primary colour.
class ThemeColour {
  static const MaterialColor blue = MaterialColor(
    _customBlueValue,
    <int, Color>{
      50: Color(0xFFE7EAF3),
      100: Color(0xFFC2CBE0),
      200: Color(0xFF9AA9CB),
      300: Color(0xFF7286B6),
      400: Color(0xFF536CA7),
      500: Color(_customBlueValue),
      600: Color(0xFF304B8F),
      700: Color(0xFF284184),
      800: Color(0xFF22387A),
      900: Color(0xFF162869),
    },
  );
  static const int _customBlueValue = 0xFF355297;

  static const MaterialAccentColor blueAccent = MaterialAccentColor(
    _customBlueAccentValue,
    <int, Color>{
      100: Color(0xFFA1B3FF),
      200: Color(_customBlueAccentValue),
      400: Color(0xFF3B61FF),
      700: Color(0xFF224CFF),
    },
  );
  static const int _customBlueAccentValue = 0xFF6E8AFF;
}
