import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Skeleton extends StatelessWidget {
  final double width;
  final double height;

  const Skeleton({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: AppColors.skeletonShimmer(context),
      gradientColor: AppColors.skeletonGradient(context),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.secondaryBackground(context),
        ),
      ),
    );
  }
}
