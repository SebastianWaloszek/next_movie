import 'package:meta/meta.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/common/parameters/movie_images.dart';

class GetMovieImagesRequest extends Request<MovieImages> {
  GetMovieImagesRequest({
    @required int movieId,
  })  : assert(movieId != null),
        super(
          path: 'https://api.themoviedb.org/3/movie/$movieId/images?api_key=${Environment.current.theMovieDbApiKey}',
        );

  @override
  MovieImages createResponse(dynamic json) => MovieImages.fromJson(json as Map<String, dynamic>);
}
