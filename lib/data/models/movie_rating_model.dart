import 'package:next_movie/domain/entities/movie_rating.dart';

class MovieRatingModel extends MovieRating {
  const MovieRatingModel.imdb(double value)
      : super(
          source: MovieRatingSource.imdb,
          type: MovieRatingType.audience,
          value: value,
        );

  const MovieRatingModel.tmdb(double value)
      : super(
          source: MovieRatingSource.tmdb,
          type: MovieRatingType.audience,
          value: value,
        );

  const MovieRatingModel.rottenCritics(double value)
      : super(
          source: MovieRatingSource.rottenTomatoes,
          type: MovieRatingType.critics,
          value: value,
        );

  const MovieRatingModel.rottenAudience(double value)
      : super(
          source: MovieRatingSource.rottenTomatoes,
          type: MovieRatingType.audience,
          value: value,
        );

  const MovieRatingModel.metacritic(int value)
      : super(
          source: MovieRatingSource.metacritic,
          type: MovieRatingType.critics,
          value: value,
        );
}
