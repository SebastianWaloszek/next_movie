import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/data/network/get_tmdb_movie_list_request.dart';
import 'package:meta/meta.dart';

class GetSimilarMoviesRequest extends GetTmdbMovieListRequest {
  GetSimilarMoviesRequest({
    @required movieId,
    @required int page,
    // TODO: Decide what to do later with language
    String language = 'en-US',
  })  : assert(movieId != null),
        super(
          path:
              'https://api.themoviedb.org/3/movie/$movieId/similar?api_key=${Environment.current.theMovieDbApiKey}&language=$language&page=$page',
        );
}
