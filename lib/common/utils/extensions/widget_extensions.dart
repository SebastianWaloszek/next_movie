import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

extension WidgetExtensions on Widget {
  List<BoxShadow> cellShadow(BuildContext context) {
    return [
      BoxShadow(
        color: AppColors.shadow(context),
        blurRadius: 3,
        offset: const Offset(1, 2),
      )
    ];
  }
}
