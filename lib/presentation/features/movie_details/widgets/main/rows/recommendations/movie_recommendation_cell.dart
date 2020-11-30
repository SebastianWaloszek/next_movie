import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/widget_extensions.dart';
import 'package:next_movie/common/utils/ratings_prioritizer.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:next_movie/presentation/widgets/movie_rating.dart';
import 'package:next_movie/presentation/widgets/poster_image.dart';

class MovieRecommendationCell extends StatelessWidget {
  final Movie movie;
  final EdgeInsets margin;
  final void Function(Movie) onSelected;

  const MovieRecommendationCell({
    Key key,
    @required this.movie,
    this.margin,
    @required this.onSelected,
  })  : assert(movie != null),
        assert(onSelected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(movie),
      borderRadius: const BorderRadius.all(
        Radius.circular(AppThemeConstants.cornerRadius),
      ),
      child: Container(
        margin: margin,
        child: Row(
          children: [
            _buildPoster(context),
            _buildMovieDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster(BuildContext context) {
    return Container(
      width: 73,
      decoration: BoxDecoration(
        color: AppColors.background(context),
        boxShadow: cellShadow(context),
      ),
      child: PosterImage(
        imageUrl: movie.poster,
      ),
    );
  }

  Widget _buildMovieDetails(BuildContext context) {
    return Container(
      width: 65,
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(context),
          _buildRatings(),
        ],
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Expanded(
      child: Text(
        movie.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.headline4(context),
      ),
    );
  }

  Widget _buildRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: RatingsPrioritizer.getPrioritizedRatings(movie.ratings)
          .map(
            (rating) => RatingLabel(
              movieRating: rating,
              margin: const EdgeInsets.only(top: 7),
            ),
          )
          .toList(),
    );
  }
}
