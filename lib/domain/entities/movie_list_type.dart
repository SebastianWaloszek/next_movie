import 'package:flutter/cupertino.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';

enum MovieListType {
  nowPlaying,
  upcoming,
  popular,
  topRated,
}

extension MovieListTypeExtensions on MovieListType {
  String toLocalized(BuildContext context) {
    switch (this) {
      case MovieListType.nowPlaying:
        return AppLocalizations.of(context).nowPlaying();
      case MovieListType.popular:
        return AppLocalizations.of(context).popular();
      case MovieListType.topRated:
        return AppLocalizations.of(context).topRated();
      case MovieListType.upcoming:
        return AppLocalizations.of(context).upcoming();
      default:
        throw UnsupportedError('$this is not supported');
    }
  }
}
