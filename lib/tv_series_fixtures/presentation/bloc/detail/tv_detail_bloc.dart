import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv_detail.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/common/state_enum.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailData> {
  final GetTvDetail getTvDetail;
  final GetTvWatchlistStatus getTvWatchlistStatus;
  final GetTvRecommendations getTvRecommendations;
  final SaveWatchlistTv saveWatchlist;
  final RemoveWatchlistTv removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvWatchlistStatus,
    required this.getTvRecommendations,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailData.empty()) {
    on<OnGetTvDetail>(
      (event, emit) async {
        emit(state.copyWith(detailState: RequestState.Loading));

        final result = await getTvDetail.execute(event.id);
        final recommendationResult =
            await getTvRecommendations.execute(event.id);

        result.fold(
          (l) => emit(
            state.copyWith(
              detailState: RequestState.Error,
              errorMessage: l.message,
              watchlistMessage: "",
            ),
          ),
          (r) {
            emit(
              state.copyWith(
                tv: r,
                recommendationState: RequestState.Loading,
                detailState: RequestState.Loaded,
                watchlistMessage: "",
              ),
            );
            recommendationResult.fold(
              (l) => emit(state.copyWith(
                recommendationState: RequestState.Error,
                errorMessage: l.message,
                watchlistMessage: "",
              )),
              (r) => emit(
                state.copyWith(
                  tvRecommendations: r,
                  recommendationState: RequestState.Loaded,
                  watchlistMessage: "",
                ),
              ),
            );
          },
        );
      },
    );

    on<AddToWatchlistTv>(
      (event, emit) async {
        final result = await saveWatchlist.execute(event.tv);

        result.fold(
          (l) => emit(
            state.copyWith(
              watchlistMessage: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(watchlistMessage: r),
          ),
        );
        add(LoadWatchlistTvStatus(event.tv.id));
      },
    );
    on<RemoveFromWatchlistTv>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.tv);

        result.fold(
          (l) => emit(state.copyWith(watchlistMessage: l.message)),
          (r) => emit(
            state.copyWith(watchlistMessage: r),
          ),
        );
        add(LoadWatchlistTvStatus(event.tv.id));
      },
    );
    on<LoadWatchlistTvStatus>(
      (event, emit) async {
        final result = await getTvWatchlistStatus.execute(event.id);

        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
