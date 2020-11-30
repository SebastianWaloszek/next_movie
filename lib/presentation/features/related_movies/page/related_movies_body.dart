import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:next_movie/presentation/widgets/poster_cell/poster_cell.dart';

import '../../../pages/page_body.dart';
import '../../../pages/scrollable_page_body_state.dart';

import 'related_movies_body_parameters.dart';
import 'states/mobile_related_movies_body_state.dart';
import 'states/web_related_movies_body_state.dart';

class RelatedMoviesBody extends PageBody<RelatedMoviesBodyParameters> {
  const RelatedMoviesBody(RelatedMoviesBodyParameters parameters) : super(parameters);

  @override
  State<RelatedMoviesBody> createMobileState() => MobileRelatedMoviesBodyState();

  @override
  State<RelatedMoviesBody> createWebState() => WebRelatedMoviesBodyState();
}

abstract class RelatedMoviesBodyState extends ScrollablePageBodyState<RelatedMoviesBody> {
  RelatedMoviesBodyParameters get parameters => widget.parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildScrollContent(),
      ),
      appBar: _buildAppBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        parameters.pageTitle,
        style: AppTextStyles.headline2(context),
      ),
      backgroundColor: AppColors.navigationBar(context),
      iconTheme: IconThemeData(
        color: AppColors.primaryContent(context),
      ),
    );
  }

  Widget _buildScrollContent() {
    return widget.parameters.movies != null ? _buildGridView() : _buildLoadingIndicator();
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildGridView() {
    // TODO Refactor to common widget
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scrollbar(
        child: GridView.builder(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: AppThemeConstants.horizontal),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
            crossAxisCount: 2,
          ),
          itemCount: _getItemCount(),
          itemBuilder: _buildGridViewItem,
        ),
      ),
    );
  }

  int _getItemCount() {
    if (parameters.movies.length == parameters.movieCountLimit) {
      return parameters.movies.length;
    } else {
      return _getLoadingItemCount();
    }
  }

  int _getLoadingItemCount() {
    final numberOfMoviesIsEven = parameters.movies.length % 2 != 0;
    if (numberOfMoviesIsEven) {
      return parameters.movies.length + 1;
    } else {
      return parameters.movies.length + 2;
    }
  }

  Widget _buildGridViewItem(BuildContext context, int index) {
    Movie movie;
    if (index < parameters.movies.length) {
      movie = parameters.movies.elementAt(index);
    }
    return PosterCell(
      movie: movie,
      onSelected: () => parameters.showMovieDetails(movie),
    );
  }

  bool _handleScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification && scrollController.position.extentAfter == 0) {
      parameters.loadNextPage(context);
    }
    return false;
  }
}
