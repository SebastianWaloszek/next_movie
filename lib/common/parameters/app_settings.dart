import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppSettings extends Equatable {
  static const themeKey = 'theme';

  final ThemeMode themeMode;

  const AppSettings({
    @required this.themeMode,
  })  : assert(themeMode != null);

  const AppSettings.defaultSettings()
      : themeMode = ThemeMode.system;

  AppSettings copyWith({ThemeMode themeMode}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object> get props => [
        themeMode,
      ];

  //      //
  // JSON //
  //      //
  String toJson() {
    final map = {
      themeKey: themeMode.toString(),
    };
    return json.encode(map);
  }

  factory AppSettings.fromJson(String jsonString) {
    if (jsonString == null) {
      return null;
    }
    final jsonMap = json.decode(jsonString) as Map<dynamic, dynamic>;
    final Map<String, String> settingsMap = Map<String, String>.from(jsonMap);
    return AppSettings(
      themeMode: _themeModeFromString(settingsMap[themeKey]),
    );
  }

  static ThemeMode _themeModeFromString(String s) {
    return ThemeMode.values.firstWhere((e) => e.toString() == s, orElse: () => null);
  }
}
