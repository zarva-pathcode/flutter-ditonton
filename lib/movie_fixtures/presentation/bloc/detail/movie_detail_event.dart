part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetMovieDetail extends MovieDetailEvent {
  final int id;

  const OnGetMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddToWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movie;

  const OnAddToWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveFromWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movie;

  const OnRemoveFromWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnLoadWatchlistMovieStatus extends MovieDetailEvent {
  final int id;

  const OnLoadWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}
