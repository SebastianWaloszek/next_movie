import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_movie/common/utils/injector.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/presentation/features/movie_details/bloc/movie_details_page_bloc.dart';
import 'package:next_movie/presentation/features/movie_details/page/same_director_movie_list.dart';
import 'package:next_movie/presentation/features/movie_details/page/similar_movies_list.dart';
import 'package:next_movie/presentation/features/related_movies/page/related_movies_page_arguments.dart';

import 'movie_details_page_body.dart';
import 'movie_details_page_body_parameters.dart';

class MovieDetailsPage extends StatefulWidget {
  static const routeName = 'movieDetails';

  const MovieDetailsPage({Key key}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetailsPageBloc pageBloc;

  Movie get movie => ModalRoute.of(context).settings.arguments as Movie;

  @override
  void initState() {
    _initDependencies();
    _loadMovieDetails();
    super.initState();
  }

  void _initDependencies() {
    pageBloc = Injector.resolve();
  }

  void _loadMovieDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      pageBloc.add(GetMovieDetailsEvent(movie: movie));
    });
  }

  void _showYouTubeVideo(String videoId) {
    pageBloc.add(ShowYouTubeVideoEvent(videoId: videoId));
  }

  void _showMovieDetails(Movie movie) {
    Navigator.of(context).pushNamed(
      MovieDetailsPage.routeName,
      arguments: movie,
    );
  }

  //TODO Seems like code duplication
  void _showSameDirectorMovies(String pageTitle) {
    Navigator.of(context).pushNamed(
      SameDirectorMovieList.routeName,
      arguments: RelatedMoviesPageArguments(
        pageBloc: pageBloc,
        pageTitle: pageTitle,
      ),
    );
  }

  void _showSimilarMovies(String pageTitle) {
    Navigator.of(context).pushNamed(
      SimilarMoviesList.routeName,
      arguments: RelatedMoviesPageArguments(
        pageBloc: pageBloc,
        pageTitle: pageTitle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsPageBloc, MovieDetailsPageState>(
      cubit: pageBloc,
      builder: (context, state) {
        return MovieDetailsPageBody(
          MovieDetailsPageParameters(
            context,
            movie: movie,
            movieImages: state.images,
            credits: state.credits,
            additionalRatings: state.additionalRatings,
            countryReleaseDates: state.countryReleaseDates,
            reviews: state.reviews,
            youTubeReviews: state.youTubeReviews,
            featuredCrew: state.featuredCrewPersons,
            similarMovies: state.similarMovies,
            sameDirectorMovies: state.sameDirectorMovies,
            showYouTubeVideo: _showYouTubeVideo,
            showMovieDetails: _showMovieDetails,
            showSameDirectorMovies: _showSameDirectorMovies,
            showSimilarMovies: _showSimilarMovies,
          ),
        );
      },
    );
  }
}
