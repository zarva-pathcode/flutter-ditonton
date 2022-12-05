import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';
import '../../../domain/usecases/get_top_rated_tvs.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class NowPlayingTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetNowPlayingTvs _getNowPlayingTvs;
  NowPlayingTvListBloc(this._getNowPlayingTvs)
      : super(NowPlayingTvListEmpty()) {
    on<OnGetNowPlayingTvList>((event, emit) async {
      emit(NowPlayingTvListLoading());

      final result = await _getNowPlayingTvs.execute();

      result.fold(
        (l) => emit(NowPlayingTvListError(l.message)),
        (r) => emit(NowPlayingTvListHasData(r)),
      );
    });
  }
}

class PopularTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetPopularTvs _getPopularTvs;
  PopularTvListBloc(this._getPopularTvs) : super(PopularTvListEmpty()) {
    on<OnGetPopularTvList>((event, emit) async {
      emit(PopularTvListLoading());

      final result = await _getPopularTvs.execute();

      result.fold(
        (l) => emit(PopularTvListError(l.message)),
        (r) => emit(
          PopularTvListHasData(r),
        ),
      );
    });
  }
}

class TopRatedTvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetTopRatedTvs _getTopRatedTvs;
  TopRatedTvListBloc(this._getTopRatedTvs) : super(TopRatedTvListEmpty()) {
    on<OnGetTopRatedTvList>((event, emit) async {
      emit(TopRatedTvListLoading());

      final result = await _getTopRatedTvs.execute();

      result.fold((l) => emit(TopRatedTvListError(l.message)),
          (r) => emit(TopRatedTvListHasData(r)));
    });
  }
}
