part of 'top_rated_movies_bloc.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedMoviesEmpty extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesHasError extends TopRatedMoviesState {
  final String message;

  const TopRatedMoviesHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMoviesHasData extends TopRatedMoviesState {
  final List<Movie> movies;
  const TopRatedMoviesHasData(this.movies);

  @override
  List<Object> get props => [movies];
}
