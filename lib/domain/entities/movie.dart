import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/genre.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';

abstract class Movie extends Equatable {
  final int id;
  final String imdbId;
  final String title;
  final String poster;
  final String overview;
  final DateTime releaseDate;
  final String status;
  final int budget;
  final int revenue;
  final Duration runtime;
  final String originalLanguage;
  final List<MovieRating> ratings;
  final List<Genre> genres;

  const Movie({
    @required this.id,
    this.imdbId,
    this.title,
    this.overview,
    this.poster,
    this.releaseDate,
    this.status,
    this.runtime,
    this.originalLanguage,
    this.budget,
    this.revenue,
    this.ratings,
    this.genres,
  }) : assert(id != null);

  @override
  List<Object> get props => [
        imdbId,
        title,
        overview,
        poster,
        runtime,
        releaseDate,
        status,
        originalLanguage,
        budget,
        revenue,
        ratings,
        genres,
      ];
}
