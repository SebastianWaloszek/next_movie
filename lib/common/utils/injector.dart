import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:next_movie/common/environments/environment.dart';
import 'package:next_movie/common/environments/environment_dev.dart';
import 'package:next_movie/common/environments/environment_prod.dart';
import 'package:next_movie/common/network/network_service.dart';
import 'package:next_movie/common/network/network_service_impl.dart';
import 'package:next_movie/common/network/web_network_info.dart';
import 'package:next_movie/common/parameters/movie_result.dart';
import 'package:next_movie/data/data_sources/local/local_settings_data_source.dart';
import 'package:next_movie/data/data_sources/movie_data_source.dart';
import 'package:next_movie/data/data_sources/people_data_source.dart';
import 'package:next_movie/data/data_sources/remote/remote_movie_data_source.dart';
import 'package:next_movie/data/data_sources/remote/remote_people_data_source.dart';
import 'package:next_movie/data/data_sources/settings_data_source.dart';
import 'package:next_movie/data/repositories/movie_repository_impl.dart';
import 'package:next_movie/data/repositories/people_repository_impl.dart';
import 'package:next_movie/data/repositories/settings_repository_impl.dart';
import 'package:next_movie/domain/repositories/movie_repository.dart';
import 'package:next_movie/domain/repositories/people_repository.dart';
import 'package:next_movie/domain/repositories/settings_repository.dart';
import 'package:next_movie/domain/use_cases/load_movies.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_additional_ratings.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_credited_movies.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_movie_credits.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_movie_images.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_movie_release_dates.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_reviews.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_rotten_tomatoes_id.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_similar_movies.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_youtube_reviews.dart';
import 'package:next_movie/domain/use_cases/settings/load_settings.dart';
import 'package:next_movie/domain/use_cases/settings/save_settings.dart';
import 'package:next_movie/presentation/features/movie_details/bloc/movie_details_page_bloc.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/movie_list_page_bloc.dart';
import 'package:next_movie/presentation/features/settings/bloc/settings_bloc.dart';
import 'package:kiwi/kiwi.dart';
import '../network/network_info.dart';

class Injector {
  static KiwiContainer container;
  static final T Function<T>([String name]) resolve = container.resolve;

  static void setup() {
    container = KiwiContainer();

    _common();

    _switchBasedOnEnvironment(
      devSetup: _commonDevelopment,
      prodSetup: _commonProduction,
    );

    if (kIsWeb) {
      _webCommon();
      _switchBasedOnEnvironment(
        devSetup: _webDevelopment,
        prodSetup: _webProduction,
      );
    } else {
      _mobileCommon();
      _switchBasedOnEnvironment(
        devSetup: _mobileDevelopment,
        prodSetup: _mobileProduction,
      );
    }
  }

  static void _switchBasedOnEnvironment({
    @required void Function() devSetup,
    @required void Function() prodSetup,
  }) {
    switch (Environment.current.runtimeType) {
      case DevelopmentEnvironment:
        devSetup?.call();
        break;
      case ProductionEnvironment:
        prodSetup?.call();
        break;
    }
  }

  static void _common() {
    //                 //
    //  N E T W O R K  //
    //                 //
    container.registerSingleton(
      (c) => Dio(BaseOptions())..interceptors.addAll(c.resolve()),
    );

    container.registerSingleton<NetworkService>(
      (c) => NetworkServiceImpl(
        networkInfo: c.resolve(),
        dio: c.resolve(),
      ),
    );
    container.registerInstance<Iterable<Interceptor>>(<Interceptor>[]);

    //                         //
    //  D A T A   S O U R C E  //
    //                         //
    container.registerSingleton<SettingsDataSource>(
      (c) => LocalSettingsDataSource(),
    );
    container.registerSingleton<MovieDataSource>(
      (container) => RemoteMovieDataSource(networkService: container.resolve()),
    );
    container.registerSingleton<PeopleDataSource>(
      (container) => RemotePeopleDataSource(networkService: container.resolve()),
    );

    //                       //
    //  R E P O S I T O R Y  //
    //                       //
    container.registerSingleton<SettingsRepository>(
      (c) => SettingsRepositoryImpl(settingsDataSource: c.resolve()),
    );
    container.registerSingleton<MovieRepository>(
      (container) => MovieRepositoryImpl(movieDataSource: container.resolve()),
    );
    container.registerSingleton<PeopleRepository>(
      (container) => PeopleRepositoryImpl(peopleDataSource: container.resolve()),
    );

    //                   //
    //  U S E   C A S E  //
    //                   //
    container.registerSingleton((c) => LoadSettings(settingsRepository: c.resolve()));
    container.registerSingleton((c) => SaveSettings(settingsRepository: c.resolve()));
    container.registerSingleton((c) => LoadMovies(movieRepository: c.resolve()));
    container.registerSingleton((c) => GetMovieCredits(movieRepository: c.resolve()));
    container.registerSingleton((c) => GetRottenTomatoesId(movieRepository: c.resolve()));
    container.registerSingleton((c) => GetAdditionalRatings(movieRepository: c.resolve()));
    container.registerSingleton((c) => GetReviews(movieRepository: c.resolve()));
    container.registerSingleton((c) => GetYouTubeReviews(movieRepository: c.resolve()));
    container.registerSingleton((c) => GetSimilarMovies(movieRepository: c.resolve()));
    container.registerSingleton((c) => GetMovieImages(movieRepository: c.resolve()));
    container.registerSingleton(
      (c) => GetCreditedMovies(
        movieRepository: c.resolve(),
        peopleRepository: c.resolve(),
      ),
    );
    container.registerSingleton((c) => GetMovieReleaseDates(movieRepository: c.resolve()));

    //             //
    //  B L O C S  //
    //             //
    container.registerSingleton(
      (c) => SettingsBloc(
        loadSettings: c.resolve(),
        saveSettings: c.resolve(),
      ),
    );

    //                     //
    //  P A G E   B L O C  //
    //                     //
    container.registerSingleton(
      (c) => MovieListPageBloc(
        loadMovies: c.resolve(),
        listMovieStreamController: c.resolve('listMovieStreamController'),
      ),
    );
    container.registerFactory(
      (c) => MovieDetailsPageBloc(
        getMovieCredits: c.resolve(),
        getRottenTomatoesId: c.resolve(),
        getAdditionalRatings: c.resolve(),
        getReviews: c.resolve(),
        getYouTubeReviews: c.resolve(),
        getSimilarMovies: c.resolve(),
        getMovieImages: c.resolve(),
        getCreditedMovies: c.resolve(),
        getMovieReleaseDates: c.resolve(),
      ),
    );
    //         //
    //  OTHER  //
    //         //
    container.registerInstance(StreamController<MovieResult>(), name: 'listMovieStreamController');
  }

  static void _commonDevelopment() {}

  static void _commonProduction() {}

  //     //
  // WEB //
  //     //
  static void _webCommon() {
    container.registerSingleton<NetworkInfo>(
      (c) => WebNetworkInfoImpl(),
    );
  }

  static void _webDevelopment() {}
  static void _webProduction() {}

  //        //
  // MOBILE //
  //        //
  static void _mobileCommon() {
    container.registerSingleton<NetworkInfo>(
      (c) => NetworkInfoImpl(c.resolve()),
    );
    container.registerSingleton((c) => DataConnectionChecker());
  }

  static void _mobileDevelopment() {}
  static void _mobileProduction() {}
}
