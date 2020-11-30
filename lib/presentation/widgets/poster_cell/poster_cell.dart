import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/widgets/poster_cell/filled_poster_cell.dart';
import 'package:next_movie/presentation/widgets/poster_cell/skeleton_poster_cell.dart';

abstract class PosterCell extends StatelessWidget {
  final Movie movie;
  final void Function() onSelected;

  bool get shouldDisplayRatings => movie == null || movie.ratings.isNotEmpty;

  factory PosterCell({
    Key key,
    Movie movie,
    void Function() onSelected,
  }) {
    final hasEnoughData = movie != null;
    if (hasEnoughData) {
      return FilledPosterCell(
        key: key,
        movie: movie,
        onSelected: onSelected,
      );
    }
    return SkeletonPosterCell(key: key);
  }

  const PosterCell.toSuper({
    Key key,
    this.movie,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildPosterImage(context),
          _buildTitle(context),
          if (shouldDisplayRatings) buildRatings(),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: buildTitleText(context),
    );
  }

  Widget buildTitleText(BuildContext context);

  Widget buildPosterImage(BuildContext context);

  Widget buildRatings();
}
