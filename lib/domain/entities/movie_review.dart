import 'package:equatable/equatable.dart';
import 'package:next_movie/domain/entities/critic.dart';
import 'package:next_movie/domain/entities/publication.dart';

enum ReviewRating {
  positive,
  negative,
}

abstract class MovieReview extends Equatable {
  final int id;
  final DateTime creationDate;
  final ReviewRating rating;
  final String quote;
  final String url;
  final bool isTop;
  final Critic critic;
  final Publication publication;

  const MovieReview({
    this.id,
    this.creationDate,
    this.rating,
    this.quote, 
    this.url,
    this.isTop,
    this.critic,
    this.publication,
  });

  @override
  List<Object> get props => throw UnimplementedError();
}
