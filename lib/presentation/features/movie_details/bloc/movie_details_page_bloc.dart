import 'dart:async';

import 'package:bloc/bloc.dart';
import "package:collection/collection.dart";
import 'package:equatable/equatable.dart';
import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/common/parameters/load_credited_movies.dart';
import 'package:next_movie/common/parameters/load_similar_movies_parameters.dart';
import 'package:next_movie/common/parameters/movie_images.dart';
import 'package:next_movie/common/parameters/movie_result.dart';
import 'package:next_movie/data/models/credits_model.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/crew_person.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:next_movie/domain/entities/movie_review.dart';
import 'package:next_movie/domain/entities/release_date/country_release_dates.dart';
import 'package:next_movie/domain/entities/youtube/youtube_video.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_additional_ratings.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_credited_movies.dart';

import 'package:next_movie/domain/use_cases/movie_details/get_movie_credits.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_movie_images.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_movie_release_dates.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_reviews.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_rotten_tomatoes_id.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_similar_movies.dart';
import 'package:next_movie/domain/use_cases/movie_details/get_youtube_reviews.dart';
import 'package:url_launcher/url_launcher.dart';

part 'movie_details_page_event.dart';
part 'movie_details_page_state.dart';

class MovieDetailsPageBloc extends Bloc<MovieDetailsPageEvent, MovieDetailsPageState> {
  final GetMovieImages getMovieImages;
  final GetRottenTomatoesId getRottenTomatoesId;
  final GetAdditionalRatings getAdditionalRatings;
  final GetMovieCredits getMovieCredits;
  final GetYouTubeReviews getYouTubeReviews;
  final GetReviews getReviews;
  final GetSimilarMovies getSimilarMovies;
  final GetCreditedMovies getCreditedMovies;
  final GetMovieReleaseDates getMovieReleaseDates;

  final StreamController<MovieResult> similarMovieStreamController = StreamController<MovieResult>();
  final StreamController<MovieResult> sameDirectorMovieStreamController = StreamController<MovieResult>();

  static MovieDetailsPageState get initialState => const LoadingMovieDetailsPageState();

  MovieDetailsPageBloc({
    @required this.getMovieImages,
    @required this.getRottenTomatoesId,
    @required this.getAdditionalRatings,
    @required this.getMovieCredits,
    @required this.getYouTubeReviews,
    @required this.getReviews,
    @required this.getSimilarMovies,
    @required this.getCreditedMovies,
    @required this.getMovieReleaseDates,
  })  : assert(getRottenTomatoesId != null),
        assert(getAdditionalRatings != null),
        assert(getMovieCredits != null),
        assert(getYouTubeReviews != null),
        assert(getSimilarMovies != null),
        assert(getCreditedMovies != null),
        assert(getReviews != null),
        assert(getMovieReleaseDates != null),
        super(initialState) {
    _initMovieStream();
  }

  void _initMovieStream() {
    similarMovieStreamController.stream.listen((MovieResult movieResult) {
      add(AddSimilarMovieEvent(movie: movieResult.movie));
    });
    sameDirectorMovieStreamController.stream.listen((MovieResult movieResult) {
      add(AddSameDirectorMovieEvent(movie: movieResult.movie));
    });
  }

  @override
  Future<void> close() {
    similarMovieStreamController.close();
    sameDirectorMovieStreamController.close();
    return super.close();
  }

  @override
  Stream<MovieDetailsPageState> mapEventToState(
    MovieDetailsPageEvent event,
  ) async* {
    if (event is GetMovieDetailsEvent) {
      yield* _handleGetMovieDetailsEvent(event);
    } else if (event is ShowYouTubeVideoEvent) {
      _handleShowingYouTubeVideo(event);
    } else if (event is AddSimilarMovieEvent) {
      yield* _handleAddingSimilarMovie(event);
    } else if (event is AddSameDirectorMovieEvent) {
      yield* _handleAddSameDirectorMovie(event);
    } else if (event is LoadMoreSimilarMoviesEvent) {
      yield* _getSimilarMovies();
    }
  }

  Stream<MovieDetailsPageState> _handleGetMovieDetailsEvent(GetMovieDetailsEvent event) async* {
    yield LoadedMovieDetailsPageState(movie: event.movie);

    yield* _getMovieImages(event);
    yield* _getMovieCredits(event);
    yield* _getRottenTomatoesId(event);
    if (state.rottenTomatoesId != null) {
      yield* _getAdditionalRatings(event);
    }
    yield* _getYouTubeReviews(event);
    yield* _getSimilarMovies();
    yield* _getSameDirectorMovies();
    yield* _getReleaseDates(event);
    if (state.rottenTomatoesId != null) {
      yield* _getReviews(event);
    }
  }

  Stream<MovieDetailsPageState> _getMovieImages(GetMovieDetailsEvent event) async* {
    final result = await getMovieImages(event.movie.id);
    yield* result.fold(
      onSuccess: (movieImages) async* {
        yield state.copyWith(images: movieImages);
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(
          failure: failure,
          currentState: state,
        );
      },
    );
  }

