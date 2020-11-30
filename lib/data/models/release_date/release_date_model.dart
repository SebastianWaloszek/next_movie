import 'package:next_movie/domain/entities/release_date/release_date.dart';
import 'package:next_movie/domain/entities/release_date/release_date_type.dart';

class ReleaseDateModel extends ReleaseDate {
  ReleaseDateModel.fromJson(Map<String, dynamic> json)
      : super(
            type: ReleaseDateTypeMapper.fromBackendValue(json['type'] as int),
            date: DateTime.tryParse(json['release_date'] as String),
            note: json['note'] as String);
}
