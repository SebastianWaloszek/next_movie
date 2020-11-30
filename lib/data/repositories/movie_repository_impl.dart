import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/load_credited_movies.dart';
import 'package:next_movie/common/parameters/load_movies_parameters.dart';
import 'package:next_movie/common/parameters/load_similar_movies_parameters.dart';
import 'package:next_movie/common/parameters/movie_images.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/data/data_sources/movie_data_source.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';
import 'package:meta/meta.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieDataSource movieDataSource;

  MovieRepositoryImpl({
    @required this.movieDataSource,
  }) : assert(movieDataSource != null);

  @override
  Future<Result<void, Failure>> getMovies(LoadMoviesParameters parameters) {
    return movieDataSource.getMovies(parameters);
  }

  @override
  Future<Result<Credits, Failure>> getMovieCredits(int movieId) {
    return movieDataSource.getMovieCredits(movieId);
  }

  @override
  Future<Result<List<YouTubeVideo>, Failure>> getYouTubeReviews(String movieTitle) {
    return movieDataSource.getYouTubeReviews(movieTitle);
  }

  @override
  Future<Result<List<MovieRating>, Failure>> getAdditionalRatings(String rottenTomatoesId) {
    return movieDataSource.getAdditionalRatings(rottenTomatoesId);
  }

  @override
  Future<Result<List<MovieReview>, Failure>> getReviews(String rottenTomatoesId) {
    return movieDataSource.getReviews(rottenTomatoesId);
  }

  @override
  Future<Result<String, Failure>> getRottenTomatoesId(Movie movie) {
    return movieDataSource.getRottenTomatoesId(movie);
  }

  @override
  Future<Result<void, Failure>> getSimilarMovies(LoadSimilarMoviesParameters parameters) {
    return movieDataSource.getSimilarMovies(parameters);
  }

  @override
  Future<Result<MovieImages, Failure>> getImages(int movieId) {
    return movieDataSource.getImages(movieId);
  }

  @override
  Future<Result<void, Failure>> getCreditedMovies(LoadCreditedMoviesParameters parameters) {
    return movieDataSource.getCreditedMovies(parameters);
  }

  @override
  Future<Result<CountryReleaseDates, Failure>> getMovieReleaseDates(int movieId) {
    return movieDataSource.getMovieReleaseDates(movieId);
  }
}
