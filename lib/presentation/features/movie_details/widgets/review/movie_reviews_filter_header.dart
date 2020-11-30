import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/movie_detail_tab.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';

enum MovieReviewFilter {
  all,
  topCritics,
  positive,
  negative,
}

extension MovieReviewFilterExtensions on MovieReviewFilter {
  String toDescription(BuildContext context) {
    switch (this) {
      case MovieReviewFilter.all:
        return AppLocalizations.of(context).all();
      case MovieReviewFilter.topCritics:
        return AppLocalizations.of(context).topCritics();
      case MovieReviewFilter.positive:
        return AppLocalizations.of(context).positive();
      case MovieReviewFilter.negative:
        return AppLocalizations.of(context).negative();
      default:
        throw UnsupportedError('$this is not supported');
    }
  }
}

class MovieReviewsFilterHeader extends StatelessWidget {
  final MovieReviewFilter selectedFilterType;
  final void Function(MovieReviewFilter) onChangedFilter;

  const MovieReviewsFilterHeader({
    Key key,
    this.selectedFilterType,
    this.onChangedFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        itemCount: MovieReviewFilter.values.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final filter = MovieReviewFilter.values[index];
    final isSelected = filter == selectedFilterType;
    return MovieDetailTab(
      name: filter.toDescription(context),
      isSelected: isSelected,
      onSelected: () => onChangedFilter(filter),
      padding: EdgeInsets.only(top: !isSelected ? 6 : 0, right: 15),
    );
  }
}
