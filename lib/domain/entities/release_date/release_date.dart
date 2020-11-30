import 'package:equatable/equatable.dart';
import 'package:next_movie/domain/entities/release_date/release_date_type.dart';

import 'package:meta/meta.dart';

abstract class ReleaseDate extends Equatable {
  final ReleaseDateType type;
  final DateTime date;
  final String note;
  

  const ReleaseDate({
    @required this.type,
    @required this.date,
    this.note,
  })  : assert(type != null),
        assert(date != null);

  @override
  List<Object> get props => [
        type,
        date,
        note,
      ];
}
