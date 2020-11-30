import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/app_settings.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/domain/repositories/settings_repository.dart';
import 'package:next_movie/domain/use_cases/use_case.dart';
import 'package:meta/meta.dart';

class SaveSettings extends UseCase<void, AppSettings> {
  final SettingsRepository settingsRepository;

  SaveSettings({
    @required this.settingsRepository,
  }) : assert(settingsRepository != null);

  @override
  Future<Result<void, Failure>> call(AppSettings settings) {
    return settingsRepository.saveAppSettings(settings);
  }
}
