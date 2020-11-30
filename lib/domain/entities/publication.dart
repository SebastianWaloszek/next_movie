import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Publication extends Equatable {
  final String name;
  final String url;
  
  const Publication({
    @required this.name,
    this.url,
  }) : assert(name != null);

  @override
  List<Object> get props => [
        name,
        url,
      ];
}
