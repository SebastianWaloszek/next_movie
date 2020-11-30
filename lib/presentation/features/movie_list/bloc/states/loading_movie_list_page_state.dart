import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/movie_list_page_state.dart';
import 'package:meta/meta.dart';

class LoadingMovieListPageState extends MovieListPageState {
  const LoadingMovieListPageState({
    @required MovieListType selectedMovieListType,
  }) : super(
          selectedMovieListType: selectedMovieListType,
          currentListPage: 1,
        );

  @override
  MovieListPageState copyWith({MovieListType selectedMovieListType}) {
    return LoadingMovieListPageState(selectedMovieListType: selectedMovieListType ?? this.selectedMovieListType);
  }
}
