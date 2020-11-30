import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/data/models/movie_rating_model.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:meta/meta.dart';

class GetImdbRatingsRequest extends Request<List<MovieRating>> {
  GetImdbRatingsRequest({
    @required String imdbId,
  })  : assert(imdbId != null),
        super(
          path: 'https://m.imdb.com/title/$imdbId',
        );

  @override
  List<MovieRating> createResponse(dynamic response) {
    final ratings = <MovieRating>[];
    // ignore: leading_newlines_in_multiline_strings
    const metacriticPrefix = ''' </span>
Metascore</a>    </div>''';

    const imdbRatingPrefix = '''<span class="mobile-sprite yellow-star"></span><span class="inline-block text-left vertically-middle">''';

    final metacriticPrefixStartIndex = response.indexOf(metacriticPrefix);
    if (metacriticPrefixStartIndex != -1) {
      final single = int.tryParse(response[metacriticPrefixStartIndex - 1] as String);
      final ten = int.tryParse(response[metacriticPrefixStartIndex - 2] as String);
      final hundred = int.tryParse(response[metacriticPrefixStartIndex - 3] as String);

      if (hundred != null) {
        ratings.add(MovieRatingModel.metacritic(100 * hundred + 10 * ten + single));
      } else if (ten == null) {
        ratings.add(MovieRatingModel.metacritic(single));
      } else {
        ratings.add(MovieRatingModel.metacritic(10 * ten + single));
      }
    }

    final imdbPredixStartIndex = response.indexOf(imdbRatingPrefix);
    if (imdbPredixStartIndex != -1) {
      final firstIndex = imdbPredixStartIndex + imdbRatingPrefix.length;
      final withDigits = double.tryParse(response.substring(firstIndex, firstIndex + 3) as String);

      if (withDigits != null) {
        ratings.add(MovieRatingModel.imdb(withDigits));
      } else {
        final withoutDigits = double.tryParse(response[firstIndex] as String);
        if (withoutDigits != null) {
          ratings.add(MovieRatingModel.imdb(withoutDigits));
        }
      }
    }

    return ratings;
  }
}
