import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum MovieRatingSource {
  imdb,
  rottenTomatoes,
  tmdb,
  metacritic,
}

enum MovieRatingType {
  audience,
  critics,
}

abstract class MovieRating extends Equatable {
  final MovieRatingSource source;
  final MovieRatingType type;
  final num value;

  const MovieRating({
    @required this.source,
    @required this.type,
    @required this.value,
  })  : assert(source != null),
        assert(type != null),
        assert(value != null);

  @override
  List<Object> get props => [
        source,
        type,
        value,
      ];
}