import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278210207),
      surfaceTint: Color(4278214073),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278219490),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278209173),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4278218455),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209173),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278218455),
      onTertiaryContainer: Color(4294967295),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294768888),
      onSurface: Color(4280032027),
      onSurfaceVariant: Color(4282664776),
      outline: Color(4285823096),
      outlineVariant: Color(4291086280),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413680),
      inversePrimary: Color(4289382399),
      primaryFixed: Color(4292273151),
      onPrimaryFixed: Color(4278197054),
      primaryFixedDim: Color(4289382399),
      onPrimaryFixedVariant: Color(4278207886),
      secondaryFixed: Color(4292273151),
      onSecondaryFixed: Color(4278197053),
      secondaryFixedDim: Color(4289316863),
      onSecondaryFixedVariant: Color(4278208140),
      tertiaryFixed: Color(4292273151),
      onTertiaryFixed: Color(4278197053),
      tertiaryFixedDim: Color(4289316863),
      onTertiaryFixedVariant: Color(4278208140),
      surfaceDim: Color(4292729305),
      surfaceBright: Color(4294768888),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374386),
      surfaceContainer: Color(4294045164),
      surfaceContainerHigh: Color(4293650407),
      surfaceContainerHighest: Color(4293255905),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
