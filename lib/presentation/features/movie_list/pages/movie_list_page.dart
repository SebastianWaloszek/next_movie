import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie/common/utils/injector.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/presentation/features/movie_details/page/movie_details_page.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/movie_list_page_bloc.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/loaded_movie_list_page_state.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/movie_list_page_state.dart';
import 'package:next_movie/presentation/features/movie_list/pages/movie_list_page_body.dart';
import 'package:next_movie/presentation/features/movie_list/pages/movie_list_page_parameters.dart';

class MovieListPage extends StatefulWidget {
  static const routeName = 'movieList';

  const MovieListPage({Key key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieListPageBloc get pageBloc => Injector.resolve();

  @override
  void initState() {
    _loadMovies();
    super.initState();
  }

  void _loadMovies() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pageBloc.add(LoadMoviesEvent());
    });
  }

  void _loadNextPage() {
    pageBloc.add(LoadNextPageEvent());
  }

  void _changeListFilter(MovieListType listType) {
    pageBloc.add(ChangeMovieListFilterEvent(listType: listType));
  }

  void _showMovieDetails(Movie movie) {
    Navigator.of(context).pushNamed(
      MovieDetailsPage.routeName,
      arguments: movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListPageBloc, MovieListPageState>(
      cubit: pageBloc,
      builder: (context, state) {
        if (state is LoadedMovieListPageState) {
          return _getPageBodyForLoadedState(state);
        } else {
          return _getPageBodyForNotLoadedState(state);
        }
      },
    );
  }

  MovieListPageBody _getPageBodyForLoadedState(LoadedMovieListPageState state) {
    return MovieListPageBody(
      MovieListPageParameters(
        context,
        movies: state.movies,
        selectedListFilter: state.selectedMovieListType,
        onChangedListFilter: _changeListFilter,
        showMovieDetails: _showMovieDetails,
        loadNextPage: _loadNextPage,
        isLoadingNextPage: state.isLoadingNextPage,
      ),
    );
  }

  MovieListPageBody _getPageBodyForNotLoadedState(MovieListPageState state) {
    return MovieListPageBody(
      MovieListPageParameters(
        context,
        selectedListFilter: state.selectedMovieListType,
        onChangedListFilter: _changeListFilter,
        showMovieDetails: _showMovieDetails,
        loadNextPage: _loadNextPage,
      ),
    );
  }
}
