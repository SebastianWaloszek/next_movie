import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/features/movie_details/page/movie_details_page.dart';
import 'package:next_movie/presentation/features/related_movies/page/related_movies_page_arguments.dart';

import 'related_movies_body.dart';
import 'related_movies_body_parameters.dart';

abstract class RelatedMovies<B extends Bloc<dynamic, S>, S> extends StatefulWidget {
  B getPageBloc(BuildContext context);

  List<Movie> getMovies(BuildContext context);

  const RelatedMovies({Key key}) : super(key: key);

  @override
  _RelatedMoviesState createState() => _RelatedMoviesState<B, S>();

  void loadNextPage(BuildContext context);

  int getMovieCountLimit(BuildContext context) => null;
}

class _RelatedMoviesState<B extends Bloc<dynamic, S>, S> extends State<RelatedMovies> {
  String getPageTitle(BuildContext context) => (ModalRoute.of(context).settings.arguments as RelatedMoviesPageArguments).pageTitle;

  void _showMovieDetails(Movie movie) {
    Navigator.of(context).pushNamed(
      MovieDetailsPage.routeName,
      arguments: movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: widget.getPageBloc(context),
      builder: (context, state) => RelatedMoviesBody(
        RelatedMoviesBodyParameters(
          context,
          pageTitle: getPageTitle(context),
          movies: widget.getMovies(context),
          movieCountLimit: widget.getMovieCountLimit(context),
          loadNextPage: widget.loadNextPage,
          showMovieDetails: _showMovieDetails,
        ),
      ),
    );
  }
}
