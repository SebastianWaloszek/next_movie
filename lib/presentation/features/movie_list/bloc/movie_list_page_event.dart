part of 'movie_list_page_bloc.dart';

abstract class MovieListPageEvent extends Equatable {
  const MovieListPageEvent();
}

class LoadMoviesEvent extends MovieListPageEvent {
  @override
  List<Object> get props => [];
}

class LoadNextPageEvent extends MovieListPageEvent {
  @override
  List<Object> get props => [];
}

class AddMovieToListEvent extends MovieListPageEvent {
  final Movie movie;
  final MovieListType listType;

  const AddMovieToListEvent({
    @required this.movie,
    @required this.listType,
  })  : assert(movie != null),
        assert(listType != null);

  @override
  List<Object> get props => [
        movie,
        listType,
      ];
}

class ChangeMovieListFilterEvent extends MovieListPageEvent {
  final MovieListType listType;

  const ChangeMovieListFilterEvent({
    @required this.listType,
  }) : assert(listType != null);

  @override
  List<Object> get props => [listType];
}
