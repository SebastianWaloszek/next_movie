import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:next_movie/common/parameters/load_movies_parameters.dart';
import 'package:next_movie/common/parameters/movie_result.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/domain/use_cases/load_movies.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/loaded_movie_list_page_state.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/loading_movie_list_page_state.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/movie_list_page_state.dart';

part 'movie_list_page_event.dart';

class MovieListPageBloc extends Bloc<MovieListPageEvent, MovieListPageState> {
  static const MovieListType defaultMovieListType = MovieListType.nowPlaying;

  final LoadMovies loadMovies;
  final StreamController<MovieResult> listMovieStreamController;

  static MovieListPageState get initialState => const LoadingMovieListPageState(
        selectedMovieListType: defaultMovieListType,
      );

  MovieListPageBloc({
    @required this.loadMovies,
    @required this.listMovieStreamController,
  })  : assert(loadMovies != null),
        assert(listMovieStreamController != null),
        super(initialState) {
    _initMovieStream();
  }

  void _initMovieStream() {
    listMovieStreamController.stream.listen((MovieResult listMovie) {
      if (state.selectedMovieListType == listMovie.listType) {
        add(AddMovieToListEvent(movie: listMovie.movie, listType: listMovie.listType));
      }
    });
  }

  @override
  Stream<MovieListPageState> mapEventToState(
    MovieListPageEvent event,
  ) async* {
    if (event is ChangeMovieListFilterEvent) {
      yield* _handleChangeMovieListFilter(event);
    } else if (event is LoadMoviesEvent) {
      yield* _handleLoadMovies();
    } else if (event is LoadNextPageEvent) {
      yield* _handleLoadNextPage(event);
    } else if (event is AddMovieToListEvent) {
      yield* _handleAddMovieToList(event);
    }
  }

  Stream<MovieListPageState> _handleChangeMovieListFilter(ChangeMovieListFilterEvent event) async* {
    if (state.selectedMovieListType != event.listType) {
      yield state.copyWith(selectedMovieListType: event.listType);
      yield* _handleLoadMovies();
    }
  }

  Stream<MovieListPageState> _handleLoadMovies() async* {
    yield LoadingMovieListPageState(selectedMovieListType: state.selectedMovieListType);
    loadMovies(
      LoadMoviesParameters(
        listType: state.selectedMovieListType,
        page: 1,
        listMovieSink: listMovieStreamController.sink,
      ),
    );
    yield LoadedMovieListPageState(
      selectedMovieListType: state.selectedMovieListType,
      currentListPage: 1,
    );
  }

  Stream<MovieListPageState> _handleLoadNextPage(LoadNextPageEvent event) async* {
    yield (state as LoadedMovieListPageState).copyWith(isLoadingNextPage: true);

    final newListPage = state.currentListPage + 1;
    loadMovies(
      LoadMoviesParameters(
        listType: state.selectedMovieListType,
        page: newListPage,
        listMovieSink: listMovieStreamController.sink,
      ),
    );
    yield LoadedMovieListPageState(
      movies: (state as LoadedMovieListPageState).movies ?? [],
      selectedMovieListType: state.selectedMovieListType,
      currentListPage: newListPage,
    );
  }

  Stream<MovieListPageState> _handleAddMovieToList(AddMovieToListEvent event) async* {
    var currentMovies = <Movie>[];
    if (state is LoadedMovieListPageState) {
      currentMovies = (state as LoadedMovieListPageState).movies ?? [];
    }
    yield LoadedMovieListPageState(
      movies: List.from(currentMovies)..add(event.movie),
      selectedMovieListType: state.selectedMovieListType,
      currentListPage: state.currentListPage,
    );
  }
}
