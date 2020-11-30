import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_detail_row.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class MovieOverviewRow extends StatelessWidget {
  final String overview;

  const MovieOverviewRow({
    Key key,
    this.overview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieDetailRow(
      name: AppLocalizations.of(context).overview(),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: AppTextStyles.subtitle2(
          context,
          color: AppColors.primaryContent(context),
        ),
      ),
    );
  }
}
