import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/settings/bloc/settings_bloc.dart';
import 'package:next_movie/presentation/theme/app_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/utils/injector.dart';
import 'localization/localization.dart';
import 'navigation_routes.dart';

class MyApp extends StatefulWidget {
  static const String appName = 'Next Movie';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SettingsBloc get settingsBloc => Injector.resolve<SettingsBloc>();

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  void _loadSettings() {
    settingsBloc.add(LoadSettingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(create: (BuildContext context) => settingsBloc),
      ],
      child: _buildSettingsBuilder(),
    );
  }

  Widget _buildSettingsBuilder() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      cubit: settingsBloc,
      builder: (context, state) {
        return _buildMaterialApp(
          themeMode: state.settings.themeMode,
          settingsLoaded: settingsBloc.state is LoadedSettingsState,
        );
      },
    );
  }

  Widget _buildMaterialApp({ThemeMode themeMode, bool settingsLoaded}) {
    return MaterialApp(
      title: MyApp.appName,
      themeMode: themeMode,
      theme: appThemes[ThemeMode.light],
      darkTheme: appThemes[ThemeMode.dark],
      routes: navigationRoutes,
      home: _buildHome(settingsLoaded),
      localizationsDelegates: localizationDelegates,
      supportedLocales: supportedLocales,
    );
  }

  Widget _buildHome(bool settingsLoaded) {
    if (!settingsLoaded) {
      return AppPages.splash;
    } else {
      return AppPages.movieList;
    }
  }
}
