import 'package:meta/meta.dart';
import 'package:next_movie/common/parameters/movie_images.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';

import '../../../common/error/failure.dart';
import '../../../common/result/result.dart';
import '../use_case.dart';

class GetMovieImages extends UseCase<MovieImages, int> {
  final MovieRepository movieRepository;

  GetMovieImages({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<MovieImages, Failure>> call(int movieId) {
    return movieRepository.getImages(movieId);
  }
}