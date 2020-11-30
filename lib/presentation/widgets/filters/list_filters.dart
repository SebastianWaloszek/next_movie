import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

abstract class ListFilters<T> extends StatelessWidget {
  final T selectedFilter;
  final void Function(T filter) onSelected;

  const ListFilters({
    Key key,
    this.selectedFilter,
    @required this.onSelected,
  })  : assert(onSelected != null),
        super(key: key);

  List<T> get filters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return _buildFilterButton(context, index);
      },
      itemCount: filters.length,
    );
  }

  Widget _buildFilterButton(BuildContext context, int index) {
    final filter = filters[index];
    return Container(
      alignment: Alignment.centerLeft,
      margin: _getButtonMargin(index),
      child: InkResponse(
        onTap: () => onSelected(filter),
        child: _buildFilterButtonText(context, filter),
      ),
    );
  }

  EdgeInsets _getButtonMargin(int index) {
    final isFirstItem = index == 0;
    final isLastItem = index == filters.length - 1;
    if (isFirstItem) {
      return const EdgeInsets.only(left: AppThemeConstants.horizontal, right: 15);
    } else if (isLastItem) {
      return const EdgeInsets.only(right: AppThemeConstants.horizontal);
    } else {
      return const EdgeInsets.only(right: 15);
    }
  }

  Widget _buildFilterButtonText(BuildContext context, T filter) {
    final isSelected = filter == selectedFilter;
    return Container(
      margin: EdgeInsets.only(top: isSelected ? 0.0 : 2.0),
      child: Text(
        getFilterDescription(context, filter),
        style: _getStyleForButtonText(context, filter),
      ),
    );
  }

  String getFilterDescription(BuildContext context, T filter);

  TextStyle _getStyleForButtonText(BuildContext context, T filter) {
    if (filter == selectedFilter) {
      return AppTextStyles.button1(context, color: AppColors.primaryContent(context));
    } else {
      return AppTextStyles.button2(context, color: AppColors.secondaryContent(context));
    }
  }
}
