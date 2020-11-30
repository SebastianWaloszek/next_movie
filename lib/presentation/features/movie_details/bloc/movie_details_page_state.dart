part of 'movie_details_page_bloc.dart';

abstract class MovieDetailsPageState extends Equatable {
  final Movie movie;
  final MovieImages images;
  final Credits credits;
  final String rottenTomatoesId;
  final List<MovieRating> additionalRatings;
  final List<YouTubeVideo> youTubeReviews;
  final List<MovieReview> reviews;
  final Map<CrewPerson, List<String>> featuredCrewPersons;
  final List<Movie> similarMovies;
  final List<Movie> sameDirectorMovies;
  final int sameDirectorMovieCount;
  final CountryReleaseDates countryReleaseDates;

  final int similarMoviesPage;

  const MovieDetailsPageState({
    this.movie,
    this.images,
    this.credits,
    this.rottenTomatoesId,
    this.additionalRatings,
    this.youTubeReviews,
    this.reviews,
    this.featuredCrewPersons,
    this.similarMovies = const [],
    this.sameDirectorMovies = const [],
    this.sameDirectorMovieCount,
    this.countryReleaseDates,
    this.similarMoviesPage = 1,
  });

  MovieDetailsPageState copyWith({
    Movie movie,
    MovieImages images,
    Credits credits,
    String rottenTomatoesId,
    List<MovieRating> additionalRatings,
    List<YouTubeVideo> youTubeReviews,
    List<MovieReview> reviews,
    Map<CrewPerson, List<String>> featuredCrewPersons,
    List<Movie> similarMovies,
    List<Movie> sameDirectorMovies,
    int sameDirectorMovieCount,
    CountryReleaseDates countryReleaseDates,
    int similarMoviesPage,
  });

  @override
  List<Object> get props => [
        movie,
        images,
        credits,
        rottenTomatoesId,
        additionalRatings,
        youTubeReviews,
        reviews,
        featuredCrewPersons,
        similarMovies,
        sameDirectorMovies,
        sameDirectorMovieCount,
        countryReleaseDates,
        similarMoviesPage,
      ];
}

class LoadingMovieDetailsPageState extends MovieDetailsPageState {
  const LoadingMovieDetailsPageState({
    Movie movie,
    MovieImages images,
    Credits credits,
    String rottenTomatoesId,
    List<MovieRating> additionalRatings,
    List<YouTubeVideo> youTubeReviews,
    List<MovieReview> reviews,
    Map<CrewPerson, List<String>> featuredCrewPersons,
    List<Movie> similarMovies = const [],
    List<Movie> sameDirectorMovies = const [],
    int sameDirectorMovieCount,
    CountryReleaseDates countryReleaseDates,
    int similarMoviesPage = 0,
  }) : super(
          movie: movie,
          images: images,
          credits: credits,
          rottenTomatoesId: rottenTomatoesId,
          additionalRatings: additionalRatings,
          youTubeReviews: youTubeReviews,
          reviews: reviews,
          featuredCrewPersons: featuredCrewPersons,
          similarMovies: similarMovies,
          sameDirectorMovies: sameDirectorMovies,
          sameDirectorMovieCount: sameDirectorMovieCount,
          countryReleaseDates: countryReleaseDates,
          similarMoviesPage: similarMoviesPage,
        );

  @override
  MovieDetailsPageState copyWith({
    Movie movie,
    MovieImages images,
    Credits credits,
    String rottenTomatoesId,
    List<MovieRating> additionalRatings,
    List<YouTubeVideo> youTubeReviews,
    List<MovieReview> reviews,
    Map<CrewPerson, List<String>> featuredCrewPersons,
    List<Movie> similarMovies = const [],
    List<Movie> sameDirectorMovies = const [],
    int sameDirectorMovieCount,
    CountryReleaseDates countryReleaseDates,
    int similarMoviesPage,
  }) {
    return LoadingMovieDetailsPageState(
      movie: movie ?? this.movie,
      images: images ?? this.images,
      credits: credits ?? this.credits,
      rottenTomatoesId: rottenTomatoesId ?? this.rottenTomatoesId,
      additionalRatings: additionalRatings ?? this.additionalRatings,
      youTubeReviews: youTubeReviews ?? this.youTubeReviews,
      reviews: reviews ?? this.reviews,
      featuredCrewPersons: featuredCrewPersons ?? this.featuredCrewPersons,
      similarMovies: similarMovies ?? this.similarMovies,
      sameDirectorMovies: sameDirectorMovies ?? this.sameDirectorMovies,
      sameDirectorMovieCount: sameDirectorMovieCount ?? this.sameDirectorMovieCount,
      countryReleaseDates: countryReleaseDates ?? this.countryReleaseDates,
      similarMoviesPage: similarMoviesPage ?? this.similarMoviesPage,
    );
  }
}

class LoadedMovieDetailsPageState extends MovieDetailsPageState {
  const LoadedMovieDetailsPageState({
    Movie movie,
    MovieImages images,
    Credits credits,
    String rottenTomatoesId,
    List<MovieRating> additionalRatings,
    List<YouTubeVideo> youTubeReviews,
    List<MovieReview> reviews,
    Map<CrewPerson, List<String>> featuredCrewPersons,
    List<Movie> similarMovies = const [],
    List<Movie> sameDirectorMovies = const [],
    int sameDirectorMovieCount,
    CountryReleaseDates countryReleaseDates,
    int similarMoviesPage = 0,
  }) : super(
          movie: movie,
          images: images,
          credits: credits,
          rottenTomatoesId: rottenTomatoesId,
          additionalRatings: additionalRatings,
          youTubeReviews: youTubeReviews,
          reviews: reviews,
          featuredCrewPersons: featuredCrewPersons,
          similarMovies: similarMovies,
          sameDirectorMovies: sameDirectorMovies,
          sameDirectorMovieCount: sameDirectorMovieCount,
          countryReleaseDates: countryReleaseDates,
          similarMoviesPage: similarMoviesPage,
        );

