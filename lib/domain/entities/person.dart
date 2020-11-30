import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Person extends Equatable {
  final int id;
  final String name;
  final String imageUrl;

  const Person({
    @required this.id,
    @required this.name,
    this.imageUrl,
  })  : assert(id != null),
        assert(name != null);

  @override
  List<Object> get props => [
        id,
        name,
        imageUrl,
      ];
}
