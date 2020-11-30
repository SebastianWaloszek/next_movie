import 'dart:async';

import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/network/network_service.dart';
import 'package:next_movie/common/parameters/load_credited_movies.dart';
import 'package:next_movie/common/parameters/load_movies_parameters.dart';
import 'package:next_movie/common/parameters/load_similar_movies_parameters.dart';
import 'package:next_movie/common/parameters/movie_images.dart';
import 'package:next_movie/common/parameters/movie_result.dart';
import 'package:next_movie/common/result/failure_result.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/common/result/success_result.dart';
import 'package:next_movie/data/data_sources/movie_data_source.dart';
import 'package:next_movie/data/models/movie_model.dart';
import 'package:next_movie/data/models/youtube_video_model.dart';
import 'package:next_movie/data/network/get_imdb_ratings_request.dart';
import 'package:next_movie/data/network/get_movie_credits_request.dart';
import 'package:next_movie/data/network/get_movie_details_request.dart';
import 'package:next_movie/data/network/get_movie_images.dart';
import 'package:next_movie/data/network/get_movie_release_dates.dart';
import 'package:next_movie/data/network/get_now_playing_movies_request.dart';
import 'package:next_movie/data/network/get_popular_movies_request.dart';
import 'package:next_movie/data/network/get_tmdb_movie_list_request.dart';
import 'package:next_movie/data/network/get_top_rated_movies_request.dart';
import 'package:next_movie/data/network/get_upcoming_movies_request.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/data/network/rotten_tomatoes/get_rotten_tomatoes_ratings_request.dart';
import 'package:next_movie/data/network/rotten_tomatoes/get_rotten_tomatoes_reviews_request.dart';
import 'package:next_movie/data/network/rotten_tomatoes/get_search_movie_request.dart';
import 'package:next_movie/data/network/the_movie_db/get_similar_movies_request.dart';
import 'package:next_movie/data/network/youtube/get_youtube_reviews_request.dart';
import 'package:next_movie/data/network/youtube/get_youtube_videos_statistics.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/rotten_tomatoes_movie_result.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video_statistics.dart';

class RemoteMovieDataSource extends MovieDataSource {
  final NetworkService networkService;

  RemoteMovieDataSource({@required this.networkService}) : assert(networkService != null);

  @override
  Future<Result<void, Failure>> getMovies(LoadMoviesParameters parameters) async {
    final request = getRequestForListType(parameters.listType, parameters.page);
    final movieIdsResult = await networkService.make(request) as Result<List<int>, Failure>;
    return movieIdsResult.fold(
      onSuccess: (movieIds) async {
        await _getMovieDetails(movieIds, parameters.listMovieSink, movielistType: parameters.listType);
        return SuccessResult(null);
      },
      onFailure: (failure) => FailureResult(failure),
    );
  }

  GetTmdbMovieListRequest getRequestForListType(MovieListType listType, int page) {
    switch (listType) {
      case MovieListType.nowPlaying:
        return GetNowPlayingMoviesRequest(page: page);
      case MovieListType.upcoming:
        return GetUpcomingMoviesRequest(page: page);
      case MovieListType.popular:
        return GetPopularMoviesRequest(page: page);
      case MovieListType.topRated:
        return GetTopRatedMoviesRequest(page: page);
      default:
        throw UnimplementedError('$listType is not supported');
    }
  }

  Future<void> _getMovieDetails(
    List<int> movieIds,
    Sink<MovieResult> listMovieSink, {
    MovieListType movielistType,
  }) async {
    return Future.forEach(movieIds, (int id) async {
      final movieResult = await _getMovie(id);
      await movieResult.fold(
        onSuccess: (movie) => _handleMovieReviews(movie, listMovieSink, movielistType),
        onFailure: (_) {},
      );
    });
  }

  Future<Result<Movie, Failure>> _getMovie(int movieId) async {
    return networkService.make(GetMovieDetailsRequest(id: movieId)) as Future<Result<Movie, Failure>>;
  }

  Future<void> _handleMovieReviews(
    Movie movie,
    Sink<MovieResult> listMovieSink,
    MovieListType movielistType,
  ) async {
    if (movie.imdbId != null && movie.imdbId.isNotEmpty) {
      await _getMovieReviews(movie, listMovieSink, movielistType);
    } else {
      // Getting additional reviews is not possible so finish by returning movie.
      listMovieSink.add(MovieResult(movie: movie, listType: movielistType));
    }
  }

  Future<void> _getMovieReviews(
    Movie movie,
    Sink<MovieResult> listMovieSink,
    MovieListType movielistType,
  ) async {
    final ratingsResult = await _getMovieRatings(movie.imdbId);
    ratingsResult.fold(
      onSuccess: (additionalRatings) {
        final movieWithNewRatings = (movie as MovieModel).copyWith(ratings: List.from(movie.ratings)..addAll(additionalRatings));
        final listMovie = MovieResult(movie: movieWithNewRatings, listType: movielistType);
        return listMovieSink.add(listMovie);
      },
      onFailure: (_) => listMovieSink.add(MovieResult(movie: movie, listType: movielistType)),
    );
  }

