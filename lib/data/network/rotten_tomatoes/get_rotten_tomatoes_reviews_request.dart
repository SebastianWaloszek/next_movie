import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/data/models/movie_review_model.dart';
import 'package:next_movie/domain/entities/movie_review.dart';

class GetRottenTomatoesReviewsRequest extends Request<List<MovieReview>> {
  GetRottenTomatoesReviewsRequest({
    @required String rottenTomatoesId,
  })  : assert(rottenTomatoesId != null),
        super(path: 'https://www.rottentomatoes.com/api/private/v1.0/movies/$rottenTomatoesId');

  @override
  List<MovieReview> createResponse(dynamic responseBody) {
    final json = jsonDecode(responseBody as String);

    final reviews = json['reviews']['reviews'] as List<dynamic>;

    return List<MovieReview>.of(
      reviews.map<MovieReview>((review) => MovieReviewModel.fromJson(review as Map<String, dynamic>)),
    );
  }
}
