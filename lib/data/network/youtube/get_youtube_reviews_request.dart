import 'package:meta/meta.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/data/models/youtube_video_model.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import '../../../common/network/request.dart';

class GetYouTubeReviewsRequest extends Request<List<YouTubeVideo>> {
  static String _formatForQuerry(String movieTitle) {
    return movieTitle.replaceAll(' ', '%20').replaceAll('&', '%20'); // TODO temporary solution
  }

  static const String reviewSearchKeyword = "Review";

  static const String _partParameter = 'part=id%2Csnippet';
  static const String _maxResultsParameter = 'maxResults=10';
  static String get _apiKeyParameter => 'key=${Environment.current.youTubeApiKey}';

  static String _getQueryParameter(String movieTitle) => 'q=${_formatForQuerry(movieTitle)}%20$reviewSearchKeyword';

  GetYouTubeReviewsRequest({
    @required String movieTitle,
  })  : assert(movieTitle != null),
        super(
          path: 'https://www.googleapis.com/youtube/v3/search?$_partParameter&$_maxResultsParameter&${_getQueryParameter(movieTitle)}&$_apiKeyParameter',
        );

  @override
  List<YouTubeVideo> createResponse(dynamic json) => List<YouTubeVideo>.from(
        (json['items'] as List<dynamic>).map(
          (item) => YouTubeVideoModel.fromJson(item as Map<String, dynamic>),
        ),
      );
}
