import 'package:next_movie/domain/entities/publication.dart';

class PublicationModel extends Publication {
  PublicationModel.fromJson(Map<String, dynamic> json)
      : super(
          name: json['name'] as String,
        );
}
