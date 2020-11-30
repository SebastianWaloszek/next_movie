import 'package:flutter/material.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';

enum ReleaseDateType {
  premiere,
  limitedTheatrical,
  theatrical,
  digital,
  physical,
  tv,
}

extension ReleaseDateTypeExtensions on ReleaseDateType {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case ReleaseDateType.premiere:
        return AppLocalizations.of(context).premiere();
      case ReleaseDateType.limitedTheatrical:
        return AppLocalizations.of(context).limitedTheatrical();
      case ReleaseDateType.theatrical:
        return AppLocalizations.of(context).theatrical();
      case ReleaseDateType.digital:
        return AppLocalizations.of(context).digital();
      case ReleaseDateType.physical:
        return AppLocalizations.of(context).physical();
      case ReleaseDateType.tv:
        return AppLocalizations.of(context).tv();
      default:
        throw UnsupportedError('$this is not supported');
    }
  }
}

abstract class ReleaseDateTypeMapper {
  static ReleaseDateType fromBackendValue(int backendValue) {
    switch (backendValue) {
      case 1:
        return ReleaseDateType.premiere;
      case 2:
        return ReleaseDateType.limitedTheatrical;
      case 3:
        return ReleaseDateType.theatrical;
      case 4:
        return ReleaseDateType.digital;
      case 5:
        return ReleaseDateType.physical;
      case 6:
        return ReleaseDateType.tv;
      default:
        throw UnsupportedError('Backend value $backendValue is not supported');
    }
  }
}
