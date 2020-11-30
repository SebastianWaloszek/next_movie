
import 'package:meta/meta.dart';
import 'package:next_movie/common/parameters/load_similar_movies_parameters.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';

import '../../../common/error/failure.dart';
import '../../../common/result/result.dart';
import '../use_case.dart';

class GetSimilarMovies extends UseCase<void, LoadSimilarMoviesParameters> {
  final MovieRepository movieRepository;
  
  GetSimilarMovies({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<void, Failure>> call(LoadSimilarMoviesParameters parameters) {
    return movieRepository.getSimilarMovies(parameters);
  }
}