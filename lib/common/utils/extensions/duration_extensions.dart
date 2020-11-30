import 'package:flutter/material.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';

extension DurationExtensions on Duration {
  String getRuntime(BuildContext context) {
    final hours = inHours;
    final minutes = inMinutes % 60;
    if (hours != 0 && minutes != 0) {
      return AppLocalizations.of(context).runtime(
        hours: AppLocalizations.of(context).runtimeHours(hours),
        minutes: AppLocalizations.of(context).runtimeMinutes(minutes),
        );
    } else if (hours != 0) {
      return AppLocalizations.of(context).runtime(
        hours: AppLocalizations.of(context).runtimeHours(hours),
        );
    } else {
      return AppLocalizations.of(context).runtime(
        hours: AppLocalizations.of(context).runtimeMinutes(minutes),
        );
    }
  }
}
