import 'package:next_movie/domain/entities/person.dart';

abstract class CrewPerson extends Person {
  final String department;
  final String job;

  const CrewPerson({
    int id,
    this.department,
    this.job,
    String name,
    String imageUrl,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
        );

  @override
  List<Object> get props => [
        department,
        job,
        ...super.props,
      ];
}
