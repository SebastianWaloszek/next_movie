import 'package:equatable/equatable.dart';
import 'package:next_movie/common/parameters/movie_result.dart';
import 'package:next_movie/domain/entities/person.dart';
import 'package:meta/meta.dart';

class LoadCreditedMoviesParameters extends Equatable {
  final Person person;
  final int currentMovieId;
  final List<int> movieIds;
  final int page;
  final Sink<MovieResult> movieSink;

  const LoadCreditedMoviesParameters({
    @required this.person,
    @required this.currentMovieId,
    this.movieIds,
    this.page,
    @required this.movieSink,
  })  : assert(person != null),
        assert(currentMovieId != null),
        assert(movieSink != null);

  LoadCreditedMoviesParameters copyWith({List<int> movieIds}) {
    return LoadCreditedMoviesParameters(
      person: person,
      currentMovieId: currentMovieId,
      movieIds: movieIds ?? this.movieIds,
      page: page,
      movieSink: movieSink,
    );
  }

  @override
  List<Object> get props => [
        person,
        currentMovieId,
        movieIds,
        page,
        movieSink,
      ];
}
