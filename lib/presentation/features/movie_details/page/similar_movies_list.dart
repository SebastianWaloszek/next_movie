import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/features/movie_details/bloc/movie_details_page_bloc.dart';
import 'package:next_movie/presentation/features/related_movies/page/related_movies.dart';
import 'package:next_movie/presentation/features/related_movies/page/related_movies_page_arguments.dart';

class SimilarMoviesList extends RelatedMovies<MovieDetailsPageBloc, MovieDetailsPageState> {
  static const routeName = 'similarMovies';

  @override
  MovieDetailsPageBloc getPageBloc(BuildContext context) =>
      (ModalRoute.of(context).settings.arguments as RelatedMoviesPageArguments).pageBloc as MovieDetailsPageBloc;

  @override
  List<Movie> getMovies(BuildContext context) => getPageBloc(context).state.similarMovies;

  @override
  void loadNextPage(BuildContext context) {
    final pageBloc = getPageBloc(context);
    pageBloc.add(LoadMoreSimilarMoviesEvent());
  }
}
