import 'package:equatable/equatable.dart';

import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:meta/meta.dart';

class MovieResult extends Equatable {
  final Movie movie;
  final MovieListType listType;
  
  const MovieResult({
    @required this.movie,
    this.listType,
  }) : assert(movie != null);

  @override
  List<Object> get props => [
        movie,
        listType,
      ];
}
