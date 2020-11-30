import 'package:equatable/equatable.dart';
import 'package:next_movie/data/models/movie_rating_model.dart';
import 'package:next_movie/data/models/movie_review_model.dart';

import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:meta/meta.dart';

class RottenTomatoesMovieDetails extends Equatable {
  final bool certified;
  final List<MovieRating> ratings;
  final List<MovieReview> reviews;

  const RottenTomatoesMovieDetails({
    @required this.certified,
    this.ratings,
    this.reviews,
  })  : assert(certified != null),
        assert(ratings != null || reviews != null);

  @override
  List<Object> get props => [
        ratings,
        reviews,
      ];

  factory RottenTomatoesMovieDetails.fromJson(Map<String, dynamic> json) {
    final ratingSummary = json['ratingSummary'];
    final allCritics = ratingSummary['allCritics'];
    final audience = ratingSummary['audience'];

    final isCertified = allCritics['meterClass'] == 'certified';

    final rottenCritics = MovieRatingModel.rottenCritics(double.parse('${allCritics['meterValue']}'));
    final rottenAudience = MovieRatingModel.rottenAudience(double.parse('${audience['meterScore']}'));

    final reviews = json['reviews']['reviews'] as List;

    return RottenTomatoesMovieDetails(
      certified: isCertified,
      ratings: [rottenCritics, rottenAudience],
      reviews: List<MovieReview>.of(
        reviews.map<MovieReview>(
          (review) => MovieReviewModel.fromJson(review as Map<String, dynamic>),
        ),
      ),
    );
  }
}
