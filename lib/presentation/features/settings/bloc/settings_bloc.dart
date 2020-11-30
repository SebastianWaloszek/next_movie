import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/domain/use_cases/settings/load_settings.dart';
import 'package:next_movie/domain/use_cases/settings/save_settings.dart';

import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LoadSettings loadSettings;
  final SaveSettings saveSettings;

  static SettingsState get initialState => const InitialSettingsState();

  SettingsBloc({
    @required this.loadSettings,
    @required this.saveSettings,
  })  : assert(loadSettings != null),
        assert(saveSettings != null),
        super(initialState);

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LoadSettingsEvent) {
      yield* _handleLoadingSettings();
    } else if (event is ChangeThemeEvent) {
      yield* _handleChangingTheme(event);
    }
  }

  Stream<SettingsState> newLoadedState(AppSettings settings) async* {
    yield LoadedSettingsState(
      settings.copyWith(themeMode: settings.themeMode),
    );
  }

  Stream<SettingsState> _handleLoadingSettings() async* {
    final result = await loadSettings(null);
    yield* result.fold(
      onSuccess: (settings) async* {
        yield* newLoadedState(settings);
      },
      onFailure: (_) async* {
        // In the case of no custom settings specified or error => load default settings.
        yield* newLoadedState(const AppSettings.defaultSettings());
      },
    );
  }

  //       //
  // Theme //
  //       //
  Stream<SettingsState> _handleChangingTheme(ChangeThemeEvent event) async* {
    _setSystemChrome(
      platformBrightness: event.platformBrightness,
      themeMode: event.mode,
    );

    final settings = state.settings.copyWith(themeMode: event.mode);
    yield* _handleSavingSettings(settings);
  }

  Stream<SettingsState> _handleSavingSettings(AppSettings settings) async* {
    final result = await saveSettings(settings);
    yield* result.fold(
      onSuccess: (_) async* {
        yield* newLoadedState(settings);
      },
      onFailure: (_) async* {
        yield* newLoadedState(const AppSettings.defaultSettings());
      },
    );
  }

  void _setSystemChrome({@required platformBrightness, @required ThemeMode themeMode}) {
    SystemUiOverlayStyle overlayStyle;
    switch (themeMode) {
      case ThemeMode.light:
        overlayStyle = SystemUiOverlayStyle.dark;
        break;
      case ThemeMode.dark:
        overlayStyle = SystemUiOverlayStyle.light;
        break;
      case ThemeMode.system:
        overlayStyle = platformBrightness == Brightness.light ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
    }
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }
}
