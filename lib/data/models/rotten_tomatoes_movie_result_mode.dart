import 'package:next_movie/domain/entities/rotten_tomatoes_movie_result.dart';

class RottenTomatoesMovieResultModel extends RottenTomatoesMovieResult {
  RottenTomatoesMovieResultModel.fromJson(Map<String, dynamic> json)
      : super(
          name: json['name'] as String,
          year: json['year'] as int,
          url: json['url'] as String,
        );
}
