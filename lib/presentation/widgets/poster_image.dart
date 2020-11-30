import 'package:flutter/material.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class PosterImage extends StatelessWidget {
  static const double aspectRatio = 0.67;

  final String _imageUrl;
  final double _cornerRadius;

  const PosterImage({
    Key key,
    String imageUrl,
    double cornerRadius = AppThemeConstants.cornerRadius,
  })  : _imageUrl = imageUrl,
        _cornerRadius = cornerRadius,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: _imageUrl != null ? _buildImage() : _buildPlaceholder(context),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_cornerRadius),
      child: Image.network(_imageUrl, fit: BoxFit.cover),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_cornerRadius)),
        color: AppColors.secondaryContent(context),
      ),
      child: _buildUnavailablePosterText(context),
    );
  }

  Widget _buildUnavailablePosterText(BuildContext context) {
    return Text(
      AppLocalizations.of(context).noPosterAvailable(),
      textAlign: TextAlign.center,
      style: AppTextStyles.subtitle1(
        context,
        color: AppColors.background(context),
      ),
    );
  }
}
