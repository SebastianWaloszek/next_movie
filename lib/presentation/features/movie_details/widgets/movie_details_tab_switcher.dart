import 'package:flutter/material.dart';

import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/cast_and_crew/cast_detail_body.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/cast_and_crew/crew_detail_body.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/facts/movie_facts_body.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/main_movie_details_body.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/movie_detail_tab.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/movie_detail_tab_type.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/review/movie_reviews_body.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';

class MovieDetailsTabSwitcher extends StatelessWidget {
  final Movie movie;
  final Credits credits;
  final List<MovieRating> additionalRatings;
  final CountryReleaseDates countryReleaseDates;
  final List<MovieReview> reviews;
  final List<Movie> similarMovies;
  final List<Movie> sameDirectorMovies;

  final List<YouTubeVideo> youTubeReviews;
  final void Function(String) showYouTubeVideo;
  final void Function(Movie) showMovieDetails;
  final void Function(String titlePage) showSameDirectorMovies;
  final void Function(String titlePage) showSimilarMovies;

  final MovieDetailTabType selectedTab;
  final Function onTabChanged;

  const MovieDetailsTabSwitcher({
    Key key,
    @required this.movie,
    this.credits,
    this.additionalRatings,
    this.countryReleaseDates,
    this.reviews,
    this.similarMovies,
    this.sameDirectorMovies,
    this.youTubeReviews,
    this.showYouTubeVideo,
    @required this.showMovieDetails,
    @required this.selectedTab,
    @required this.onTabChanged,
    @required this.showSameDirectorMovies,
    @required this.showSimilarMovies,
  })  : assert(movie != null),
        assert(selectedTab != null),
        assert(onTabChanged != null),
        assert(showMovieDetails != null),
        assert(showSameDirectorMovies != null),
        assert(showSimilarMovies != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabs(context),
        _buildTabContent(),
      ],
    );
  }

  Widget _buildTabs(BuildContext context) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 20),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        children: [
          _buildMainTab(context),
          _buildCastAndCrewTab(context),
          _buildFactsTab(context),
          _buildReviewsTab(context),
        ],
      ),
    );
  }

  EdgeInsets _getTabPadding(bool isSelected) {
    return EdgeInsets.only(top: !isSelected ? 6 : 0, right: 15);
  }

  Widget _buildMainTab(BuildContext context) {
    final isSelected = selectedTab == MovieDetailTabType.main;
    return MovieDetailTab(
      name: MovieDetailTabType.main.toLocalizedString(context),
      onSelected: () => onTabChanged(MovieDetailTabType.main),
      isSelected: isSelected,
      padding: _getTabPadding(isSelected),
    );
  }

  Widget _buildFactsTab(BuildContext context) {
    final isSelected = selectedTab == MovieDetailTabType.facts;
    return MovieDetailTab(
      name: MovieDetailTabType.facts.toLocalizedString(context),
      onSelected: () => onTabChanged(MovieDetailTabType.facts),
      isSelected: isSelected,
      padding: _getTabPadding(isSelected),
    );
  }

  Widget _buildCastAndCrewTab(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCastTab(context),
        _buildAndSymbol(context),
        _buildCrewTab(context),
      ],
    );
  }

  Widget _buildCastTab(BuildContext context) {
    final isSelected = selectedTab == MovieDetailTabType.cast;
    return MovieDetailTab(
      name: MovieDetailTabType.cast.toLocalizedString(context),
      onSelected: () => onTabChanged(MovieDetailTabType.cast),
      isSelected: isSelected,
      padding: EdgeInsets.only(top: !isSelected ? 6 : 0),
    );
  }

  Widget _buildAndSymbol(BuildContext context) {
    return const MovieDetailTab(
      name: '&',
      isSelected: false,
      padding: EdgeInsets.only(top: 6, left: 4, right: 4),
    );
  }

  Widget _buildCrewTab(BuildContext context) {
    final isSelected = selectedTab == MovieDetailTabType.crew;
    return MovieDetailTab(
      name: MovieDetailTabType.crew.toLocalizedString(context),
      onSelected: () => onTabChanged(MovieDetailTabType.crew),
      isSelected: isSelected,
      padding: _getTabPadding(isSelected),
    );
  }

  Widget _buildReviewsTab(BuildContext context) {
    final isSelected = selectedTab == MovieDetailTabType.reviews;
    return MovieDetailTab(
      name: MovieDetailTabType.reviews.toLocalizedString(context),
      onSelected: () => onTabChanged(MovieDetailTabType.reviews),
      isSelected: isSelected,
      padding: _getTabPadding(isSelected),
    );
  }

  Widget _buildTabContent() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: _getTabContent(),
    );
  }

  Widget _getTabContent() {
    switch (selectedTab) {
      case MovieDetailTabType.main:
        return MainMovieDetailsBody(
          movie: movie,
          credits: credits,
          youTubeReviews: youTubeReviews,
          showYouTubeVideo: showYouTubeVideo,
          additionalRatings: additionalRatings,
          similarMovies: similarMovies,
          sameDirectorMovies: sameDirectorMovies,
          showMovieDetails: showMovieDetails,
          showSameDirectorMovies: showSameDirectorMovies,
          showSimilarMovies: showSimilarMovies,
          showCastTab: () => onTabChanged(MovieDetailTabType.cast),
        );
      case MovieDetailTabType.cast:
        return CastDetailsBody(
          cast: credits.cast,
        );
      case MovieDetailTabType.crew:
        return CrewDetailsBody(
          crew: credits.crew,
        );
      case MovieDetailTabType.facts:
        return MovieFactsBody(
          movie: movie,
          countryReleaseDates: countryReleaseDates,
          margin: const EdgeInsets.symmetric(horizontal: AppThemeConstants.horizontal),
        );
      case MovieDetailTabType.reviews:
        return MovieReviewsBody(
          movieReviews: reviews,
        );
      default:
        throw UnsupportedError('$selectedTab is not supported');
    }
  }
}
