import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_detail_row.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/widgets/movie_rating.dart';

class MovieReviewsRow extends StatelessWidget {
  final List<MovieRating> ratings;

  List<MovieRating> get criticRatings => ratings.where((rating) => rating.type == MovieRatingType.critics).toList();

  List<MovieRating> get audienceRatings => ratings.where((rating) => rating.type == MovieRatingType.audience).toList()
    ..sort((first, second) {
      if (first.source == MovieRatingSource.rottenTomatoes) {
        return -1;
      }
      return 1;
    });

  const MovieReviewsRow({
    Key key,
    @required this.ratings,
  })  : assert(ratings != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          if (criticRatings.isNotEmpty) _buildCriticReviewsRow(context),
          if (audienceRatings.isNotEmpty) _buildAudienceReviewsRow(context),
        ],
      ),
    );
  }

  Widget _buildCriticReviewsRow(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppThemeConstants.horizontal),
      child: MovieDetailRow(
        name: AppLocalizations.of(context).critics(),
        child: _buildCriticsReviews(),
      ),
    );
  }

  Widget _buildCriticsReviews() {
    return Row(
      children: criticRatings.map(_buildRatingLabel).toList(),
    );
  }

  Widget _buildAudienceReviewsRow(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: MovieDetailRow(
        name: AppLocalizations.of(context).audience(),
        child: _buildAudienceReviews(),
      ),
    );
  }

  Widget _buildAudienceReviews() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: audienceRatings.map(_buildRatingLabel).toList(),
    );
  }

  Widget _buildRatingLabel(MovieRating rating) {
    return RatingLabel(
      movieRating: rating,
      margin: const EdgeInsets.only(right: 20),
    );
  }
}
