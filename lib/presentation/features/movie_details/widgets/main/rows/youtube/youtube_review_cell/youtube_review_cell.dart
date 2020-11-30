import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/widget_extensions.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/youtube/youtube_review_cell/filled_youtube_review_cell.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/youtube/youtube_review_cell/skeleton_youtube_review_cell.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

abstract class YoutubeReviewCell extends StatelessWidget {
  final YouTubeVideo video;
  final EdgeInsets margin;
  final void Function(String) onSelected;

  factory YoutubeReviewCell({
    Key key,
    YouTubeVideo video,
    EdgeInsets margin,
    Function(String) onSelected,
  }) {
    final hasEnoughData = video != null;
    if (hasEnoughData) {
      return FilledYoutubeReviewCell(
        key: key,
        video: video,
        margin: margin,
        onSelected: onSelected,
      );
    }
    return SkeletonYoutubeReviewCell(
      key: key,
      margin: margin,
    );
  }

  const YoutubeReviewCell.toSuper({
    Key key,
    this.video,
    this.margin,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: margin,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () => onSelected?.call(video.id),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(context),
            _buildNameTextContainer(context),
            buildChannelNameText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      width: 180,
      height: 104,
      decoration: BoxDecoration(
        boxShadow: cellShadow(context),
        color: AppColors.background(context),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: buildThumbnailImage(),
      ),
    );
  }

  Widget buildThumbnailImage();

  Widget _buildNameTextContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: buildNameText(context),
    );
  }

  Widget buildNameText(BuildContext context);

  Widget buildChannelNameText(BuildContext context);
}
