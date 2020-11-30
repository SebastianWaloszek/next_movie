
import 'package:meta/meta.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';

import '../../../common/error/failure.dart';
import '../../../common/result/result.dart';
import '../use_case.dart';

class GetRottenTomatoesId extends UseCase<String, Movie> {
  final MovieRepository movieRepository;

  GetRottenTomatoesId({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<String, Failure>> call(Movie movie) {
    return movieRepository.getRottenTomatoesId(movie);
  }
}