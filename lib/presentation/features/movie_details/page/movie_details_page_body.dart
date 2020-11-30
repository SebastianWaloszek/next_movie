import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/image_pager.dart';

import 'package:next_movie/presentation/features/movie_details/widgets/movie_detail_tab_type.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/movie_details_tab_switcher.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/movie_details_top_bar.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/movie_summary_header.dart';
import 'package:next_movie/presentation/pages/page_body.dart';
import 'package:next_movie/presentation/pages/scrollable_page_body_state.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

import 'movie_details_page_body_parameters.dart';
import 'states/mobile_movie_details_page_body_state.dart';
import 'states/web_movie_details_page_body_state.dart';

class MovieDetailsPageBody extends PageBody<MovieDetailsPageParameters> {
  const MovieDetailsPageBody(MovieDetailsPageParameters parameters) : super(parameters);

  @override
  State<MovieDetailsPageBody> createMobileState() => MobileMovieDetailsPageBodyState();

  @override
  State<MovieDetailsPageBody> createWebState() => WebMovieDetailsPageBodyState();
}

abstract class MovieDetailsPageBodyState extends ScrollablePageBodyState<MovieDetailsPageBody> {
  MovieDetailsPageParameters get parameters => widget.parameters;

  bool get showImagePager => parameters.movieImages?.backdrops?.isNotEmpty ?? false;

  var _selectedTab = MovieDetailTabType.main;

  void _changeDetailsTab(MovieDetailTabType newTab) {
    if (newTab != _selectedTab) {
      setState(() {
        _selectedTab = newTab;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          _buildScroll(),
          _buildTopBar(),
        ]),
      ),
    );
  }

  Widget _buildScroll() {
    return SingleChildScrollView(
      controller: scrollController,
      child: _buildScrollContent(),
    );
  }

  Column _buildScrollContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopStack(),
        MovieDetailsTabSwitcher(
          movie: parameters.movie,
          credits: parameters.credits,
          youTubeReviews: parameters.youTubeReviews,
          countryReleaseDates: parameters.countryReleaseDates,
          showYouTubeVideo: parameters.showYouTubeVideo,
          additionalRatings: parameters.additionalRatings,
          similarMovies: parameters.similarMovies,
          sameDirectorMovies: parameters.sameDirectorMovies,
          reviews: parameters.reviews,
          selectedTab: _selectedTab,
          onTabChanged: _changeDetailsTab,
          showMovieDetails: parameters.showMovieDetails,
          showSameDirectorMovies: parameters.showSameDirectorMovies,
          showSimilarMovies: parameters.showSimilarMovies,
        ),
      ],
    );
  }

  Widget _buildTopStack() {
    return SizedBox(
      height: 330,
      child: Stack(
        children: [
          if (showImagePager) _buildImagePager(),
          _buildGradientImagePager(),
          _buildSummaryHeader(),
        ],
      ),
    );
  }

  Widget _buildGradientImagePager() {
    return SizedBox(
      height: 216,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildGradientBox(context),
        ],
      ),
    );
  }

  DecoratedBox _buildGradientBox(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, 0.9),
          end: const Alignment(0, 0.55),
          colors: <Color>[
            AppColors.background(context),
            AppColors.background(context).withOpacity(0),
          ],
        ),
      ),
    );
  }

  ImagePager _buildImagePager() {
    return ImagePager(
      images: parameters.movieImages?.backdrops,
    );
  }

  Widget _buildSummaryHeader() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: MovieSummaryHeader(
        movie: parameters.movie,
        featuredCrew: parameters.featuredCrew,
      ),
    );
  }

  Widget _buildTopBar() {
    return MovieDetailsTopBar(
      scrollOffset: scrollOffset,
      movieTitle: parameters.movie.title,
    );
  }
}
