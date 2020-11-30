import 'package:next_movie/domain/entities/genre.dart';

class GenreModel extends Genre {
  GenreModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] as int,
          name: json['name'] as String,
        );
}
