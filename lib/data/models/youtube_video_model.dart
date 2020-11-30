import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video_statistics.dart';

class YouTubeVideoModel extends YouTubeVideo {
  const YouTubeVideoModel({
    String id,
    String thumbnailUrl,
    String title,
    String description,
    DateTime publishedAt,
    String channelTitle,
    YouTubeVideoStatistics statistics,
  }) : super(
          id: id,
          thumbnailUrl: thumbnailUrl,
          title: title,
          description: description,
          publishedAt: publishedAt,
          channelTitle: channelTitle,
          statistics: statistics,
        );

  factory YouTubeVideoModel.fromJson(Map<String, dynamic> json) {
    final videoId = json['id']['videoId'];
    return YouTubeVideoModel(
      id: videoId as String,
      thumbnailUrl: videoId != null ? 'https://img.youtube.com/vi/${json['id']['videoId']}/mqdefault.jpg' : null,
      title: json['snippet']['title'] as String,
      description: json['description'] as String,
      publishedAt: DateTime.parse(json['snippet']['publishedAt'] as String),
      channelTitle: json['snippet']['channelTitle'] as String,
    );
  }

  YouTubeVideoModel copyWith({YouTubeVideoStatistics statistics}) {
    return YouTubeVideoModel(
      id: id,
      thumbnailUrl: thumbnailUrl,
      title: title,
      description: description,
      publishedAt: publishedAt,
      channelTitle: channelTitle,
      statistics: statistics ?? this.statistics,
    );
  }
}
