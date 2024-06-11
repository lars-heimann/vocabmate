import 'package:flutter/material.dart';

final _colorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF9B59B6), // Lilac violet seed color
);

const deepViolet = Color(0xFF2C003E);
const mediumViolet = Color(0xFF6A0572);
const lightViolet = Color(0xFFB39DDB);
const veryLightViolet = Color(0xFFE6E6FA);
const _fontFamily = 'Ubuntu';

final vocabMateTheme = ThemeData(
  colorScheme: _colorScheme,
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: _colorScheme.inversePrimary,
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
  ),
  fontFamily: _fontFamily,
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: deepViolet,
        displayColor: deepViolet,
        fontFamily: _fontFamily,
      ),
  scaffoldBackgroundColor: veryLightViolet,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: TargetPlatform.values.asMap().map(
          (key, value) => MapEntry(
            value,
            const FadeUpwardsPageTransitionsBuilder(),
          ),
        ),
  ),
);
