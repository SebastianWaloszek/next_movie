import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Genre extends Equatable {
  final int id;
  final String name;

  const Genre({
    @required this.id,
    @required this.name,
  })  : assert(id != null),
        assert(name != null);

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
