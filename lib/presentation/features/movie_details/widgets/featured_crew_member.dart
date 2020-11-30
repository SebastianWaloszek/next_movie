import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/crew_person.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';

class FeaturedCrewPerson extends StatelessWidget {
  final CrewPerson person;
  final List<String> roles;

  final EdgeInsets margin;

  const FeaturedCrewPerson({
    Key key,
    @required this.person,
    @required this.roles,
    this.margin,
  })  : assert(person != null),
        assert(roles != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildNameText(context),
          _buildRolesText(context),
        ],
      ),
    );
  }

  Widget _buildNameText(BuildContext context) {
    return Text(
      person.name,
      style: AppTextStyles.headline4(context),
    );
  }

  Widget _buildRolesText(BuildContext context) {
    return Text(
      roles.reduce((value, element) => '$value, $element'),
      style: AppTextStyles.subtitle3(context),
    );
  }
}
