import 'package:flutter/material.dart' show ThemeData, VisualDensity;
import 'package:testable_web_app/shared/themes/colours_const.dart'
    show ThemeColour;

final ThemeData customMaterialTheme = ThemeData(
  primarySwatch: ThemeColour.blue,
  accentColor: ThemeColour.blueAccent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
