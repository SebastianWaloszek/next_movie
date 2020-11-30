import 'package:meta/meta.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/domain/entities/person.dart';
import '../../../common/network/request.dart';

//ignore_for_file: return_of_invalid_type, argument_type_not_assignable
class GetCreditedMoviesRequest extends Request<List<int>> {
  GetCreditedMoviesRequest({
    @required Person person,
  })  : assert(person != null),
        super(
          path: 'https://api.themoviedb.org/3/person/${person.id}/movie_credits?api_key=${Environment.current.theMovieDbApiKey}',
        );

  @override
  List<int> createResponse(dynamic json) {
    final crewCredits = json['crew'] as List<dynamic>;
    return List<int>.from(crewCredits.map((credit) => credit['id']));
  }
}
