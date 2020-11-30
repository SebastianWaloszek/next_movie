import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class RelatedMoviesPageArguments extends Equatable {
  final String pageTitle;
  final Bloc pageBloc;

  const RelatedMoviesPageArguments({
    @required this.pageTitle,
    @required this.pageBloc,
  })  : assert(pageTitle != null),
        assert(pageBloc != null);

  @override
  List<Object> get props => [
        pageTitle,
        pageBloc,
      ];
}
