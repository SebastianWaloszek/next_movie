part of 'movie_details_page_bloc.dart';

abstract class MovieDetailsPageEvent extends Equatable {
  const MovieDetailsPageEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailsEvent extends MovieDetailsPageEvent {
  final Movie movie;

  const GetMovieDetailsEvent({
    @required this.movie,
  }) : assert(movie != null);

  @override
  List<Object> get props => [
        movie,
      ];
}

class ShowYouTubeVideoEvent extends MovieDetailsPageEvent {
  final String videoId;

  const ShowYouTubeVideoEvent({
    @required this.videoId,
  }) : assert(videoId != null);

  @override
  List<Object> get props => [
        videoId,
      ];
}

abstract class AddMovieEvent extends MovieDetailsPageEvent {
  final Movie movie;

  const AddMovieEvent({
    @required this.movie,
  }) : assert(movie != null);

  @override
  List<Object> get props => [
        movie,
      ];
}

class AddSimilarMovieEvent extends AddMovieEvent {
  const AddSimilarMovieEvent({@required Movie movie}) : super(movie: movie);
}

class AddSameDirectorMovieEvent extends AddMovieEvent {
  const AddSameDirectorMovieEvent({@required Movie movie}) : super(movie: movie);
}

class LoadMoreSimilarMoviesEvent extends MovieDetailsPageEvent {}
