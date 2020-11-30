import 'package:flutter/material.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';

enum MovieDetailTabType {
  main,
  cast,
  crew,
  facts,
  reviews,
}

extension MovieDetailTabTypeExtensions on MovieDetailTabType {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case MovieDetailTabType.main:
        return AppLocalizations.of(context).main();
      case MovieDetailTabType.cast:
        return AppLocalizations.of(context).cast();
      case MovieDetailTabType.crew:
        return AppLocalizations.of(context).crew();
      case MovieDetailTabType.facts:
        return AppLocalizations.of(context).facts();
      case MovieDetailTabType.reviews:
        return AppLocalizations.of(context).reviews();
      default:
        throw UnsupportedError('$this is not uspported');
    }
  }
}
