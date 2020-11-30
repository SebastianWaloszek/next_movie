
import 'package:meta/meta.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';

import '../../../common/error/failure.dart';
import '../../../common/result/result.dart';
import '../use_case.dart';

class GetMovieReleaseDates extends UseCase<CountryReleaseDates, int> {
  final MovieRepository movieRepository;

  GetMovieReleaseDates({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<CountryReleaseDates, Failure>> call(int movieId) {
    return movieRepository.getMovieReleaseDates(movieId);
  }
}