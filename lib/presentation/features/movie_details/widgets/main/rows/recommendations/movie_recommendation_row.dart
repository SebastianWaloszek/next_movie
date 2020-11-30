import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_detail_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/recommendations/movie_recommendation_cell.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';

class MovieRecommentationRow extends StatelessWidget {
  final String name;
  final List<Movie> movies;
  final void Function(Movie) onSelected;
  final void Function() showMore;

  const MovieRecommentationRow({
    Key key,
    @required this.name,
    this.movies,
    @required this.onSelected,
    @required this.showMore,
  })  : assert(name != null),
        assert(onSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: MovieDetailRow(
        name: name,
        nameMargin: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        sufix: AppLocalizations.of(context).seeAll(),
        onSufixTap: showMore,
        sufixMargin: const EdgeInsets.only(right: AppThemeConstants.horizontal),
        child: _buildRecommendations(),
      ),
    );
  }

  Widget _buildRecommendations() {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return MovieRecommendationCell(
            movie: movies[index],
            onSelected: onSelected,
          );
        },
      ),
    );
  }
}
