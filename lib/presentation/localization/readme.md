localizations/readme.md
===

If you need to add a new string resource:

1. Add method for string resources in `lib/presentation/localization/app_localizations.dart`
Example below:
```
   String appName() => Intl.message(
       "'App Name",
       name: "appName",
       desc: "Describes the app's name");
```

2. Generate translation .arb files (used later by translators) using:
```
    flutter packages pub run intl_translation:extract_to_arb --output-dir=lib/presentation/localization/template lib/presentation/localization/app_localizations.dart
```

3. We get a `intl_messages.dart` file with english texts
4. We then send the file to our translators
5. We get back `intl_LOCALE_IDENTIFIER.arb` files (example: `intl_pl.dart` for Polish Language) that we need to put into `lib/presentation/localization/translations/` folder

6. We import translation files using the following command:
```
    flutter packages pub run intl_translation:generate_from_arb --output-dir=\lib/presentation/localization/messages --no-use-deferred-loading \lib/presentation/localization/app_localizations.dart lib/presentation/localization/translations/intl_*.arb
```

7. Then we can use our localized resources like this:
```
    AppLocalizations.of(context).appName(),
```