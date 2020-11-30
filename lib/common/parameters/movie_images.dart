import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:next_movie/data/models/movie_image_model.dart';
import 'package:next_movie/domain/entities/movie_image.dart';

class MovieImages extends Equatable {
  final int id;
  final List<MovieImage> backdrops;
  final List<MovieImage> posters;

  const MovieImages({
    @required this.id,
    @required this.backdrops,
    @required this.posters,
  })  : assert(id != null),
        assert(backdrops != null),
        assert(posters != null);

  factory MovieImages.fromJson(Map<String, dynamic> json) {
    return MovieImages(
      id: json['id'] as int,
      backdrops: List<Map<String, dynamic>>.from(json['backdrops'] as List)
          .map(
            (backdropJson) => MovieImageModel.fromJson(backdropJson),
          )
          .toList(),
      posters: List<Map<String, dynamic>>.from(json['posters'] as List)
          .map(
            (backdropJson) => MovieImageModel.fromJson(backdropJson),
          )
          .toList(),
    );
  }

  @override
  List<Object> get props => [
        id,
        backdrops,
        posters,
      ];
}
