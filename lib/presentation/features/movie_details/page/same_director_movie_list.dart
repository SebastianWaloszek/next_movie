import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/features/movie_details/bloc/movie_details_page_bloc.dart';
import 'package:next_movie/presentation/features/related_movies/page/related_movies.dart';
import 'package:next_movie/presentation/features/related_movies/page/related_movies_page_arguments.dart';

class SameDirectorMovieList extends RelatedMovies<MovieDetailsPageBloc, MovieDetailsPageState> {
  static const routeName = 'sameDirectorMovies';

  @override
  MovieDetailsPageBloc getPageBloc(BuildContext context) =>
      (ModalRoute.of(context).settings.arguments as RelatedMoviesPageArguments).pageBloc as MovieDetailsPageBloc;

  @override
  List<Movie> getMovies(BuildContext context) => getPageBloc(context).state.sameDirectorMovies;

  @override
  int getMovieCountLimit(BuildContext context) => getPageBloc(context).state.sameDirectorMovieCount;

  @override
  void loadNextPage(BuildContext context) {}
}
