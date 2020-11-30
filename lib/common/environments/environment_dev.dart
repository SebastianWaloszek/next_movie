import 'environment.dart';

class DevelopmentEnvironment implements Environment {
  @override
  String get theMovieDbApiKey => '';

  @override
  String get youTubeApiKey => '';
}
