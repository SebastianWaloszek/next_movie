import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/movie_list_page_state.dart';
import 'package:meta/meta.dart';

class LoadedMovieListPageState extends MovieListPageState {
  final List<Movie> movies;
  final bool isLoadingNextPage;

  const LoadedMovieListPageState({
    this.movies,
    @required MovieListType selectedMovieListType,
    @required int currentListPage,
    this.isLoadingNextPage = false,
  })  : assert(selectedMovieListType != null),
        assert(currentListPage != null),
        super(
          selectedMovieListType: selectedMovieListType,
          currentListPage: currentListPage,
        );

  @override
  LoadedMovieListPageState copyWith({MovieListType selectedMovieListType, bool isLoadingNextPage}) {
    return LoadedMovieListPageState(
      movies: movies,
      selectedMovieListType: selectedMovieListType ?? this.selectedMovieListType,
      currentListPage: currentListPage,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
    );
  }

  @override
  List<Object> get props => [
        ...super.props,
        movies,
      ];
}
