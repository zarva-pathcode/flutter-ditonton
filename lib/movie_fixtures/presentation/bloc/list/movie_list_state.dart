part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieListEmpty extends MovieListState {}

class NowPlayingMovieListLoading extends MovieListState {}

class NowPlayingMovieListError extends MovieListState {
  final String message;

  NowPlayingMovieListError(this.message);
  @override
  List<Object> get props => [message];
}

class NowPlayingMovieListHasData extends MovieListState {
  final List<Movie> movies;

  NowPlayingMovieListHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class PopularMovieListEmpty extends MovieListState {}

class PopularMovieListLoading extends MovieListState {}

class PopularMovieListError extends MovieListState {
  final String message;

  PopularMovieListError(this.message);
  @override
  List<Object> get props => [message];
}

class PopularMovieListHasData extends MovieListState {
  final List<Movie> movies;

  PopularMovieListHasData(this.movies);

  @override
  List<Object> get props => [movies];
}

class TopRatedMovieListEmpty extends MovieListState {}

class TopRatedMovieListLoading extends MovieListState {}

class TopRatedMovieListError extends MovieListState {
  final String message;

  TopRatedMovieListError(this.message);
  @override
  List<Object> get props => [message];
}

class TopRatedMovieListHasData extends MovieListState {
  final List<Movie> movies;

  TopRatedMovieListHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
