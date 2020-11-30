import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/widget_extensions.dart';

import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:next_movie/presentation/widgets/top_bar/expandable_top_bar.dart';

class MovieDetailsTopBar extends StatelessWidget {
  final double scrollOffset;
  final String movieTitle;

  const MovieDetailsTopBar({
    Key key,
    @required this.scrollOffset,
    @required this.movieTitle,
  })  : assert(scrollOffset != null),
        assert(movieTitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: scrollOffset > ExpandableTopBar.expandedThreshold ? AppColors.background(context) : Colors.transparent,
      child: ExpandableTopBar(
        scrollOffset: scrollOffset,
        color: AppColors.background(context),
        elevated: false,
        elevateOnScroll: true,
        height: 56,
        collapsedHeight: 55,
        collapsedTitle: _buildTitle(context),
        leading: _buildBackButtonContainer(context),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      movieTitle,
      style: AppTextStyles.headline2(context),
    );
  }

  Widget _buildBackButtonContainer(BuildContext context) {
    return Container(
      decoration: scrollOffset > ExpandableTopBar.expandedThreshold
          ? null
          : BoxDecoration(
              color: AppColors.background(context),
              shape: BoxShape.circle,
              boxShadow: cellShadow(context),
            ),
      child: _buildBackButton(context),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Transform.translate(
      offset: const Offset(4, 0),
      child: InkResponse(
        onTap: () => _popPage(context),
        child: Icon(
          Icons.arrow_back_ios,
          size: 22,
          color: AppColors.primaryContent(context),
        ),
      ),
    );
  }

  void _popPage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
