import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

abstract class AppTheme {
  static ThemeData light(ColorScheme? dynamicScheme) {
    final ColorScheme colorScheme =
        dynamicScheme ?? ColorScheme.fromSeed(seedColor: Colors.lightGreen);

    return ThemeData(useMaterial3: true, colorScheme: colorScheme);
  }

  static ThemeData dark(ColorScheme? dynamicScheme) {
    final ColorScheme colorScheme =
        dynamicScheme ??
        ColorScheme.fromSeed(
          seedColor: Colors.lightGreen,
          brightness: Brightness.dark,
        );

    return ThemeData(useMaterial3: true, colorScheme: colorScheme);
  }
}