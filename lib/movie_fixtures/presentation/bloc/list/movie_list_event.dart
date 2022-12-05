part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class OnGetNowPlayingMovieList extends MovieListEvent {}

class OnGetTopRatedMovieList extends MovieListEvent {}

class OnGetPopularMovieList extends MovieListEvent {}
