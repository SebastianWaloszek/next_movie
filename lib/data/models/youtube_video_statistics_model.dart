import 'package:next_movie/domain/entities/youtube/youtube_video_statistics.dart';

class YouTubeVideoStatisticsModel extends YouTubeVideoStatistics {
  const YouTubeVideoStatisticsModel({
    String videoId,
    int viewCount,
    int likeCount,
    int dislikeCount,
    int commentCount,
    int favoriteCount,
  }) : super(
          videoId: videoId,
          viewCount: viewCount,
          likeCount: likeCount,
          dislikeCount: dislikeCount,
          commentCount: commentCount,
          favoriteCount: favoriteCount,
        );

  factory YouTubeVideoStatisticsModel.fromJson(Map<String, dynamic> json) {
    return YouTubeVideoStatisticsModel(
      videoId: json['id'] as String,
      viewCount: int.tryParse(json['statistics']['viewCount'] as String ?? '0'),
      likeCount: int.tryParse(json['statistics']['likeCount'] as String ?? '0'),
      dislikeCount: int.tryParse(json['statistics']['dislikeCount'] as String ?? '0'),
      commentCount: int.tryParse(json['statistics']['commentCount'] as String ?? '0'),
      favoriteCount: int.tryParse(json['statistics']['favoriteCount'] as String ?? '0'),
    );
  }
}
