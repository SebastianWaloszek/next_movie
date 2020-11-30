// TODO: Figure out where to put the logic performed by this class.
import 'package:next_movie/common/utils/extensions/list_extensions.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';

abstract class RatingsPrioritizer {
  static const primaryCriticRatingSource = MovieRatingSource.metacritic;
  static const primaryPublicRatingSource = MovieRatingSource.imdb;

  static List<MovieRating> getPrioritizedRatings(List<MovieRating> ratings) {
    final filteredRatings = <MovieRating>[];
    final hasPrimaryCriticRating = ratings.containsWhere((rating) => rating.source == primaryCriticRatingSource);
    final hasPrimaryPublicRating = ratings.containsWhere((rating) => rating.source == primaryPublicRatingSource);

    for (final rating in ratings) {
      if (hasPrimaryCriticRating && rating.source == primaryCriticRatingSource) {
        filteredRatings.add(rating);
        continue;
      } else if (hasPrimaryPublicRating && rating.source == primaryPublicRatingSource) {
        filteredRatings.add(rating);
        continue;
      }

      final hasAnyCriticRating = filteredRatings.containsWhere((rating) => rating.type == MovieRatingType.critics);
      final hasAnyPublicRating = filteredRatings.containsWhere((rating) => rating.type == MovieRatingType.audience);

      if (!hasAnyCriticRating && !hasPrimaryCriticRating && rating.type == MovieRatingType.critics) {
        filteredRatings.add(rating);
      } else if (!hasAnyPublicRating && !hasPrimaryPublicRating && rating.type == MovieRatingType.audience) {
        filteredRatings.add(rating);
      }
    }
    final shouldReverseOrder = filteredRatings.length == 2 && filteredRatings.first.type == MovieRatingType.audience;
    if (shouldReverseOrder) {
      return filteredRatings.reversed.toList();
    } else {
      return filteredRatings;
    }
  }
}
