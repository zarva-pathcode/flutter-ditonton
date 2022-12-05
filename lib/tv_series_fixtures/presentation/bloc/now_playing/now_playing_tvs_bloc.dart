import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_now_playing_tvs.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'now_playing_tvs_event.dart';
part 'now_playing_tvs_state.dart';

class NowPlayingTvsBloc extends Bloc<NowPlayingTvsEvent, NowPlayingTvsState> {
  final GetNowPlayingTvs _getNowPlayingTvs;
  NowPlayingTvsBloc(this._getNowPlayingTvs) : super(NowPlayingTvsEmpty()) {
    on<OnGetNowPlayingTvs>((event, emit) async {
      emit(NowPlayingTvsLoading());

      final result = await _getNowPlayingTvs.execute();

      result.fold(
        (l) => emit(NowPlayingTvsHasError(l.message)),
        (r) => emit(NowPlayingTvsHasData(r)),
      );
    });
  }
}
