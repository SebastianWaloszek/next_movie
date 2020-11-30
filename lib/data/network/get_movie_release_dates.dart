import 'package:meta/meta.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/common/network/request.dart';
import 'package:next_movie/data/models/release_date/country_release_dates_model.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';

class GetMovieReleaseDatesRequest extends Request<CountryReleaseDates> {
  GetMovieReleaseDatesRequest({
    @required int movieId,
  })  : assert(movieId != null),
        super(
          path: 'https://api.themoviedb.org/3/movie/$movieId/release_dates?api_key=${Environment.current.theMovieDbApiKey}',
        );

  @override
  CountryReleaseDates createResponse(dynamic json) {
    final results = json['results'] as List<dynamic>;
    final countryReleaseDates = List<CountryReleaseDates>.from(
      results.map(
        (releaseDate) => CountryReleaseDatesModel.fromJson(releaseDate as Map<String, dynamic>),
      ),
    );
    final result = countryReleaseDates.firstWhere(
      (countryReleaseDate) => countryReleaseDate.countryCode == 'US',
      orElse: () => null,
    ); // TODO Make flexible country code.

    return result;
  }
}
