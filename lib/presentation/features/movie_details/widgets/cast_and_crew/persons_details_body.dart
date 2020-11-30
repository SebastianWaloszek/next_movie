import 'package:flutter/material.dart';
import 'package:next_movie/domain/entities/person.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';

abstract class PersonsDetailsBody<T extends Person> extends StatelessWidget {
  final List<T> persons;

  const PersonsDetailsBody({
    Key key,
    this.persons,
  }) : super(key: key);

  Widget buildGridViewCell(T person);

  double get topPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buidlGridView(),
    );
  }

  Widget _buidlGridView() {
    return Scrollbar(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: topPadding,
          bottom: 20,
          left: AppThemeConstants.horizontal,
          right: AppThemeConstants.horizontal,
        ),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.59,
          crossAxisSpacing: 30,
          crossAxisCount: 3,
        ),
        itemCount: persons.length,
        itemBuilder: _buildGridViewItem,
      ),
    );
  }

  Widget _buildGridViewItem(BuildContext context, int index) {
    final person = persons[index];
    return buildGridViewCell(person);
  }
}
