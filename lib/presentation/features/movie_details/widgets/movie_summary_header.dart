import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/duration_extensions.dart';
import 'package:next_movie/common/utils/extensions/widget_extensions.dart';
import 'package:next_movie/domain/entities/crew_person.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/featured_crew_list.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/genre_tag.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:next_movie/presentation/widgets/poster_image.dart';

class MovieSummaryHeader extends StatelessWidget {
  final Movie movie;
  final Map<CrewPerson, List<String>> featuredCrew;

  const MovieSummaryHeader({
    Key key,
    @required this.movie,
    this.featuredCrew,
  })  : assert(movie != null),
        super(key: key);

  bool get showReleaseYear => movie?.releaseDate?.year != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppThemeConstants.horizontal),
      child: Row(children: [
        _buildPoster(context),
        _buildBasicMovieDetails(context),
      ]),
    );
  }

  Widget _buildPoster(BuildContext context) {
    return Container(
      width: 117,
      decoration: BoxDecoration(boxShadow: cellShadow(context)),
      child: PosterImage(imageUrl: movie.poster),
    );
  }

  Widget _buildBasicMovieDetails(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGenreTags(),
            _buildTitleRow(context),
            _buildRuntimeText(context),
            if (featuredCrew != null) _buildFeaturedCrew(),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreTags() {
    return SizedBox(
      height: 18,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10),
        children: movie.genres
            .map(
              (genre) => GenreTag(
                genre: genre,
                margin: const EdgeInsets.only(right: 10),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(context),
          if (showReleaseYear) _buildYearText(context),
        ],
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(
      movie.title,
      style: AppTextStyles.headline1(context),
    );
  }

  Widget _buildYearText(BuildContext context) {
    return Text(
      '${movie.releaseDate.year}',
      style: AppTextStyles.body2(
        context,
        color: AppColors.secondaryContent(context),
      ),
    );
  }

  Widget _buildRuntimeText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 5),
      child: Text(
        movie.runtime.getRuntime(context),
        style: AppTextStyles.subtitle3(context),
      ),
    );
  }

  Widget _buildFeaturedCrew() {
    return FeaturedCrewList(
      featuredCrew: featuredCrew,
      margin: const EdgeInsets.only(top: 10),
    );
  }
}
