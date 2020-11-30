import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie.dart';
import '../../../pages/page_body.dart';

class RelatedMoviesBodyParameters extends PageBodyParameters {
  final String pageTitle;
  final List<Movie> movies;
  final int movieCountLimit;
  final void Function(BuildContext context) loadNextPage;
  final void Function(Movie) showMovieDetails;

  RelatedMoviesBodyParameters(
    BuildContext context, {
    @required this.pageTitle,
    this.movieCountLimit,
    this.movies,
    @required this.loadNextPage,
    @required this.showMovieDetails,
  })  : assert(pageTitle != null),
        assert(loadNextPage != null),
        assert(showMovieDetails != null),
        super(context: context);

  @override
  bool validate() => true;
}
