import 'dart:ui';

import 'package:flutter/material.dart';

import 'theme_colors.dart';
import 'themed_color.dart';

/// Colors based on theme used throughout the app.
abstract class AppColors {
  static Color background(BuildContext context) => ThemedColor(
        light: LightThemeColors.background,
        dark: DarkThemeColors.background,
      ).getColor(context);

  static Color secondaryBackground(BuildContext context) => ThemedColor(
        light: LightThemeColors.secondaryBackground,
        dark: DarkThemeColors.secondaryBackground,
      ).getColor(context);

  static Color primaryContent(BuildContext context) => ThemedColor(
        light: LightThemeColors.primaryContent,
        dark: DarkThemeColors.primaryContent,
      ).getColor(context);

  static Color secondaryContent(BuildContext context) => ThemedColor(
        light: LightThemeColors.secondaryContent,
        dark: DarkThemeColors.secondaryContent,
      ).getColor(context);

  static Color primaryAccent(BuildContext context) => ThemedColor(
        light: LightThemeColors.primaryAccent,
        dark: DarkThemeColors.primaryAccent,
      ).getColor(context);

  static Color secondaryAccent(BuildContext context) => ThemedColor(
        light: LightThemeColors.secondaryAccent,
        dark: DarkThemeColors.secondaryAccent,
      ).getColor(context);

  static Color buttonContent(BuildContext context) => ThemedColor(
        light: LightThemeColors.buttonContent,
        dark: DarkThemeColors.buttonContent,
      ).getColor(context);

  static Color error(BuildContext context) => ThemedColor(
        light: LightThemeColors.error,
        dark: DarkThemeColors.error,
      ).getColor(context);

  static Color shadow(BuildContext context) => ThemedColor(
        light: LightThemeColors.shadow,
        dark: DarkThemeColors.shadow,
      ).getColor(context);

  static Color navigationBar(BuildContext context) => ThemedColor(
        light: LightThemeColors.navigationBar,
        dark: DarkThemeColors.navigationBar,
      ).getColor(context);

  static Color red(BuildContext context) => ThemedColor(
        light: LightThemeColors.red,
        dark: DarkThemeColors.red,
      ).getColor(context);

  static Color yellow(BuildContext context) => ThemedColor(
        light: LightThemeColors.yellow,
        dark: DarkThemeColors.yellow,
      ).getColor(context);

  static Color green(BuildContext context) => ThemedColor(
        light: LightThemeColors.green,
        dark: DarkThemeColors.green,
      ).getColor(context);

  static Color skeletonShimmer(BuildContext context) => ThemedColor(
        light: LightThemeColors.skeletonShimmer,
        dark: DarkThemeColors.skeletonShimmer,
      ).getColor(context);

  static Color skeletonGradient(BuildContext context) => ThemedColor(
        light: LightThemeColors.skeletonGradient,
        dark: DarkThemeColors.skeletonGradient,
      ).getColor(context);
}
