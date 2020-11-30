import 'package:next_movie/data/models/cast_person_model.dart';
import 'package:next_movie/data/models/crew_person_model.dart';
import 'package:next_movie/domain/entities/cast_person.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/crew_person.dart';

class CreditsModel extends Credits {
  const CreditsModel({
    List<CrewPerson> crew,
    List<CastPerson> cast,
  }) : super(
          crew: crew,
          cast: cast,
        );

  CreditsModel copyWith({
    List<CrewPerson> crew,
    List<CastPerson> cast,
  }) {
    return CreditsModel(
      crew: crew ?? this.crew,
      cast: cast ?? this.cast,
    );
  }

  CreditsModel.fromJson(Map<String, dynamic> json)
      : super(
          crew: List<CrewPersonModel>.from(
            (json['crew'] as List<dynamic>).map(
              (crewPerson) => CrewPersonModel.fromJson(crewPerson as Map<String, dynamic>),
            ),
          ),
          cast: List<CastPersonModel>.from(
            (json['cast'] as List<dynamic>).map(
              (castPerson) => CastPersonModel.fromJson(castPerson as Map<String, dynamic>),
            ),
          ),
        );
}
