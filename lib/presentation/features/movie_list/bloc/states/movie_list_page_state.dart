import 'package:equatable/equatable.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:meta/meta.dart';

abstract class MovieListPageState extends Equatable {
  final MovieListType selectedMovieListType;
  final int currentListPage;

  const MovieListPageState({
    @required this.selectedMovieListType,
    this.currentListPage,
  }) : assert(selectedMovieListType != null);

  MovieListPageState copyWith({MovieListType selectedMovieListType});

  @override
  List<Object> get props => [
        selectedMovieListType,
        currentListPage,
      ];
}
