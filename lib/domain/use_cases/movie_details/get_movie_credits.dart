import 'package:meta/meta.dart';

import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';
import 'package:next_movie/domain/use_cases/use_case.dart';

class GetMovieCredits extends UseCase<Credits, int> {
  final MovieRepository movieRepository;

  GetMovieCredits({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<Credits, Failure>> call(int movieId) {
    return movieRepository.getMovieCredits(movieId);
  }
}
