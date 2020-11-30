import 'package:next_movie/common/error/failure.dart';
import 'package:next_movie/domain/entities/movie_list_type.dart';
import 'package:next_movie/presentation/features/movie_list/bloc/states/movie_list_page_state.dart';
import 'package:meta/meta.dart';

class FailedMovieListPageState extends MovieListPageState {
  final Failure failure;

  const FailedMovieListPageState({
    @required this.failure,
    @required MovieListType selectedMovieListType,
  })  : assert(failure != null),
        super(
          selectedMovieListType: selectedMovieListType,
        );

  @override
  MovieListPageState copyWith({MovieListType selectedMovieListType}) {
    return FailedMovieListPageState(
      failure: failure,
      selectedMovieListType: selectedMovieListType ?? this.selectedMovieListType
    );
  }

  @override
  List<Object> get props => [
        ...super.props,
        failure,
      ];
}
