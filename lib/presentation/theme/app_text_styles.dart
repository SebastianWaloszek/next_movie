import 'package:flutter/material.dart';

import 'color/app_colors.dart';

/// Text styles used throughout the app.
abstract class AppTextStyles {
  static const fontFamily = 'Lato';

  //          //
  //  CUSTOM  //
  //          //
  static TextStyle custom(
    BuildContext context, {
    @required double fontSize,
    Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    assert(fontSize != null, 'You need to specify a fontSize!');
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
    );
  }

  //          //
  // HEADLINE //
  //          //
  static TextStyle headline1(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 24,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headline2(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 18,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headline3(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle headline4(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 14,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }

  //          //
  //   Body   //
  //          //
  static TextStyle body1(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 18,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle body2(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  static TextStyle body3(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.primaryContent(context),
      fontSize: 12,
      fontFamily: fontFamily,
      fontWeight: FontWeight.normal,
    );
  }

  //          //
  // SUBTITLE //
  //          //
  static TextStyle subtitle1(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.secondaryContent(context),
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle subtitle2(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.secondaryContent(context),
      fontSize: 14,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle subtitle3(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.secondaryContent(context),
      fontSize: 12,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w300,
    );
  }

  //          //
  //  BUTTON  //
  //          //
  static TextStyle button1(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.buttonContent(context),
      fontSize: 22,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle button2(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.buttonContent(context),
      fontSize: 16,
      fontFamily: fontFamily,
      fontWeight: FontWeight.w900,
    );
  }

  //         //
  //  ERROR  //
  //         //
  static TextStyle error(BuildContext context, {double fontSize = 16, FontWeight fontWeight}) {
    return custom(
      context,
      color: AppColors.error(context),
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  //              //
  //  BOTTOM BAR  //
  //              //
  static TextStyle bottomBar(BuildContext context, {Color color}) {
    return TextStyle(
      color: color ?? AppColors.secondaryContent(context),
      fontSize: 8,
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
    );
  }
}
