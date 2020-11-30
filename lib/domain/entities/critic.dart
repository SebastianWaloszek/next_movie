import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Critic extends Equatable {
  final int id;
  final String name;

  const Critic({
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
