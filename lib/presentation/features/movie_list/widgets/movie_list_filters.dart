import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/presentation/widgets/filters/list_filters.dart';

class MovieListFilters extends ListFilters<MovieListType> {
  const MovieListFilters({
    MovieListType selectedFilter,
    void Function(MovieListType option) onSelected,
  }) : super(
          selectedFilter: selectedFilter,
          onSelected: onSelected,
        );

  @override
  String getFilterDescription(BuildContext context, MovieListType option) => option.toLocalized(context);

  @override
  List<MovieListType> get filters => MovieListType.values;
}
