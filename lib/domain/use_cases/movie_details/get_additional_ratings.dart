
import 'package:meta/meta.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';

import '../../../common/error/failure.dart';
import '../../../common/result/result.dart';
import '../use_case.dart';

class GetAdditionalRatings extends UseCase<List<MovieRating>, String> {
  final MovieRepository movieRepository;

  GetAdditionalRatings({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<List<MovieRating>, Failure>> call(String rottenTomatoesId) {
    return movieRepository.getAdditionalRatings(rottenTomatoesId);
  }
}