import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/common/result/failure_result.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/common/result/success_result.dart';
import 'package:next_movie/data/data_sources/settings_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSettingsDataSource implements SettingsDataSource {
  static const _settingsKey = 'settings';

  @override
  Future<Result<AppSettings, Failure>> getAppSettings() async {
    final failureResult = FailureResult<AppSettings, Failure>(UnexpectedFailure());
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final json = sharedPreferences.getString(_settingsKey);
      final settings = AppSettings.fromJson(json);
      if (settings != null) {
        return SuccessResult<AppSettings, Failure>(settings);
      }
      return failureResult;
    } on Exception {
      return failureResult;
    }
  }

  @override
  Future<Result<void, Failure>> saveAppSettings(AppSettings settings) async {
    final failureResult = FailureResult<AppSettings, Failure>(UnexpectedFailure());
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final json = settings.toJson();
      sharedPreferences.setString(_settingsKey, json);
      return SuccessResult<void, Failure>(null);
    } on Exception {
      return failureResult;
    }
  }
}
