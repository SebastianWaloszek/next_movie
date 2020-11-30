import 'package:next_movie/domain/entities/person.dart';

abstract class CastPerson extends Person {
  final String character;

  const CastPerson({
    int id,
    this.character,
    String name,
    String imageUrl,
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
        );

  @override
  List<Object> get props => [
        character,
        ...super.props,
      ];
}
