import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/credits.dart';

import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/main_cast_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_overview_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_reviews_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/recommendations/movie_recommendation_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/youtube/youtube_reviews_row.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';

class MainMovieDetailsBody extends StatelessWidget {
  static const double rowSpacing = 25;

  final Movie movie;
  final Credits credits;
  final List<YouTubeVideo> youTubeReviews;
  final List<MovieRating> additionalRatings;
  final List<Movie> similarMovies;
  final List<Movie> sameDirectorMovies;

  final void Function(String) showYouTubeVideo;
  final void Function(Movie) showMovieDetails;
  final void Function() showCastTab;
  final void Function(String) showSameDirectorMovies;
  final void Function(String) showSimilarMovies;

  const MainMovieDetailsBody({
    Key key,
    @required this.movie,
    this.credits,
    this.youTubeReviews,
    this.showYouTubeVideo,
    this.additionalRatings,
    this.similarMovies,
    this.sameDirectorMovies,
    @required this.showMovieDetails,
    @required this.showCastTab,
    @required this.showSameDirectorMovies,
    @required this.showSimilarMovies,
  })  : assert(movie != null),
        assert(showMovieDetails != null),
        assert(showCastTab != null),
        assert(showSameDirectorMovies != null),
        assert(showSimilarMovies != null),
        super(key: key);

  List<MovieRating> get allRatings => List<MovieRating>.from(movie.ratings)..addAll(additionalRatings ?? []);

  bool get showYouTubeReviews => youTubeReviews?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (allRatings.isNotEmpty) _buildMovieReviewsRow(),
        _buildMovieOverviewRow(),
        _buildMainCastRow(),
        _buildYoutubeReviewsRow(),
        if (sameDirectorMovies.isNotEmpty) _buildMoreFromRow(context),
        if (similarMovies.isNotEmpty) _buildSimilarMoviesRow(context),
      ],
    );
  }

  Widget _buildMovieReviewsRow() {
    return MovieReviewsRow(
      ratings: allRatings,
    );
  }

  Widget _buildMovieOverviewRow() {
    return Container(
      margin: const EdgeInsets.only(
        top: rowSpacing,
        left: AppThemeConstants.horizontal,
        right: AppThemeConstants.horizontal,
      ),
      child: MovieOverviewRow(overview: movie.overview),
    );
  }

  Widget _buildMainCastRow() {
    return Container(
      margin: const EdgeInsets.only(top: rowSpacing),
      child: MainCastRow(
        cast: credits?.cast,
        showEntireCast: showCastTab,
      ),
    );
  }

  String _getMoreFromDirectorTitle(BuildContext context) {
    return AppLocalizations.of(context).moreFrom(credits?.director?.name);
  }

  Widget _buildMoreFromRow(BuildContext context) {
    final rowTitle = _getMoreFromDirectorTitle(context);
    return Container(
      margin: const EdgeInsets.only(top: rowSpacing),
      child: MovieRecommentationRow(
        name: rowTitle,
        movies: sameDirectorMovies,
        onSelected: showMovieDetails,
        showMore: () => showSameDirectorMovies(rowTitle),
      ),
    );
  }

  String _getSimilarMoviesTitle(BuildContext context) {
    return AppLocalizations.of(context).similarMovies();
  }

  Widget _buildSimilarMoviesRow(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: rowSpacing),
      child: MovieRecommentationRow(
        name: _getSimilarMoviesTitle(context),
        movies: similarMovies,
        onSelected: showMovieDetails,
        showMore: () => showSimilarMovies(_getSimilarMoviesTitle(context)),
      ),
    );
  }

  Widget _buildYoutubeReviewsRow() {
    return YoutubeReviewsRow(
      margin: const EdgeInsets.only(top: rowSpacing),
      videos: youTubeReviews,
      showYouTubeVideo: showYouTubeVideo,
    );
  }
}
