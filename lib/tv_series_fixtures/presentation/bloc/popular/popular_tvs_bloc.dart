import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';

part 'popular_tvs_event.dart';
part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs _getPopularTvs;
  PopularTvsBloc(this._getPopularTvs) : super(PopularTvsEmpty()) {
    on<OnGetPopularTvs>((event, emit) async {
      emit(PopularTvsLoading());

      final result = await _getPopularTvs.execute();

      result.fold(
        (l) => emit(PopularTvsHasError(l.message)),
        (r) => emit(
          PopularTvsHasData(r),
        ),
      );
    });
  }
}
