import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/widget_extensions.dart';
import 'package:next_movie/common/utils/ratings_prioritizer.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:next_movie/presentation/widgets/movie_rating.dart';
import 'package:next_movie/presentation/widgets/poster_cell/poster_cell.dart';
import 'package:next_movie/presentation/widgets/poster_image.dart';

class FilledPosterCell extends PosterCell {
  const FilledPosterCell({
    Key key,
    Movie movie,
    void Function() onSelected,
  }) : super.toSuper(
          key: key,
          movie: movie,
          onSelected: onSelected,
        );

  @override
  Widget buildRatings() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: RatingsPrioritizer.getPrioritizedRatings(movie.ratings)
            .map((rating) => RatingLabel(
                  movieRating: rating,
                  margin: const EdgeInsets.only(right: 10),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget buildPosterImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background(context),
        boxShadow: cellShadow(context),
      ),
      child: PosterImage(imageUrl: movie.poster),
    );
  }

  @override
  Widget buildTitleText(BuildContext context) {
    return Text(
      movie.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.headline2(context),
    );
  }
}
