import 'package:next_movie/domain/entities/crew_person.dart';

class CrewPersonModel extends CrewPerson {
  CrewPersonModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] as int,
          name: json['name'] as String,
          department: json['department'] as String,
          job: json['job'] as String,
          imageUrl: json['profile_path'] != null ? 'https://image.tmdb.org/t/p/w500${json['profile_path']}' : null,
        );
}
