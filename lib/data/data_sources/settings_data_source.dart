
import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/common/result/result.dart';

abstract class SettingsDataSource {
  Future<Result<AppSettings,Failure>> getAppSettings();
  Future<Result<void,Failure>> saveAppSettings(AppSettings settings);
}