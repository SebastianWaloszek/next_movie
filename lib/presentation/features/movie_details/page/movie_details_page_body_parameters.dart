import 'package:flutter/material.dart';
import 'package:next_movie/common/parameters/movie_images.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/crew_person.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/presentation/pages/page_body.dart';

class MovieDetailsPageParameters extends PageBodyParameters {
  final Movie movie;
  final MovieImages movieImages;
  final Credits credits;
  final List<MovieRating> additionalRatings;
  final CountryReleaseDates countryReleaseDates;
  final List<MovieReview> reviews;
  final List<YouTubeVideo> youTubeReviews;
  final void Function(String) showYouTubeVideo;
  final void Function(Movie) showMovieDetails;
  final void Function(String pageTitle) showSameDirectorMovies;
  final void Function(String pageTitle) showSimilarMovies;
  final Map<CrewPerson, List<String>> featuredCrew;
  final List<Movie> similarMovies;
  final List<Movie> sameDirectorMovies;

  MovieDetailsPageParameters(
    BuildContext context, {
    @required this.movie,
    this.movieImages,
    this.credits,
    this.additionalRatings,
    this.countryReleaseDates,
    this.reviews,
    this.youTubeReviews,
    this.showYouTubeVideo,
    this.featuredCrew,
    this.similarMovies,
    this.sameDirectorMovies,
    @required this.showMovieDetails,
    @required this.showSameDirectorMovies,
    @required this.showSimilarMovies,
  })  : assert(movie != null),
        super(context: context);

  @override
  bool validate() => true;
}
