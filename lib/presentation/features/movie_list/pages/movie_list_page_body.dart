import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/features/movie_list/pages/states/mobile_movie_list_page_body_state.dart';
import 'package:next_movie/presentation/features/movie_list/pages/states/web_movie_list_page_body_state.dart';
import 'package:next_movie/presentation/features/movie_list/widgets/movie_list_page_top_bar.dart';
import 'package:next_movie/presentation/pages/page_body.dart';
import 'package:next_movie/presentation/pages/scrollable_page_body_state.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/widgets/poster_cell/poster_cell.dart';

import 'movie_list_page_parameters.dart';

class MovieListPageBody extends PageBody<MovieListPageParameters> {
  const MovieListPageBody(MovieListPageParameters parameters) : super(parameters);

  @override
  State<StatefulWidget> createMobileState() => MobileMovieListPageBodyState();

  @override
  State<StatefulWidget> createWebState() => WebMovieListPageBodyState();
}

abstract class MovieListPageBodyState extends ScrollablePageBodyState<MovieListPageBody> {
  MovieListPageParameters get parameters => widget.parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildPageBody(),
      ),
    );
  }

  Widget _buildPageBody() {
    return Column(
      children: <Widget>[
        _buildTopBar(),
        _buildContent(),
      ],
    );
  }

  Widget _buildTopBar() {
    return MovieListPageTopBar(
      scrollOffset: scrollOffset,
      selectedListFilter: parameters.selectedListFilter,
      onChangedListFilter: parameters.onChangedListFilter,
    );
  }

  Widget _buildContent() {
    return Expanded(
      child: _buildScrollContent(),
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
      parameters.loadNextPage();
    }
    return false;
  }
}
