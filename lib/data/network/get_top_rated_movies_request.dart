import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/data/network/get_tmdb_movie_list_request.dart';
import 'package:meta/meta.dart';

class GetTopRatedMoviesRequest extends GetTmdbMovieListRequest {
  GetTopRatedMoviesRequest({
    // TODO: Decide what to do later with language
    @required int page,
    String language = 'en-US',
  })  : assert(page != null),
        super(
          path:
              'https://api.themoviedb.org/3/movie/top_rated?api_key=${Environment.current.theMovieDbApiKey}&language=$language&page=$page',
        );
}
