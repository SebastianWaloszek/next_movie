import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/data/data_sources/settings_data_source.dart';
import 'package:next_movie/domain/repositories/settings_repository.dart';
import 'package:meta/meta.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsDataSource settingsDataSource;

  SettingsRepositoryImpl({
    @required this.settingsDataSource,
  }) : assert(settingsDataSource != null);

  @override
  Future<Result<AppSettings, Failure>> loadAppSettings() {
    return settingsDataSource.getAppSettings();
  }

  @override
  Future<Result<void, Failure>> saveAppSettings(AppSettings settings) {
    return settingsDataSource.saveAppSettings(settings);
  }
}
