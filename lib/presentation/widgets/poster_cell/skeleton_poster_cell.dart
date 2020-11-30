import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/widgets/poster_cell/poster_cell.dart';
import 'package:next_movie/presentation/widgets/poster_image.dart';
import 'package:next_movie/presentation/widgets/skeleton.dart';

class SkeletonPosterCell extends PosterCell {
  const SkeletonPosterCell({Key key}) : super.toSuper(key: key);

  @override
  Widget buildRatings() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: const Skeleton(
        height: 22,
        width: 100,
      ),
    );
  }

  @override
  Widget buildPosterImage(BuildContext context) {
    return AspectRatio(
      aspectRatio: PosterImage.aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppThemeConstants.cornerRadius),
        child: const Skeleton(),
      ),
    );
  }

  @override
  Widget buildTitleText(BuildContext context) {
    return const Skeleton(
      height: 28,
    );
  }
}
