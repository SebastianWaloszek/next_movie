import 'package:equatable/equatable.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video_statistics.dart';

abstract class YouTubeVideo extends Equatable {
  final String id;
  final String thumbnailUrl;
  final String title;
  final String description;
  final DateTime publishedAt;
  final String channelTitle;
  final YouTubeVideoStatistics statistics;

  const YouTubeVideo({
    this.id,
    this.thumbnailUrl,
    this.title,
    this.description,
    this.publishedAt,
    this.channelTitle,
    this.statistics,
  });

  @override
  List<Object> get props => [
        id,
        thumbnailUrl,
        title,
        description,
        publishedAt,
        channelTitle,
        statistics,
      ];
}
