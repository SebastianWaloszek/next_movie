import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/crew_person.dart';
import 'package:next_movie/presentation/features/movie_details/widgets/featured_crew_member.dart';

class FeaturedCrewList extends StatelessWidget {
  final Map<CrewPerson, List<String>> featuredCrew;
  final EdgeInsets margin;

  const FeaturedCrewList({
    Key key,
    @required this.featuredCrew,
    this.margin,
  })  : assert(featuredCrew != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: margin,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 10),
        children: featuredCrew.keys
            .map(
              (person) => FeaturedCrewPerson(
                person: person,
                roles: featuredCrew[person],
                margin: const EdgeInsets.only(right: 10),
              ),
            )
            .toList(),
      ),
    );
  }
}
