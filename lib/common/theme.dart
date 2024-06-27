import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF2189FF),
      onPrimary: Colors.white,
      secondary: Color(0xFF17192D),
      tertiary: Color(0xFFD8DFE6),
      primaryContainer: Color(0xFF77818C),
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF2189FF),
      error: Color(0xFFED3833),
      onError: Colors.white,
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme,
     scaffoldBackgroundColor: colorScheme.surface,
  );
}

