part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class LoadSettingsEvent extends SettingsEvent {
  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends SettingsEvent {
  final Brightness platformBrightness;
  final ThemeMode mode;

  const ChangeThemeEvent({
    @required this.platformBrightness,
    @required this.mode,
  })  : assert(platformBrightness != null),
        assert(mode != null);

  @override
  List<Object> get props => [mode];
}

class ChangeNotificationPermissionEvent extends SettingsEvent {
  final void Function(Future<void> Function() showSettings) showSettingsAlert;

  const ChangeNotificationPermissionEvent({
    @required this.showSettingsAlert,
  }) : assert(showSettingsAlert != null);

  @override
  List<Object> get props => [
        showSettingsAlert,
      ];
}
