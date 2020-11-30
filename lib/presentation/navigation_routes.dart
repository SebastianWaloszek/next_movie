import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/movie_details/page/movie_details_page.dart';
import 'package:next_movie/presentation/features/movie_details/page/same_director_movie_list.dart';
import 'package:next_movie/presentation/features/movie_details/page/similar_movies_list.dart';
import 'package:next_movie/presentation/features/movie_list/pages/movie_list_page.dart';

import 'features/home/pages/home_page.dart';
import 'pages/splash_page.dart';

final Map<String, WidgetBuilder> navigationRoutes = <String, WidgetBuilder>{
  SplashPage.routeName: (BuildContext context) => AppPages.splash,
  HomePage.routeName: (BuildContext context) => AppPages.home,
  MovieListPage.routeName: (BuildContext context) => AppPages.movieList,
  MovieDetailsPage.routeName: (BuildContext context) => AppPages.movieDetails,
  SameDirectorMovieList.routeName: (BuildContext context) => AppPages.sameDirectorMovieList,
  SimilarMoviesList.routeName: (BuildContext context) => AppPages.similarMoviesList,
};

abstract class AppPages {
  static Widget get splash => const SplashPage();
  static Widget get home => HomePage();
  static Widget get movieDetails => const MovieDetailsPage();
  static Widget get movieList => const MovieListPage();
  static Widget get sameDirectorMovieList => SameDirectorMovieList();
  static Widget get similarMoviesList => SimilarMoviesList();
}
