import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/date_time_extensions.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/presentation/theme/app_images.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class MovieReviewRow extends StatelessWidget {
  final MovieReview movieReview;
  final EdgeInsets margin;

  const MovieReviewRow({
    Key key,
    @required this.movieReview,
    this.margin,
  })  : assert(movieReview != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeading(context),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildLeading(BuildContext context) {
    final isPostive = movieReview.rating == ReviewRating.positive;
    return SizedBox(
      width: 27,
      child: Image(
        image: isPostive ? AppImages.rottenCriticPositive(context) : AppImages.rottenCriticNegative(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildQuoteText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCriticNameRow(context),
        _buildReviewSourceText(context),
      ],
    );
  }

  Widget _buildCriticNameRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCriticNameWithLeading(context),
        _buildCreationDateText(context),
      ],
    );
  }

  Widget _buildCriticNameLeading(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Icon(
        Icons.star,
        size: 18,
        color: AppColors.yellow(context),
      ),
    );
  }

  Widget _buildCriticNameWithLeading(BuildContext context) {
    return Row(
      children: <Widget>[
        if (movieReview.isTop) _buildCriticNameLeading(context),
        _buildCriticNameText(context),
      ],
    );
  }

  Widget _buildCriticNameText(BuildContext context) {
    return Text(
      movieReview.critic.name,
      style: AppTextStyles.headline3(context),
    );
  }

  Widget _buildReviewSourceText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        movieReview.publication.name,
        style: AppTextStyles.body3(
          context,
          color: AppColors.secondaryContent(context),
        ),
      ),
    );
  }

  Widget _buildCreationDateText(BuildContext context) {
    return Text(
      movieReview.creationDate.yearMonthDay(),
      textAlign: TextAlign.end,
      style: AppTextStyles.subtitle3(context),
    );
  }

  Widget _buildQuoteText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        movieReview.quote,
        maxLines: 4,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.subtitle2(context),
      ),
    );
  }
}
