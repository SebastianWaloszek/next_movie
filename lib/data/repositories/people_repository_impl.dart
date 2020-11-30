import 'package:next_movie/data/data_sources/people_data_source.dart';
import 'package:next_movie/domain/entities/person.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/domain/repositories/people_repository.dart';
import 'package:meta/meta.dart';

class PeopleRepositoryImpl extends PeopleRepository {
  final PeopleDataSource peopleDataSource;

  PeopleRepositoryImpl({
    @required this.peopleDataSource,
  }) : assert(peopleDataSource != null);

  @override
  Future<Result<List<int>, Failure>> getCreditedMovies(Person person) {
    return peopleDataSource.getCreditedMovies(person);
  }
}
