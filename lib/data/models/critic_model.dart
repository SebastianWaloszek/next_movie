import 'package:next_movie/domain/entities/critic.dart';

class CriticModel extends Critic {
  CriticModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'] as int,
          name: json['name'] as String,
        );
}
