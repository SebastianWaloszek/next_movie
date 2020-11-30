import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/presentation/features/movie_list/widgets/movie_list_filters.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:next_movie/presentation/widgets/top_bar/expandable_top_bar.dart';

class MovieListPageTopBar extends StatelessWidget {
  final double scrollOffset;
  final MovieListType selectedListFilter;
  final void Function(MovieListType) onChangedListFilter;

  const MovieListPageTopBar({
    Key key,
    @required this.scrollOffset,
    @required this.selectedListFilter,
    @required this.onChangedListFilter,
  })  : assert(scrollOffset != null),
        assert(selectedListFilter != null),
        assert(onChangedListFilter != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableTopBar(
      scrollOffset: scrollOffset,
      color: AppColors.background(context),
      expandedContentPadding: const EdgeInsets.only(bottom: 70),
      elevated: false,
      elevateOnScroll: true,
      height: 115,
      collapsedHeight: 55,
      expandedTitle: _buildTitle(context),
      collapsedTitle: _buildTitle(context),
      bottom: _buildBottom(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AppLocalizations.of(context).movies(),
      style: AppTextStyles.headline1(context),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 5),
      child: MovieListFilters(
        selectedFilter: selectedListFilter,
        onSelected: onChangedListFilter,
      ),
    );
  }
}
