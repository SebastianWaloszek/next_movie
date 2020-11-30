import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/youtube/youtube_review_cell/youtube_review_cell.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';

class FilledYoutubeReviewCell extends YoutubeReviewCell {
  const FilledYoutubeReviewCell({
    Key key,
    YouTubeVideo video,
    EdgeInsets margin,
    void Function(String) onSelected,
  }) : super.toSuper(
          key: key,
          video: video,
          margin: margin,
          onSelected: onSelected,
        );

  @override
  Widget buildThumbnailImage() {
    return Image.network(
      video.thumbnailUrl,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget buildNameText(BuildContext context) {
    return Text(
      video.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.headline4(context),
    );
  }

  @override
  Widget buildChannelNameText(BuildContext context) {
    return Text(
      video.channelTitle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.subtitle3(context),
    );
  }
}
