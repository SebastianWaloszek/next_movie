import 'package:equatable/equatable.dart';

import 'package:next_movie/domain/entities/cast_person.dart';
import 'package:next_movie/domain/entities/crew_person.dart';

abstract class Credits extends Equatable {
  final List<CrewPerson> crew;
  final List<CastPerson> cast;

  const Credits({
    this.crew,
    this.cast,
  });

  CrewPerson get director => crew?.firstWhere((crewMember) => crewMember.job == 'Director');

  @override
  List<Object> get props => [
        crew,
        cast,
      ];
}
