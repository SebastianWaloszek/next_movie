import 'package:next_movie/domain/entities/movie_image.dart';

class MovieImageModel extends MovieImage {
  const MovieImageModel({
    String url,
  }) : super(url: url);

  factory MovieImageModel.fromJson(Map<String, dynamic> json) {
    return MovieImageModel(
      url: 'https://image.tmdb.org/t/p/w500${json['file_path']}',
    );
  }
}
