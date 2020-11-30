import 'package:meta/meta.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/data/models/rotten_tomatoes_movie_result_mode.dart';
import 'package:next_movie/domain/entities/rotten_tomatoes_movie_result.dart';

//ignore_for_file: invalid_assignment
class GetSearchMovieRequest extends Request<List<RottenTomatoesMovieResult>> {
  static const resultsLimit = 10;

  GetSearchMovieRequest({
    @required String movieName,
  })  : assert(movieName != null),
        super(path: 'https://www.rottentomatoes.com/api/private/v1.0/search/?q=$movieName&limit=$resultsLimit');

  @override
  List<RottenTomatoesMovieResult> createResponse(dynamic json) {
    final movies = List<Map<String, dynamic>>.from(json['movies'] as List);
    return movies
        .map(
          (movie) => RottenTomatoesMovieResultModel.fromJson(movie),
        )
        .toList();
  }
}
