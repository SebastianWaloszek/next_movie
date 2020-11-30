import 'dart:async';

import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/load_credited_movies.dart';
import 'package:next_movie/common/parameters/load_movies_parameters.dart';
import 'package:next_movie/common/parameters/load_similar_movies_parameters.dart';
import 'package:next_movie/common/parameters/movie_images.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';

abstract class MovieRepository {
  Future<Result<void, Failure>> getMovies(LoadMoviesParameters parameters);
  Future<Result<Credits, Failure>> getMovieCredits(int movieId);
  Future<Result<List<YouTubeVideo>, Failure>> getYouTubeReviews(String movieTitle);
  Future<Result<String, Failure>> getRottenTomatoesId(Movie movie);
  Future<Result<List<MovieRating>, Failure>> getAdditionalRatings(String rottenTomatoesId);
  Future<Result<List<MovieReview>, Failure>> getReviews(String rottenTomatoesId);
  Future<Result<void, Failure>> getSimilarMovies(LoadSimilarMoviesParameters parameters);
  Future<Result<void, Failure>> getCreditedMovies(LoadCreditedMoviesParameters parameters);
  Future<Result<MovieImages, Failure>> getImages(int movieId);
  Future<Result<CountryReleaseDates, Failure>> getMovieReleaseDates(int movieId);
}
