import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/review/movie_review_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/review/movie_reviews_filter_header.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';

class MovieReviewsBody extends StatefulWidget {
  final List<MovieReview> movieReviews;

  const MovieReviewsBody({
    Key key,
    this.movieReviews,
  }) : super(key: key);

  @override
  _MovieReviewsBodyState createState() => _MovieReviewsBodyState();
}

class _MovieReviewsBodyState extends State<MovieReviewsBody> {
  MovieReviewFilter selectedFilterType = MovieReviewFilter.all;

  List<MovieReview> filteredMovieReviews = [];

  bool get hasReviews => filteredMovieReviews?.isNotEmpty ?? false;

  @override
  void initState() {
    _setMovieReviewsForFilter();
    super.initState();
  }

  void _changeFilter(MovieReviewFilter filter) {
    setState(() {
      selectedFilterType = filter;
      _setMovieReviewsForFilter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildFilterHeader(),
        if (hasReviews) _buildReviewList(),
        if (!hasReviews) _buildNoReviewsLabel(context),
      ],
    );
  }

  Widget _buildFilterHeader() {
    return MovieReviewsFilterHeader(
      selectedFilterType: selectedFilterType,
      onChangedFilter: _changeFilter,
    );
  }

  Widget _buildReviewList() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppThemeConstants.horizontal),
        shrinkWrap: true,
        itemCount: filteredMovieReviews?.length ?? 0,
        itemBuilder: _buildListItem,
      ),
    );
  }

  void _setMovieReviewsForFilter() {
    setState(() {
      switch (selectedFilterType) {
        case MovieReviewFilter.all:
          filteredMovieReviews = widget.movieReviews;
          break;
        case MovieReviewFilter.topCritics:
          filteredMovieReviews = widget.movieReviews?.where((movieReview) => movieReview.isTop)?.toList();
          break;
        case MovieReviewFilter.positive:
          filteredMovieReviews = widget.movieReviews?.where((movieReview) => movieReview.rating == ReviewRating.positive)?.toList();
          break;
        case MovieReviewFilter.negative:
          filteredMovieReviews = widget.movieReviews?.where((movieReview) => movieReview.rating == ReviewRating.negative)?.toList();
          break;
        default:
          throw UnsupportedError('$selectedFilterType is not supported');
      }
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    return MovieReviewRow(
      movieReview: filteredMovieReviews[index],
      margin: const EdgeInsets.only(bottom: 25),
    );
  }

  Widget _buildNoReviewsLabel(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 175),
      child: Center(
        child: Text(
          AppLocalizations.of(context).noReviewsAvailable(),
          style: AppTextStyles.subtitle1(context),
        ),
      ),
    );
  }
}
