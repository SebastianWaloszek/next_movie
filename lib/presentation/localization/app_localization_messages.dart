import 'package:intl/intl.dart';

mixin AppLocalizationMessages {
  String exit() => Intl.message(
        'Exit',
        name: 'exit',
        desc: 'The word used to exit the current window',
      );

  String cancel() => Intl.message(
        'Cancel',
        name: 'cancel',
        desc: 'The word used to cancel an action',
      );

  String ok() => Intl.message(
        'OK',
        name: 'ok',
        desc: 'OK',
      );

  String unexpectedError() => Intl.message(
        'An unexpected error occured. Please try again later.',
        name: 'unexpectedError',
        desc: 'Error message when an unexpected error occurs',
      );

  String awaitingConnection() => Intl.message(
        'Awaiting connection...',
        name: 'awaitingConnection',
        desc: 'Text in view showing network unavailability',
      );

  String unexpectedErrorPressToRetry() => Intl.message(
        'An unexpected error occured\nTap to try again',
        name: 'unexpectedErrorPressToRetry',
        desc: 'Text in view showing network error',
      );

  String noInternetFound() => Intl.message(
        'No internet connection found',
        name: 'noInternetFound',
        desc: 'Error message when user has no internet available',
      );

  String authenticationFailed() => Intl.message(
        'Authentication failed',
        name: 'authenticationFailed',
      );

  String movies() => Intl.message(
        'Movies',
        name: 'movies',
      );

  String tv() => Intl.message(
        'TV',
        name: 'tv',
      );

  String settings() => Intl.message(
        'Settings',
        name: 'settings',
      );

  String nowPlaying() => Intl.message(
        'Now Playing',
        name: 'nowPlaying',
      );

  String popular() => Intl.message(
        'Popular',
        name: 'popular',
      );

  String topRated() => Intl.message(
        'Top rated',
        name: 'topRated',
      );

  String upcoming() => Intl.message(
        'Upcoming',
        name: 'upcoming',
      );

  String noPosterAvailable() => Intl.message(
        'No poster available',
        name: 'noPosterAvailable',
      );

  String main() => Intl.message(
        'Main',
        name: 'main',
      );

  String cast() => Intl.message(
        'Cast',
        name: 'cast',
      );

  String crew() => Intl.message(
        'Crew',
        name: 'crew',
      );

  String facts() => Intl.message(
        'Facts',
        name: 'facts',
      );

  String critics() => Intl.message(
        'Critics',
        name: 'critics',
      );

  String audience() => Intl.message(
        'Audience',
        name: 'audience',
      );

  String overview() => Intl.message(
        'Overview',
        name: 'overview',
      );

  String mainCast() => Intl.message(
        'Main cast',
        name: 'mainCast',
      );

  String fullCast() => Intl.message(
        'Full cast',
        name: 'fullCast',
      );

  String youtubeReviews() => Intl.message(
        'YouTube reviews',
        name: 'youtubeReviews',
      );

  String moreFrom(String director) => Intl.message(
        'More from $director',
        name: 'moreFrom',
      );

  String similarMovies() => Intl.message(
        'Similar movies',
        name: 'similarMovies',
      );

  String seeAll() => Intl.message(
        'See all',
        name: 'seeAll',
      );

  String actors() => Intl.message(
        'Actors',
        name: 'actors',
      );

  String status() => Intl.message(
        'Status',
        name: 'status',
      );

  String budget() => Intl.message(
        'Budget',
        name: 'budget',
      );

  String revenue() => Intl.message(
        'Revenue',
        name: 'revenue',
      );

  String income() => Intl.message(
        'Income',
        name: 'income',
      );

  String originalLanguage() => Intl.message(
        'Original language',
        name: 'originalLanguage',
      );

  String reviews() => Intl.message(
        'Reviews',
        name: 'reviews',
      );

  String all() => Intl.message(
        'All',
        name: 'all',
      );

  String topCritics() => Intl.message(
        'Top critics',
        name: 'topCritics',
      );

  String positive() => Intl.message(
        'Positive',
        name: 'positive',
      );

  String negative() => Intl.message(
        'Negative',
        name: 'negative',
      );

  String noReviewsAvailable() => Intl.message(
        'No reviews available',
        name: 'noReviewsAvailable',
      );

  String premiere() => Intl.message(
        'Premiere',
        name: 'premiere',
      );

  String limitedTheatrical() => Intl.message(
        'Limited theatrical',
        name: 'limitedTheatrical',
      );

  String theatrical() => Intl.message(
        'Theatrical',
        name: 'theatrical',
      );

  String digital() => Intl.message(
        'Digital',
        name: 'digital',
      );

  String physical() => Intl.message(
        'Physical',
        name: 'physical',
      );

  String releaseInformation() => Intl.message(
        'Release information',
        name: 'physical',
      );

  String runtimeHours(int hours) {
    return Intl.message(
      '$hours h',
      name: 'runtime',
    );
  }

  String runtimeMinutes(int hours) {
    return Intl.message(
      '$hours h',
      name: 'runtime',
    );
  }

  String runtime({String hours = '', String minutes = ''}) {
    return Intl.message(
      '$hours $minutes',
      name: 'runtime',
    );
  }
}
