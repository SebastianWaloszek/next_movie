part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  final AppSettings settings;

  const SettingsState({@required this.settings}) : assert(settings != null);

  @override
  List<Object> get props => [settings];
}

class InitialSettingsState extends SettingsState {
  const InitialSettingsState() : super(settings: const AppSettings.defaultSettings());
}

class LoadedSettingsState extends SettingsState {
  const LoadedSettingsState(AppSettings settings) : super(settings: settings);
}
