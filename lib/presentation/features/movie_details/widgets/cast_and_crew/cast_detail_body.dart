import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/cast_person.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/cast_and_crew/persons_details_body.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/person_cell.dart';

class CastDetailsBody extends PersonsDetailsBody<CastPerson> {
  final List<CastPerson> cast;

  const CastDetailsBody({
    this.cast,
  }) : super(persons: cast);

  @override
  Widget buildGridViewCell(CastPerson person) {
    return PersonCell(
      name: person.name,
      role: person.character,
      imageUrl: person.imageUrl,
    );
  }

  @override
  double get topPadding => 30;
}
