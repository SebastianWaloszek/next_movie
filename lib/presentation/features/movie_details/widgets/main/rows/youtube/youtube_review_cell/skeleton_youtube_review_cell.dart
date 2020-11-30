import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/youtube/youtube_review_cell/youtube_review_cell.dart';
import 'package:next_movie/presentation/widgets/skeleton.dart';

class SkeletonYoutubeReviewCell extends YoutubeReviewCell {
  const SkeletonYoutubeReviewCell({
    Key key,
    EdgeInsets margin,
  }) : super.toSuper(
          key: key,
          margin: margin,
        );

  @override
  Widget buildThumbnailImage() {
    return const Skeleton(
      width: 187,
    );
  }

  @override
  Widget buildNameText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: const Skeleton(
        height: 14,
        width: 125,
      ),
    );
  }

  @override
  Widget buildChannelNameText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: const Skeleton(
        height: 14,
        width: 75,
      ),
    );
  }
}
