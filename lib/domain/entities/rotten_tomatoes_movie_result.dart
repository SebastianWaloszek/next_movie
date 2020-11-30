import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RottenTomatoesMovieResult extends Equatable {
  final String name;
  final int year;
  final String url;

  const RottenTomatoesMovieResult({
    @required this.name,
    this.year,
    @required this.url,
  })  : assert(name != null),
        assert(url != null);

  @override
  List<Object> get props => [
        name,
        year,
        url,
      ];
}