  Future<Result<List<MovieRating>, Failure>> _getMovieRatings(String imdbId) async {
    final ratingsResult = await networkService.make(
      GetImdbRatingsRequest(imdbId: imdbId),
    ) as Result<List<MovieRating>, Failure>;
    return ratingsResult.fold(
      onSuccess: (newRatings) => SuccessResult(newRatings),
      onFailure: (Failure failure) => FailureResult(failure),
    );
  }

  @override
  Future<Result<Credits, Failure>> getMovieCredits(int movieId) {
    final request = GetMovieCreditsRequest(movieId: movieId);
    return networkService.make(request) as Future<Result<Credits, Failure>>;
  }

  @override
  Future<Result<List<YouTubeVideo>, Failure>> getYouTubeReviews(String movieTitle) async {
    final request = GetYouTubeReviewsRequest(movieTitle: movieTitle);
    final result = await networkService.make<List<YouTubeVideo>>(request) as Result<List<YouTubeVideo>, Failure>;
    return result.fold(
      onSuccess: (List<YouTubeVideo> videos) async {
        final filteredVideos = _getFilteredReviews(videos);
        final result = await getYoutubeVideoStatistics(filteredVideos);
        return result.fold(
          onSuccess: (statisticsList) {
            final videosWithStatistics = _getVideosWithStatistics(statisticsList, filteredVideos);
            return SuccessResult(videosWithStatistics);
          },
          onFailure: (Failure failure) => FailureResult(failure),
        );
      },
      onFailure: (Failure failure) => FailureResult(failure),
    );
  }

  List<YouTubeVideo> _getVideosWithStatistics(
    List<YouTubeVideoStatistics> statisticsList,
    List<YouTubeVideo> filteredVideos,
  ) {
    final videosWithStatistics = <YouTubeVideo>[];
    for (final statistics in statisticsList) {
      final matchedVideo = filteredVideos.firstWhere((video) => video.id == statistics.videoId);
      if (matchedVideo != null) {
        videosWithStatistics.add((matchedVideo as YouTubeVideoModel).copyWith(statistics: statistics));
      }
    }
    return videosWithStatistics;
  }

  List<YouTubeVideo> _getFilteredReviews(List<YouTubeVideo> videos) {
    return videos.where((video) => video.id != null && video.title.toLowerCase().contains(GetYouTubeReviewsRequest.reviewSearchKeyword.toLowerCase())).toList();
  }

  Future<Result<List<YouTubeVideoStatistics>, Failure>> getYoutubeVideoStatistics(List<YouTubeVideo> videos) async {
    final videoIds = videos.map((video) => video.id).toList();
    final request = GetYouTubeVideosStatisticsRequest(videoIds: videoIds);
    return networkService.make(request) as Future<Result<List<YouTubeVideoStatistics>, Failure>>;
  }

  @override
  Future<Result<String, Failure>> getRottenTomatoesId(Movie movie) async {
    final request = GetSearchMovieRequest(movieName: movie.title);
    final result = await networkService.make(request) as Result<List<RottenTomatoesMovieResult>, Failure>;
    return result.fold(
      onSuccess: (movies) async {
        final correctResult = movies.firstWhere(
          (result) => result.year == movie.releaseDate.year || result.year == movie.releaseDate.year + 1,
          orElse: () => null,
        );
        if (correctResult != null) {
          final urlName = correctResult.url.replaceAll('/m/', '');
          return SuccessResult(urlName);
        } else {
          return FailureResult(UnexpectedFailure());
        }
      },
      onFailure: (failure) => FailureResult(failure),
    );
  }

  @override
  Future<Result<List<MovieRating>, Failure>> getAdditionalRatings(String rottenTomatoesId) {
    final request = GetRottenTomatoesRatingsRequest(rottenTomatoesId: rottenTomatoesId);
    return networkService.make(request) as Future<Result<List<MovieRating>, Failure>>;
  }

  @override
  Future<Result<List<MovieReview>, Failure>> getReviews(String rottenTomatoesId) {
    final detailsRequest = GetRottenTomatoesReviewsRequest(rottenTomatoesId: rottenTomatoesId);
    return networkService.make(detailsRequest) as Future<Result<List<MovieReview>, Failure>>;
  }

  @override
  Future<Result<void, Failure>> getSimilarMovies(LoadSimilarMoviesParameters parameters) async {
    final request = GetSimilarMoviesRequest(
      movieId: parameters.movieId,
      page: parameters.page,
    );
    final movieIdsResult = await networkService.make(request) as Result<List<int>, Failure>;
    return movieIdsResult.fold(
      onSuccess: (movieIds) async {
        await _getMovieDetails(movieIds, parameters.similarMovieSink);
        return SuccessResult(null);
      },
      onFailure: (failure) => FailureResult(failure),
    );
  }

  @override
  Future<Result<MovieImages, Failure>> getImages(int movieId) {
    final request = GetMovieImagesRequest(movieId: movieId);
    return networkService.make(request) as Future<Result<MovieImages, Failure>>;
  }

  @override
  Future<Result<void, Failure>> getCreditedMovies(LoadCreditedMoviesParameters parameters) async {
    await _getMovieDetails(parameters.movieIds, parameters.movieSink);
    return SuccessResult(null);
  }

  @override
  Future<Result<CountryReleaseDates, Failure>> getMovieReleaseDates(int movieId) {
    final request = GetMovieReleaseDatesRequest(movieId: movieId);
    return networkService.make(request) as Future<Result<CountryReleaseDates, Failure>>;
  }
}
