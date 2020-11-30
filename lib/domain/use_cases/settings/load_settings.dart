import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/domain/repositories/settings_repository.dart';
import 'package:next_movie/domain/use_cases/use_case.dart';
import 'package:meta/meta.dart';

class LoadSettings extends UseCase<AppSettings, void> {
  final SettingsRepository settingsRepository;

  LoadSettings({
    @required this.settingsRepository,
  }) : assert(settingsRepository != null);

  @override
  Future<Result<AppSettings, Failure>> call(_) {
    return settingsRepository.loadAppSettings();
  }
}
