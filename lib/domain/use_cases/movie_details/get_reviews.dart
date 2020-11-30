import 'package:meta/meta.dart';

import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';
import 'package:next_movie/domain/use_cases/use_case.dart';

class GetReviews extends UseCase<List<MovieReview>, String> {
  final MovieRepository movieRepository;

  GetReviews({
    @required this.movieRepository,
  }) : assert(movieRepository != null);

  @override
  Future<Result<List<MovieReview>, Failure>> call(String rottenTomatoesId) {
    return movieRepository.getReviews(rottenTomatoesId);
  }
}