  @override
  MovieDetailsPageState copyWith({
    Movie movie,
    MovieImages images,
    Credits credits,
    String rottenTomatoesId,
    List<MovieRating> additionalRatings,
    List<YouTubeVideo> youTubeReviews,
    List<MovieReview> reviews,
    Map<CrewPerson, List<String>> featuredCrewPersons,
    List<Movie> similarMovies,
    List<Movie> sameDirectorMovies,
    int sameDirectorMovieCount,
    CountryReleaseDates countryReleaseDates,
    int similarMoviesPage,
  }) {
    return LoadedMovieDetailsPageState(
      movie: movie ?? this.movie,
      images: images ?? this.images,
      credits: credits ?? this.credits,
      rottenTomatoesId: rottenTomatoesId ?? this.rottenTomatoesId,
      additionalRatings: additionalRatings ?? this.additionalRatings,
      youTubeReviews: youTubeReviews ?? this.youTubeReviews,
      reviews: reviews ?? this.reviews,
      featuredCrewPersons: featuredCrewPersons ?? this.featuredCrewPersons,
      similarMovies: similarMovies ?? this.similarMovies,
      sameDirectorMovies: sameDirectorMovies ?? this.sameDirectorMovies,
      sameDirectorMovieCount: sameDirectorMovieCount ?? this.sameDirectorMovieCount,
      countryReleaseDates: countryReleaseDates ?? this.countryReleaseDates,
      similarMoviesPage: similarMoviesPage ?? this.similarMoviesPage,
    );
  }
}

class FailureMovieDetailsPageState extends MovieDetailsPageState {
  final Failure failure;

  const FailureMovieDetailsPageState({
    this.failure,
    Movie movie,
    MovieImages images,
    Credits credits,
    String rottenTomatoesId,
    List<MovieRating> additionalRatings,
    List<YouTubeVideo> youTubeReviews,
    List<MovieReview> reviews,
    Map<CrewPerson, List<String>> featuredCrewPersons,
    List<Movie> similarMovies = const [],
    List<Movie> sameDirectorMovies = const [],
    int sameDirectorMovieCount,
    CountryReleaseDates countryReleaseDates,
    int similarMoviesPage = 0,
  }) : super(
          movie: movie,
          images: images,
          credits: credits,
          rottenTomatoesId: rottenTomatoesId,
          additionalRatings: additionalRatings,
          youTubeReviews: youTubeReviews,
          reviews: reviews,
          featuredCrewPersons: featuredCrewPersons,
          similarMovies: similarMovies,
          sameDirectorMovies: sameDirectorMovies,
          sameDirectorMovieCount: sameDirectorMovieCount,
          countryReleaseDates: countryReleaseDates,
          similarMoviesPage: similarMoviesPage,
        );

  FailureMovieDetailsPageState.fromCurrentState({
    MovieDetailsPageState currentState,
    this.failure,
  }) : super(
          movie: currentState.movie,
          images: currentState.images,
          credits: currentState.credits,
          rottenTomatoesId: currentState.rottenTomatoesId,
          additionalRatings: currentState.additionalRatings,
          youTubeReviews: currentState.youTubeReviews,
          reviews: currentState.reviews,
          featuredCrewPersons: currentState.featuredCrewPersons,
          similarMovies: currentState.similarMovies,
          sameDirectorMovies: currentState.sameDirectorMovies,
          sameDirectorMovieCount: currentState.sameDirectorMovieCount,
          countryReleaseDates: currentState.countryReleaseDates,
          similarMoviesPage: currentState.similarMoviesPage,
        );

  @override
  MovieDetailsPageState copyWith({
    Movie movie,
    MovieImages images,
    Credits credits,
    String rottenTomatoesId,
    List<MovieRating> additionalRatings,
    List<YouTubeVideo> youTubeReviews,
    List<MovieReview> reviews,
    Map<CrewPerson, List<String>> featuredCrewPersons,
    List<Movie> similarMovies,
    List<Movie> sameDirectorMovies,
    int sameDirectorMovieCount,
    CountryReleaseDates countryReleaseDates,
    int similarMoviesPage,
  }) {
    return FailureMovieDetailsPageState(
      movie: movie ?? this.movie,
      images: images ?? this.images,
      credits: credits ?? this.credits,
      rottenTomatoesId: rottenTomatoesId ?? this.rottenTomatoesId,
      additionalRatings: additionalRatings ?? this.additionalRatings,
      youTubeReviews: youTubeReviews ?? this.youTubeReviews,
      reviews: reviews ?? this.reviews,
      featuredCrewPersons: featuredCrewPersons ?? this.featuredCrewPersons,
      similarMovies: similarMovies ?? this.similarMovies,
      sameDirectorMovies: sameDirectorMovies ?? this.sameDirectorMovies,
      sameDirectorMovieCount: sameDirectorMovieCount ?? this.sameDirectorMovieCount,
      countryReleaseDates: countryReleaseDates ?? this.countryReleaseDates,
      similarMoviesPage: similarMoviesPage ?? this.similarMoviesPage,
    );
  }

  @override
  List<Object> get props => [
        failure,
        ...super.props,
      ];
}
