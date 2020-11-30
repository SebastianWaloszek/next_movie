import 'package:meta/meta.dart';
import 'package:next_movie/data/models/movie_rating_model.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import '../../../common/network/request.dart';

class GetRottenTomatoesRatingsRequest extends Request<List<MovieRating>> {
  GetRottenTomatoesRatingsRequest({
    @required String rottenTomatoesId,
  })  : assert(rottenTomatoesId != null),
        super(
          path: 'https://www.rottentomatoes.com/m/$rottenTomatoesId',
        );

  @override
  List<MovieRating> createResponse(dynamic response) {
    final ratings = <MovieRating>[];
    const criticPrefix = '''
                </span>
            </a>
        </h2>
    

    <div class="mop-ratings''';

    const audiencePrefix = '''
                </span>
            </a>
        </h2>
        <div class="mop-ratings''';

    final int criticPrefixStartIndex = (response as String).indexOf(criticPrefix) - 2;
    if (criticPrefixStartIndex >= 0) {
      final single = double.tryParse(response[criticPrefixStartIndex - 1] as String);
      final ten = double.tryParse(response[criticPrefixStartIndex - 2] as String);
      final hundred = double.tryParse(response[criticPrefixStartIndex - 3] as String);

      if (hundred != null) {
        ratings.add(MovieRatingModel.rottenCritics(100 * hundred + 10 * ten + single));
      } else if (ten == null) {
        ratings.add(MovieRatingModel.rottenCritics(single));
      } else {
        ratings.add(MovieRatingModel.rottenCritics(10 * ten + single));
      }
    }

    final int audiencePredixStartIndex = (response as String).indexOf(audiencePrefix) - 2;
    if (audiencePredixStartIndex >= 0) {
      final single = double.tryParse(response[audiencePredixStartIndex - 1] as String);
      final ten = double.tryParse(response[audiencePredixStartIndex - 2] as String);
      final hundred = double.tryParse(response[audiencePredixStartIndex - 3] as String);

      if (hundred != null) {
        ratings.add(MovieRatingModel.rottenAudience(100 * hundred + 10 * ten + single));
      } else if (ten == null) {
        ratings.add(MovieRatingModel.rottenAudience(single));
      } else {
        ratings.add(MovieRatingModel.rottenAudience(10 * ten + single));
      }
    }

    return ratings;
  }
}
