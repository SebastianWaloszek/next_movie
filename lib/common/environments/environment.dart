abstract class Environment {
  static Environment _current;

  static Environment get current => _current;

  static void setCurrent(Environment environment) {
    _current ??= environment;
  }

  String get theMovieDbApiKey;
  String get youTubeApiKey;
}
