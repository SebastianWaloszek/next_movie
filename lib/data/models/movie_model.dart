import 'package:next_movie/data/models/genre_model.dart';
import 'package:next_movie/data/models/movie_rating_model.dart';
import 'package:next_movie/domain/entities/cast_person.dart';
import 'package:next_movie/domain/entities/credits.dart';
import 'package:next_movie/domain/entities/crew_person.dart';
import 'package:next_movie/domain/entities/genre.dart';
import 'package:next_movie/domain/entities/movie.dart';
import 'package:next_movie/domain/entities/movie_rating.dart';
import 'package:meta/meta.dart';

class MovieModel extends Movie {
  const MovieModel({
    @required int id,
    String imdbId,
    String title,
    String overview,
    String poster,
    DateTime releaseDate,
    String status,
    int budget,
    Duration runtime,
    int revenue,
    String originalLanguage,
    List<MovieRating> ratings,
    List<Genre> genres,
  }) : super(
          id: id,
          imdbId: imdbId,
          title: title,
          overview: overview,
          poster: poster,
          runtime: runtime,
          releaseDate: releaseDate,
          status: status,
          budget: budget,
          revenue: revenue,
          originalLanguage: originalLanguage,
          ratings: ratings,
          genres: genres,
        );

  MovieModel copyWith({
    String rottenTomatoesName,
    List<MovieRating> ratings,
    List<CrewPerson> crew,
    List<CastPerson> cast,
  }) {
    return MovieModel(
      id: id,
      imdbId: imdbId,
      title: title,
      overview: overview,
      poster: poster,
      runtime: runtime,
      releaseDate: releaseDate,
      status: status,
      budget: budget,
      revenue: revenue,
      originalLanguage: originalLanguage,
      ratings: ratings ?? this.ratings,
      genres: genres,
    );
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final voteAverage = json["vote_average"] as double;
    final hasVotes = voteAverage != 0.0;
    final runTime = json['runtime'] as int;
    return MovieModel(
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String,
      runtime: runTime != null ? Duration(minutes: runTime) : null,
      poster: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w342${json["poster_path"]}'
          : null,
      releaseDate: DateTime.tryParse(json['release_date'] as String),
      status: json['status'] as String,
      budget: json['budget'] as int,
      revenue: json['revenue'] as int,
      originalLanguage: json['original_language'] as String,
      ratings: hasVotes ? [MovieRatingModel.tmdb(voteAverage)] : [],
      genres: List<Genre>.from(
        (json['genres'] as List<dynamic>).map(
          (genre) => GenreModel.fromJson(
            genre as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }
}
