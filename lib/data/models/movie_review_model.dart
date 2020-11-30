import 'package:next_movie/data/models/critic_model.dart';
import 'package:next_movie/data/models/publication_model.dart';
import 'package:next_movie/domain/entities/movie_review.dart';

class MovieReviewModel extends MovieReview {
  MovieReviewModel.fromJson(Map<dynamic, dynamic> json)
      : super(
          id: json['id'] as int,
          creationDate: DateTime.fromMillisecondsSinceEpoch(json['creationDate'] as int),
          rating: (json['isFresh'] as bool) ? ReviewRating.positive : ReviewRating.negative,
          quote: json['quote'] as String,
          url: json['url'] as String,
          isTop: json['isTop'] as bool,
          critic: json['critic'] != null ? CriticModel.fromJson(json['critic'] as Map<String, dynamic>) : null,
          publication: PublicationModel.fromJson(json['publication'] as Map<String, dynamic>),
        );
}
