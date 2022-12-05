import 'package:bloc/bloc.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_watchlist_tvs.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvs _getWatchlistTvs;
  WatchlistTvBloc(this._getWatchlistTvs) : super(WatchlistTvEmpty()) {
    on<OnGetWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());

      final result = await _getWatchlistTvs.execute();

      result.fold((l) => emit(WatchlistTvHasError(l.message)),
          (r) => emit(WatchlistTvHasData(r)));
    });
  }
}
