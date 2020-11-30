import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_localization_messages.dart';
import 'localization.dart' as localization;
import 'messages/messages_all.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return localization.supportedLocales.map((locale) => locale.languageCode).contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class AppLocalizations with AppLocalizationMessages {
  static AppLocalizations current;

  AppLocalizations._() {
    current = this;
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.languageCode;
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations._();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}