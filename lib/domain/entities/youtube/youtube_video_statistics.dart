import 'package:equatable/equatable.dart';

abstract class YouTubeVideoStatistics extends Equatable {
  final String videoId;
  final int viewCount;
  final int likeCount;
  final int dislikeCount;
  final int commentCount;
  final int favoriteCount;

  const YouTubeVideoStatistics({
    this.videoId,
    this.viewCount,
    this.likeCount,
    this.dislikeCount,
    this.commentCount,
    this.favoriteCount,
  });

  @override
  List<Object> get props => [
    videoId,
    viewCount,
    likeCount,
    dislikeCount,
    commentCount,
    favoriteCount,
  ];
}
