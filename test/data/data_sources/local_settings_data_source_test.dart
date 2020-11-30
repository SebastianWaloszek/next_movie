import 'package:flutter/material.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/data/data_sources/local/local_settings_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  LocalSettingsDataSource localSettingsDataSource;

  const settings = AppSettings(
    themeMode: ThemeMode.dark,
  );

  setUp(() {
    localSettingsDataSource = LocalSettingsDataSource();
    SharedPreferences.setMockInitialValues({"settings": settings.toJson()});
  });

  test('Should load settings from local storage', () async {
    final result = await localSettingsDataSource.getAppSettings();
    AppSettings resultingSettings;
    result.fold(
      onSuccess: (settings) => resultingSettings = settings,
      onFailure: (_) {},
    );
    expect(resultingSettings, settings);
  });
}
