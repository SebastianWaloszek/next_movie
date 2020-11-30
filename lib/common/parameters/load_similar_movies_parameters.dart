import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/common/parameters/movie_result.dart';

class LoadSimilarMoviesParameters extends Equatable {
  final int movieId;
  final int page;
  final Sink<MovieResult> similarMovieSink;

  const LoadSimilarMoviesParameters({
    @required this.movieId,
    @required this.page,
    @required this.similarMovieSink,
  })  : assert(movieId != null),
        assert(page != null),
        assert(similarMovieSink != null);

  @override
  List<Object> get props => [
        movieId,
        page,
        similarMovieSink,
      ];
}
