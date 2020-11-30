import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/presentation/theme/app_images.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class RatingLabel extends StatelessWidget {
  static const double _iconSize = 24;

  final MovieRating movieRating;
  final EdgeInsets margin;

  const RatingLabel({
    Key key,
    @required this.movieRating,
    this.margin,
  })  : assert(movieRating != null),
        super(key: key);

  bool get shouldShowText => movieRating.source != MovieRatingSource.metacritic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Row(
        children: <Widget>[
          _buildSourceIcon(context),
          if (shouldShowText) _buildValueText(context),
        ],
      ),
    );
  }

  Widget _buildSourceIcon(BuildContext context) {
    if (movieRating.source == MovieRatingSource.metacritic) {
      return _ImdbRatingCell(
        value: movieRating.value as int,
      );
    }
    return Image(
      image: _getIcon(context),
      width: _iconSize,
      height: _iconSize,
    );
  }

  Widget _buildValueText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, bottom: 3),
      child: Text(
        _getValue(),
        style: AppTextStyles.subtitle1(
          context,
          color: AppColors.primaryContent(context),
        ),
      ),
    );
  }

  String _getValue() {
    switch (movieRating.source) {
      case MovieRatingSource.rottenTomatoes:
        return '${movieRating.value.floor()}%';
      case MovieRatingSource.imdb:
      case MovieRatingSource.tmdb:
        return '${movieRating.value}';
      default:
        throw UnimplementedError('${movieRating.source} is not supported!');
    }
  }

  AssetImage _getIcon(BuildContext context) {
    switch (movieRating.source) {
      case MovieRatingSource.imdb:
        return AppImages.imdb(context);
      case MovieRatingSource.rottenTomatoes:
        return _getRottenIcon(context);
      case MovieRatingSource.tmdb:
        return AppImages.tmdb(context);
      default:
        throw UnimplementedError('${movieRating.source} is not supported!');
    }
  }

  AssetImage _getRottenIcon(BuildContext context) {
    switch (movieRating.type) {
      case MovieRatingType.critics:
        if (movieRating.value >= 60) {
          return AppImages.rottenCriticPositive(context);
        } else {
          return AppImages.rottenCriticNegative(context);
        }
        break;
      case MovieRatingType.audience:
        if (movieRating.value >= 60) {
          return AppImages.rottenPublicPositive(context);
        } else {
          return AppImages.rottenPublicNegative(context);
        }
        break;
      default:
        throw UnimplementedError('${movieRating.type} is not supported!');
    }
  }
}

class _ImdbRatingCell extends StatelessWidget {
  final int value;

  double get size => 24;

  const _ImdbRatingCell({
    Key key,
    @required this.value,
  })  : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: _buildBoxDecoration(context),
      child: _buildValueText(context),
    );
  }

  Widget _buildValueText(BuildContext context) {
    return Center(
      child: Text(
        '$value',
        textAlign: TextAlign.center,
        style: AppTextStyles.body3(
          context,
          color: AppColors.background(context),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getColorForValue(context),
      borderRadius: const BorderRadius.all(
        Radius.circular(1),
      ),
    );
  }

  Color _getColorForValue(BuildContext context) {
    if (value < 40) {
      return AppColors.red(context);
    } else if (value <= 60) {
      return AppColors.yellow(context);
    } else {
      return AppColors.green(context);
    }
  }
}
