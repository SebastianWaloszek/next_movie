import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/network/network_service.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/common/result/result.dart';
import 'package:next_movie/data/data_sources/people_data_source.dart';
import 'package:next_movie/data/network/people/get_credited_movies_request.dart';
import 'package:next_movie/domain/entities/person.dart';

class RemotePeopleDataSource extends PeopleDataSource {
  final NetworkService networkService;

  RemotePeopleDataSource({@required this.networkService}) : assert(networkService != null);

  @override
  Future<Result<List<int>, Failure>> getCreditedMovies(Person person) {
    final request = GetCreditedMoviesRequest(person: person);
    return networkService.make(request) as Future<Result<List<int>, Failure>>;
  }
}
