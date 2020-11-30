
import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/domain/entities/person.dart';

abstract class PeopleDataSource {
  Future<Result<List<int>, Failure>> getCreditedMovies(Person person);
}