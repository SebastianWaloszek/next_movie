import 'package:meta/meta.dart';
import 'package:next_movie/common/parameters/load_credited_movies.dart';
import 'package:next_movie/common/result/failure_result.dart';
import 'package:next_movie/common/result/success_result.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';
import 'package:next_movie/domain/repositories/people_repository.dart';

import '../../../common/error/failure.dart';
import '../../../common/result/result.dart';
import '../use_case.dart';

class GetCreditedMovies extends UseCase<void, LoadCreditedMoviesParameters> {
  final PeopleRepository peopleRepository;
  final MovieRepository movieRepository;

  GetCreditedMovies({
    @required this.peopleRepository,
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<int, Failure>> call(LoadCreditedMoviesParameters parameters) async {
    final result = await peopleRepository.getCreditedMovies(parameters.person);
    return result.fold(
      onSuccess: (movieIds) {
        final uniqueIds = movieIds.toSet().toList()..remove(parameters.currentMovieId);
        movieRepository.getCreditedMovies(parameters.copyWith(movieIds: uniqueIds));
        return SuccessResult(uniqueIds.length);
      },
      onFailure: (failure) => FailureResult(failure),
    );
  }
}
