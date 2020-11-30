import 'package:flutter/cupertino.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/presentation/pages/page_body.dart';

class MovieListPageParameters extends PageBodyParameters {
  final MovieListType selectedListFilter;
  final List<Movie> movies;
  final void Function(MovieListType) onChangedListFilter;
  final void Function() loadNextPage;
  final void Function(Movie) showMovieDetails;
  final bool isLoadingNextPage;

  MovieListPageParameters(
    BuildContext context, {
    this.movies,
    @required this.selectedListFilter,
    @required this.onChangedListFilter,
    @required this.loadNextPage,
    @required this.showMovieDetails,
    this.isLoadingNextPage = false,
  })  : assert(selectedListFilter != null),
        assert(onChangedListFilter != null),
        assert(showMovieDetails != null),
        assert(loadNextPage != null),
        super(context: context);

  @override
  bool validate() => true;
}
