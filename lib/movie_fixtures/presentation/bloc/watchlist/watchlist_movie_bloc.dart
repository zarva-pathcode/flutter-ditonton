import 'package:bloc/bloc.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  WatchlistMovieBloc(this._getWatchlistMovies) : super(WatchlistMovieEmpty()) {
    on<OnGetWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await _getWatchlistMovies.execute();

      result.fold(
        (l) => emit(
          WatchlistMovieHasError(l.message),
        ),
        (r) => emit(
          WatchlistMovieHasData(r),
        ),
      );
    });
  }
}
