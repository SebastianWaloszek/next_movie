import 'package:meta/meta.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/data/models/credits_model.dart';
import 'package:next_movie/domain/entities/credits.dart';

class GetMovieCreditsRequest extends Request<Credits> {
  GetMovieCreditsRequest({
    @required int movieId,
  })  : assert(movieId != null),
        super(
          path: 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=${Environment.current.theMovieDbApiKey}',
        );

  @override
  Credits createResponse(dynamic json) => CreditsModel.fromJson(json as Map<String, dynamic>);
}
