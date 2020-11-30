import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/date_time_extensions.dart';
import 'package:next_movie/common/utils/extensions/int_extensions.dart';
import 'package:next_movie/common/utils/language_local.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/release_date/release_date.dart';
import 'package:next_movie/domain/entities/release_date/release_date_type.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/facts/movie_fact_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_detail_row.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class MovieFactsBody extends StatelessWidget {
  final EdgeInsets margin;
  final Movie movie;
  final CountryReleaseDates countryReleaseDates;

  const MovieFactsBody({
    Key key,
    this.margin,
    @required this.movie,
    this.countryReleaseDates,
  })  : assert(movie != null),
        super(key: key);

  bool get shouldShowBudget => movie.budget != 0;
  bool get shouldShowRevenue => movie.revenue != 0;
  bool get shouldShowIncome => shouldShowBudget && shouldShowRevenue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReleaseInformationFact(context),
          if (shouldShowBudget) _buildBudgetsFact(context),
          if (shouldShowRevenue) _buildRevenueFact(context),
          if (shouldShowIncome) _buildIncomeFact(context),
          _buildLanguageFact(context),
        ],
      ),
    );
  }

  Widget _buildFact(
    BuildContext context, {
    @required String fact,
    TextStyle factTextStyle,
    @required String description,
    TextStyle descriptionTextStyle,
    double botttomMargin = 15,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: botttomMargin),
      child: MovieFactRow(
        fact: fact,
        factTextStyle: factTextStyle,
        description: description,
        descriptionTextStyle: descriptionTextStyle ??
            AppTextStyles.subtitle2(
              context,
              color: AppColors.primaryContent(context),
            ),
      ),
    );
  }

  Widget _buildReleaseInformationFact(BuildContext context) {
    return MovieDetailRow(
      name: AppLocalizations.of(context).releaseInformation(),
      child: Column(
        children: [
          _buildStatusFact(context),
          if (countryReleaseDates != null) ..._buildReleaseDatesFactRows(context),
        ],
      ),
    );
  }

  List<Widget> _buildReleaseDatesFactRows(BuildContext context) {
    return countryReleaseDates.releaseDates
        .map(
          (releaseDate) => _buildReleaseDateFact(
            context,
            releaseDate: releaseDate,
            countryFlagEmoji: countryReleaseDates.getCountryEmoji,
          ),
        )
        .toList();
  }

  Widget _buildReleaseDateFact(BuildContext context, {@required ReleaseDate releaseDate, @required String countryFlagEmoji}) {
    return _buildFact(
      context,
      fact: releaseDate.type.toLocalizedString(context),
      factTextStyle: AppTextStyles.body2(context),
      description: '$countryFlagEmoji  ${releaseDate.date.monthDayYear()}',
      botttomMargin: 10,
    );
  }

  Widget _buildStatusFact(BuildContext context) {
    return _buildFact(
      context,
      fact: AppLocalizations.of(context).status(),
      factTextStyle: AppTextStyles.body2(context),
      description: movie.status,
      botttomMargin: 10,
    );
  }

  Widget _buildBudgetsFact(BuildContext context) {
    return _buildFact(
      context,
      fact: AppLocalizations.of(context).budget(),
      description: movie.budget.formatAsCurrency(),
    );
  }

  Widget _buildRevenueFact(BuildContext context) {
    return _buildFact(
      context,
      fact: AppLocalizations.of(context).revenue(),
      description: movie.revenue.formatAsCurrency(),
    );
  }

  Widget _buildIncomeFact(BuildContext context) {
    final int income = movie.revenue - movie.budget;
    final textStyle = AppTextStyles.subtitle2(
      context,
      color: income.isNegative ? AppColors.red(context) : AppColors.green(context),
    );
    return _buildFact(
      context,
      fact: AppLocalizations.of(context).income(),
      description: income.formatAsCurrency(),
      descriptionTextStyle: textStyle,
    );
  }

  Widget _buildLanguageFact(BuildContext context) {
    final locale = LanguageLocal();
    return _buildFact(
      context,
      fact: AppLocalizations.of(context).originalLanguage(),
      description: locale.getDisplayLanguage(movie.originalLanguage)['name'],
    );
  }
}
