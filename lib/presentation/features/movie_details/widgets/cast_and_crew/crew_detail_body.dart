import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/crew_person.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/cast_and_crew/persons_details_body.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/person_cell.dart';

class CrewDetailsBody extends PersonsDetailsBody<CrewPerson> {
  final List<CrewPerson> crew;

  const CrewDetailsBody({
    this.crew,
  }) : super(persons: crew);

  bool isFirstInDepartment(CrewPerson person) {
    return person == crew.firstWhere((crewPerson) => crewPerson.department == person.department);
  }

  @override
  Widget buildGridViewCell(CrewPerson person) {
    return PersonCell(
      name: person.name,
      role: person.job,
      department: isFirstInDepartment(person) ? person.department : '',
      imageUrl: person.imageUrl,
    );
  }

  @override
  double get topPadding => 0;
}
