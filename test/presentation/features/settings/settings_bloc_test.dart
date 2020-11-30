import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/common/result/failure_result.dart';
import 'package:next_movie/common/result/success_result.dart';
import 'package:next_movie/domain/use_cases/settings/load_settings.dart';
import 'package:next_movie/domain/use_cases/settings/save_settings.dart';
import 'package:next_movie/presentation/features/settings/bloc/settings_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class LoadSettingsMock extends Mock implements LoadSettings {}

class SaveSettingsMock extends Mock implements SaveSettings {}

void main() {
  LoadSettings loadSettings;
  SaveSettings saveSettings;

  SettingsBloc bloc;

  const settings = AppSettings(
    themeMode: ThemeMode.dark,
  );

  const defaultSettings = AppSettings(
    themeMode: ThemeMode.system,
  );

  final successLoadResult = SuccessResult<AppSettings, Failure>(settings);
  final failedLoadResult = FailureResult<AppSettings, Failure>(UnexpectedFailure());

  final successSaveResult = SuccessResult<void, Failure>(null);
  final failedSaveResult = FailureResult<void, Failure>(UnexpectedFailure());

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    loadSettings = LoadSettingsMock();
    saveSettings = SaveSettingsMock();

    bloc = SettingsBloc(
      loadSettings: loadSettings,
      saveSettings: saveSettings,
    );
  });

  blocTest(
    'Should emit correct states when loading settings succeeds',
    build: () async {
      when(loadSettings.call(any)).thenAnswer((_) async => successLoadResult);
      return bloc;
    },
    act: (bloc) async {
      return bloc.add(LoadSettingsEvent());
    },
    expect: [
      const LoadedSettingsState(settings),
    ],
  );

  blocTest(
    'Should emit correct states when loading settings fails',
    build: () async {
      when(loadSettings.call(any)).thenAnswer((_) async => failedLoadResult);
      return bloc;
    },
    act: (bloc) async {
      return bloc.add(LoadSettingsEvent());
    },
    expect: [
      const LoadedSettingsState(defaultSettings),
    ],
  );

  blocTest(
    'Should emit correct states when changing theme settings',
    build: () async {
      when(saveSettings.call(any)).thenAnswer((_) async => successSaveResult);
      return bloc;
    },
    act: (bloc) async {
      return bloc.add(const ChangeThemeEvent(platformBrightness: Brightness.light, mode: ThemeMode.dark));
    },
    expect: [
      const LoadedSettingsState(settings),
    ],
  );

  blocTest(
    'Should emit correct states when changing theme settings fails',
    build: () async {
      when(saveSettings.call(any)).thenAnswer((_) async => failedSaveResult);
      return bloc;
    },
    act: (bloc) async {
      return bloc.add(const ChangeThemeEvent(platformBrightness: Brightness.light, mode: ThemeMode.dark));
    },
    expect: [
      const LoadedSettingsState(defaultSettings),
    ],
  );
}
