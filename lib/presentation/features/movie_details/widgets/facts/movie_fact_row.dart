import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_detail_row.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class MovieFactRow extends StatelessWidget {
  final String fact;
  final TextStyle factTextStyle;
  final String description;
  final TextStyle descriptionTextStyle;

  const MovieFactRow({
    Key key,
    @required this.fact,
    this.factTextStyle,
    @required this.description,
    this.descriptionTextStyle,
  })  : assert(fact != null),
        assert(description != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieDetailRow(
      name: fact,
      nameTextStyle: factTextStyle,
      childMargin: const EdgeInsets.only(bottom: 2),
      child: _buildFactDescription(context),
    );
  }

  Widget _buildFactDescription(BuildContext context) {
    return Text(
      description,
      style: descriptionTextStyle ??
          AppTextStyles.subtitle2(
            context,
            color: AppColors.primaryContent(context),
          ),
    );
  }
}
