import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';

// When adding a locale make sure:
// - to define it also in CFBundleLocalizations in Info.plist for iOS.
// - to create custom CupertinoLocalizationsDelegate and add it to localizationsDelegates when using cupertino widgets.

// Locale order is important!
List<Locale> supportedLocales = [
  // Defaults app's locale & language
  const Locale('en', 'US'),
  // Other locales
  // EXAMPLES:
  // const Locale('pl', 'PL'),
  // const Locale('de', 'DE'),
];

final List<LocalizationsDelegate> localizationDelegates = [
  const AppLocalizationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  DefaultCupertinoLocalizations.delegate,
  // Add other delegates here if needed
];
