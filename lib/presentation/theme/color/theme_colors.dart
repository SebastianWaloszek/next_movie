import 'dart:ui';

import 'package:flutter/material.dart';

abstract class LightThemeColors {
  static Color get background => const Color(0xFFFFFFFF);
  static Color get secondaryBackground => const Color(0xFFE9E9E9);
  static Color get primaryContent => const Color(0xFF444444);
  static Color get secondaryContent => const Color(0xFFA2A2A2);
  static Color get primaryAccent => const Color(0xFF31374F);
  static Color get secondaryAccent => const Color(0xFF31374F);
  static Color get buttonContent => const Color(0xFFFFFFFF);
  static Color get error => Colors.red;
  static Color get shadow => Colors.black.withOpacity(0.25);
  static Color get navigationBar => const Color(0xFFFFFFFF);
  static Color get yellow => const Color(0xFFFFCC33);
  static Color get green => const Color(0xFF80CA4E);
  static Color get red => const Color(0xFFEA3323);
  static Color get skeletonShimmer => const Color(0x8AFFFFFF);
  static Color get skeletonGradient => const Color.fromARGB(0, 244, 244, 244);
}

abstract class DarkThemeColors {
  static Color get background => const Color(0xFF000000);
  static Color get secondaryBackground => const Color(0xFF3e3e3f);
  static Color get primaryContent => const Color(0xFFF5F5F5);
  static Color get secondaryContent => const Color(0xFF7F7F7F);
  static Color get primaryAccent => const Color(0xFFC7482A);
  static Color get secondaryAccent => const Color(0xFFC7482A);
  static Color get buttonContent => const Color(0xFFE1E1E1);
  static Color get error => Colors.red;
  static Color get shadow => Colors.black.withOpacity(0.15);
  static Color get navigationBar => const Color(0xFF2c2c2e);
  static Color get yellow => const Color(0xFFFFCC33);
  static Color get green => const Color(0xFF80CA4E);
  static Color get red => const Color(0xFFEA3323);
  static Color get skeletonShimmer => const Color(0x8A1c1c1e);
  static Color get skeletonGradient => const Color(0x8A3A3A3C);
}
