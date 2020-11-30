import 'package:flutter/material.dart';

/// Device specific parameters and functions.
abstract class Device {
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static double width(BuildContext context) => MediaQuery.of(context).size.width;

  static bool hasSmallHeight(BuildContext context) => height(context) < 600;

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
