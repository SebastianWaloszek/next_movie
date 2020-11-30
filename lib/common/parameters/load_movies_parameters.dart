import 'package:equatable/equatable.dart';
import 'package:next_movie/common/parameters/movie_result.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:meta/meta.dart';

class LoadMoviesParameters extends Equatable {
  final MovieListType listType;
  final int page;
  final Sink<MovieResult> listMovieSink;

  const LoadMoviesParameters({
    @required this.listType,
    @required this.page,
    @required this.listMovieSink,
  })  : assert(listType != null),
        assert(page != null),
        assert(listMovieSink != null);

  @override
  List<Object> get props => [
        listType,
        page,
        listMovieSink,
      ];
}
