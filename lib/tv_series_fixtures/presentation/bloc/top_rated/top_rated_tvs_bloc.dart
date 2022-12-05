import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv.dart';

part 'top_rated_tvs_event.dart';
part 'top_rated_tvs_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs _getTopRatedTvs;
  TopRatedTvsBloc(this._getTopRatedTvs) : super(TopRatedTvsEmpty()) {
    on<OnGetTopRatedTvs>((event, emit) async {
      emit(TopRatedTvsLoading());

      final result = await _getTopRatedTvs.execute();

      result.fold(
        (l) => emit(TopRatedTvsHasError(l.message)),
        (r) => emit(
          TopRatedTvsHasData(r),
        ),
      );
    });
  }
}
