import 'package:flutter/material.dart';

import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_detail_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/youtube/youtube_review_cell/youtube_review_cell.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';

class YoutubeReviewsRow extends StatelessWidget {
  static const placeholderSkeletonCount = 3;
  final List<YouTubeVideo> videos;
  final EdgeInsets margin;

  final void Function(String) showYouTubeVideo;

  const YoutubeReviewsRow({
    Key key,
    this.margin,
    this.videos,
    this.showYouTubeVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194,
      margin: margin,
      child: MovieDetailRow(
        name: AppLocalizations.of(context).youtubeReviews(),
        nameMargin: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        child: _buildYoutubeReviews(),
      ),
    );
  }

  Widget _buildYoutubeReviews() {
    return SizedBox(
      height: 162,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        itemCount: videos?.length ?? placeholderSkeletonCount,
        itemBuilder: (context, index) {
          return YoutubeReviewCell(
            margin: const EdgeInsets.only(right: 25),
            video: videos?.elementAt(index),
            onSelected: showYouTubeVideo,
          );
        },
      ),
    );
  }
}
