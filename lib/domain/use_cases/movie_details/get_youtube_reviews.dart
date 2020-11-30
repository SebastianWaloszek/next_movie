import 'package:meta/meta.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';

import '../../../common/error/failure.dart';
import '../../../common/result/result.dart';
import '../use_case.dart';

class GetYouTubeReviews extends UseCase<List<YouTubeVideo>, String> {
  final MovieRepository movieRepository;

  GetYouTubeReviews({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<List<YouTubeVideo>, Failure>> call(String movieTitle) {
    return movieRepository.getYouTubeReviews(movieTitle);
  }
}
