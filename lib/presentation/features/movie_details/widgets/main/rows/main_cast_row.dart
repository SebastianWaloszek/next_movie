import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/cast_person.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/main/rows/movie_detail_row.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/person_cell.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';

class MainCastRow extends StatelessWidget {
  static const int mainCastLimit = 8;
  final List<CastPerson> cast;
  final void Function() showEntireCast;

  const MainCastRow({
    Key key,
    this.cast,
    @required this.showEntireCast,
  })  : assert(showEntireCast != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: MovieDetailRow(
        name: AppLocalizations.of(context).mainCast(),
        nameMargin: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        sufix: AppLocalizations.of(context).seeAll(),
        sufixMargin: const EdgeInsets.only(right: AppThemeConstants.horizontal),
        onSufixTap: showEntireCast,
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return SizedBox(
      height: 143,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: AppThemeConstants.horizontal),
        itemCount: _getItemCount(),
        itemBuilder: (context, index) {
          final person = cast[index];
          return PersonCell(
            name: person.name,
            role: person.character,
            imageUrl: person.imageUrl,
            margin: const EdgeInsets.only(right: 10),
          );
        },
      ),
    );
  }

  int _getItemCount() {
    final castMembers = cast?.length ?? 0;
    if (castMembers > mainCastLimit) {
      return mainCastLimit;
    } else {
      return castMembers;
    }
  }
}
