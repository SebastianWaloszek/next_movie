import 'package:next_movie/domain/entities/cast_person.dart';

class CastPersonModel extends CastPerson {
  CastPersonModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] as int,
          name: json['name'] as String,
          character: json['character'] as String,
          imageUrl: json['profile_path'] != null ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}' : null,
        );
}
