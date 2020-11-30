abstract class TmdbResponseMapper {
  static List<int> movieIdsFromListResponse(dynamic response) {
    final listOfMovies = List<Map<String, dynamic>>.from(response['results'] as List);
    final listOfIds = List<int>.from(listOfMovies.map((json) => json['id']));
    return listOfIds;
  }
}
