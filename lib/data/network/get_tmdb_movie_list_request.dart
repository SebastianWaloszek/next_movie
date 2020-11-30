import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/data/network/tmdb_list_response_mapper.dart';
import 'package:meta/meta.dart';

abstract class GetTmdbMovieListRequest extends Request<List<int>> {

  GetTmdbMovieListRequest({@required String path}) : super(path: path);

  @override
  List<int> createResponse(dynamic response) => TmdbResponseMapper.movieIdsFromListResponse(response);
}
