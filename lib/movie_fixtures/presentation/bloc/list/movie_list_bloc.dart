import 'package:bloc/bloc.dart';
import 'package:ditonton/movie_fixtures/domain/entities/movie.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class NowPlayingMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  NowPlayingMovieListBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieListEmpty()) {
    on<OnGetNowPlayingMovieList>((event, emit) async {
      emit(NowPlayingMovieListLoading());

      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (l) => emit(NowPlayingMovieListError(l.message)),
        (r) => emit(NowPlayingMovieListHasData(r)),
      );
    });
  }
}

class PopularMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieListBloc(this._getPopularMovies)
      : super(PopularMovieListEmpty()) {
    on<OnGetPopularMovieList>((event, emit) async {
      emit(PopularMovieListLoading());

      final result = await _getPopularMovies.execute();

      result.fold(
        (l) => emit(PopularMovieListError(l.message)),
        (r) => emit(PopularMovieListHasData(r)),
      );
    });
  }
}

class TopRatedMovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMovieListBloc(this._getTopRatedMovies)
      : super(TopRatedMovieListEmpty()) {
    on<OnGetTopRatedMovieList>((event, emit) async {
      emit(TopRatedMovieListLoading());

      final result = await _getTopRatedMovies.execute();

      result.fold(
        (l) => emit(TopRatedMovieListError(l.message)),
        (r) => emit(TopRatedMovieListHasData(r)),
      );
    });
  }
}
