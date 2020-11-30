import 'package:next_movie/data/models/release_date/release_date_model.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/release_date/release_date.dart';

class CountryReleaseDatesModel extends CountryReleaseDates {
  CountryReleaseDatesModel.fromJson(Map<String, dynamic> json)
      : super(
          countryCode: json['iso_3166_1'] as String,
          releaseDates: List<ReleaseDate>.from(
            (json['release_dates'] as List<dynamic>).map(
              (releaseDate) => ReleaseDateModel.fromJson(releaseDate as Map<String, dynamic>),
            ),
          ),
        );
}
