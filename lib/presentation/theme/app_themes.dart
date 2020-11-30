import 'package:flutter/material.dart';

import 'color/theme_colors.dart';

final Map<ThemeMode, ThemeData> appThemes = {
  ThemeMode.light: ThemeData(
    accentColor: LightThemeColors.primaryAccent,
    primaryColor: LightThemeColors.primaryAccent,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.transparent,
    brightness: Brightness.light,
  ),
  ThemeMode.dark: ThemeData(
    accentColor: DarkThemeColors.primaryAccent,
    canvasColor: Colors.transparent,
    scaffoldBackgroundColor: DarkThemeColors.background,
    brightness: Brightness.dark,
    dividerTheme: const DividerThemeData(space: 1),
  )
};
