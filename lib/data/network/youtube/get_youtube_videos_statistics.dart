import 'package:meta/meta.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/data/models/youtube_video_statistics_model.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video_statistics.dart';
import '../../../common/network/request.dart';

class GetYouTubeVideosStatisticsRequest extends Request<List<YouTubeVideoStatistics>> {
  static const _baseUrl = 'https://www.googleapis.com/youtube/v3/videos';
  static String _reduceVideoIds(List<String> videoIds) => videoIds.reduce((String value, String id) => '$value,$id');

  GetYouTubeVideosStatisticsRequest({
    @required List<String> videoIds,
  })  : assert(videoIds != null),
        super(
          path: '$_baseUrl?part=contentDetails%2Cstatistics&key=${Environment.current.youTubeApiKey}&id=${_reduceVideoIds(videoIds)}',
        );

  @override
  List<YouTubeVideoStatistics> createResponse(dynamic json) => List<YouTubeVideoStatistics>.of(
        (json['items'] as List<dynamic>).map<YouTubeVideoStatisticsModel>(
          (item) => YouTubeVideoStatisticsModel.fromJson(item as Map<String, dynamic>),
        ),
      );
}
