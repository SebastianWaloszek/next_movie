import 'package:meta/meta.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/data/models/movie_model.dart';
import 'package:next_movie/domain/entities/movie.dart';

class GetMovieDetailsRequest extends Request<Movie> {
  GetMovieDetailsRequest({
    @required int id,
  })  : assert(id != null),
        super(path: 'https://api.themoviedb.org/3/movie/$id?api_key=${Environment.current.theMovieDbApiKey}');

  @override
  Movie createResponse(dynamic json) => MovieModel.fromJson(json as Map<String, dynamic>);
}
 