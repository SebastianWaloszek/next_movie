import 'package:meta/meta.dart';

import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/load_movies_parameters.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';
import 'package:next_movie/domain/use_cases/use_case.dart';

class LoadMovies extends UseCase<void, LoadMoviesParameters> {
  final MovieRepository movieRepository;

  LoadMovies({@required this.movieRepository}) : assert(movieRepository != null);

  @override
  Future<Result<void, Failure>> call(LoadMoviesParameters parameters) {
        return movieRepository.getMovies(parameters);
  }
}
