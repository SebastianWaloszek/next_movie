import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class MovieDetailTab extends StatelessWidget {
  final String name;
  final void Function() onSelected;
  final bool isSelected;
  final EdgeInsets padding;

  const MovieDetailTab({
    Key key,
    @required this.name,
    @required this.isSelected,
    this.padding,
    this.onSelected,
  })  : assert(name != null),
        assert(isSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: padding,
      child: InkResponse(
        onTap: onSelected,
        child: Text(
          name,
          style: isSelected
              ? AppTextStyles.button1(context, color: AppColors.primaryContent(context))
              : AppTextStyles.button2(context, color: AppColors.secondaryContent(context)),
        ),
      ),
    );
  }
}