  Stream<MovieDetailsPageState> _getMovieCredits(GetMovieDetailsEvent event) async* {
    final result = await getMovieCredits(event.movie.id);
    yield* result.fold(
      onSuccess: (credits) async* {
        final departmentGroupedCrew = groupBy(credits.crew, (CrewPerson person) => person.department);
        final crewSortedCredits = (credits as CreditsModel).copyWith(
            crew: departmentGroupedCrew.entries.map((e) => e.value.toList()).reduce(
          (value, element) {
            value.addAll(element);
            return value;
          },
        ).toList());
        yield state.copyWith(
          credits: crewSortedCredits,
          featuredCrewPersons: _getFeaturedCrew(credits.crew),
        );
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(
          failure: failure,
          currentState: state,
        );
      },
    );
  }

  Map<CrewPerson, List<String>> _getFeaturedCrew(List<CrewPerson> crew) {
    final featuredRoles = ['Director', 'Writer', 'Story', 'Screenplay'];

    final featuredCrew = <CrewPerson, List<String>>{};
    final filteredCrew = crew.where((CrewPerson crewPerson) => featuredRoles.contains(crewPerson.job)).toList();

    final groupedByJob = groupBy(filteredCrew, (CrewPerson person) => person.job);
    final groupedByPersons = groupedByJob.map((job, listOfPersons) => MapEntry(listOfPersons, job));
    groupedByPersons.forEach(
      (persons, job) {
        for (final person in persons) {
          final existingPerson = featuredCrew.keys.toList().firstWhere(
                (crewPerson) => crewPerson.id == person.id,
                orElse: () => null,
              );
          if (existingPerson == null) {
            featuredCrew.putIfAbsent(person, () => [job]);
          } else {
            featuredCrew[existingPerson].add(job);
          }
        }
      },
    );
    return featuredCrew;
  }

  Stream<MovieDetailsPageState> _getRottenTomatoesId(GetMovieDetailsEvent event) async* {
    final result = await getRottenTomatoesId(event.movie);
    yield* result.fold(
      onSuccess: (rottenTomatoesId) async* {
        yield state.copyWith(rottenTomatoesId: rottenTomatoesId);
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(
          failure: failure,
          currentState: state,
        );
      },
    );
  }

  Stream<MovieDetailsPageState> _getAdditionalRatings(GetMovieDetailsEvent event) async* {
    final result = await getAdditionalRatings(state.rottenTomatoesId);
    yield* result.fold(
      onSuccess: (ratings) async* {
        yield state.copyWith(additionalRatings: ratings);
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(
          failure: failure,
          currentState: state,
        );
      },
    );
  }

  Stream<MovieDetailsPageState> _getReviews(GetMovieDetailsEvent event) async* {
    final result = await getReviews(state.rottenTomatoesId);
    yield* result.fold(
      onSuccess: (reviews) async* {
        final filteredReviews = reviews.where((review) => review.critic != null).toList();
        yield state.copyWith(reviews: filteredReviews);
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(
          failure: failure,
          currentState: state,
        );
      },
    );
  }

  Stream<MovieDetailsPageState> _getYouTubeReviews(GetMovieDetailsEvent event) async* {
    final result = await getYouTubeReviews(event.movie.title);
    yield* result.fold(
      onSuccess: (videos) async* {
        yield state.copyWith(youTubeReviews: videos);
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(
          failure: failure,
          currentState: state,
        );
      },
    );
  }

  Future<void> _handleShowingYouTubeVideo(ShowYouTubeVideoEvent event) async {
    final url = 'https://www.youtube.com/watch?v=${event.videoId}';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Stream<MovieDetailsPageState> _getSimilarMovies() async* {
    final listPage = state.similarMoviesPage + 1;
    getSimilarMovies(
      LoadSimilarMoviesParameters(
        movieId: state.movie.id,
        similarMovieSink: similarMovieStreamController,
        page: listPage,
      ),
    );
    yield state.copyWith(
      similarMoviesPage: listPage,
    );
  }

  Stream<MovieDetailsPageState> _handleAddingSimilarMovie(AddSimilarMovieEvent event) async* {
    yield state.copyWith(
      similarMovies: state.similarMovies.toList()..add(event.movie),
    );
  }

  Stream<MovieDetailsPageState> _getSameDirectorMovies() async* {
    final director = state.credits.crew.firstWhere((crewMember) => crewMember.job == 'Director');
    final result = await getCreditedMovies(
      LoadCreditedMoviesParameters(
        person: director,
        currentMovieId: state.movie.id,
        movieSink: sameDirectorMovieStreamController,
      ),
    );
    yield* result.fold(
      onSuccess: (sameDirectorMovieCount) async* {
        yield state.copyWith(
          sameDirectorMovieCount: sameDirectorMovieCount,
        );
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(failure: failure);
      },
    );
  }

  Stream<MovieDetailsPageState> _handleAddSameDirectorMovie(AddSameDirectorMovieEvent event) async* {
    yield state.copyWith(
      sameDirectorMovies: state.sameDirectorMovies.toList()..add(event.movie),
    );
  }

  Stream<MovieDetailsPageState> _getReleaseDates(GetMovieDetailsEvent event) async* {
    final result = await getMovieReleaseDates(event.movie.id);
    yield* result.fold(
      onSuccess: (countryReleaseDates) async* {
        if (countryReleaseDates != null) {
          yield state.copyWith(
            countryReleaseDates: countryReleaseDates
              ..releaseDates.sort(
                (leftReleaseDate, rightReleaseDate) => leftReleaseDate.date.compareTo(rightReleaseDate.date),
              ),
          );
        }
      },
      onFailure: (failure) async* {
        yield FailureMovieDetailsPageState.fromCurrentState(
          failure: failure,
          currentState: state,
        );
      },
    );
  }
}
