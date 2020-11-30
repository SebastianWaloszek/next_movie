import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MovieImage extends Equatable {
  final String url;

  const MovieImage({
    @required this.url,
  }) : assert(url != null);

    @override
  List<Object> get props => [url];
}
