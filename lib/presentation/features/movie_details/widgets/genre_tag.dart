import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/genre.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:next_movie/presentation/theme/color/genre_colors.dart';

class GenreTag extends StatelessWidget {
  final Genre genre;
  final EdgeInsets margin;

  const GenreTag({
    Key key,
    @required this.genre,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: MovieGenreColors.getColor(genre.id),
        borderRadius: BorderRadius.circular(4),
      ),
      child: _buildGenreText(context),
    );
  }

  Widget _buildGenreText(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 6,
        right: 6,
        top: 2,
        bottom: 2,
      ),
      child: Text(
        genre.name.toUpperCase(),
        style: AppTextStyles.body3(
          context,
          color: AppColors.buttonContent(context),
        ),
      ),
    );
  }
}
