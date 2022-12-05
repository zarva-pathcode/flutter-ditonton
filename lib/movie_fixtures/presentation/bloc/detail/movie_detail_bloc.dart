import 'package:bloc/bloc.dart';
import 'package:ditonton/core/common/state_enum.dart';
import 'package:ditonton/movie_fixtures/domain/entities/movie.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/save_watchlist_movie.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/remove_watchlist_movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailData> {
  final GetMovieDetail getMovieDetail;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;
  final GetMovieWatchlistStatus getMovieWatchlistStatus;
  final GetMovieRecommendations getMovieRecommendations;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
    required this.getMovieWatchlistStatus,
    required this.getMovieRecommendations,
  }) : super(MovieDetailData.empty()) {
    on<OnGetMovieDetail>(
      (event, emit) async {
        emit(state.copyWith(detailState: RequestState.Loading));

        final result = await getMovieDetail.execute(event.id);
        final recommendationResult =
            await getMovieRecommendations.execute(event.id);

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
                movie: r,
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
                  movieRecommendations: r,
                  recommendationState: RequestState.Loaded,
                  watchlistMessage: "",
                ),
              ),
            );
          },
        );
      },
    );
    on<OnAddToWatchlistMovie>(
      (event, emit) async {
        final result = await saveWatchlistMovie.execute(event.movie);

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
        add(OnLoadWatchlistMovieStatus(event.movie.id));
      },
    );
    on<OnRemoveFromWatchlistMovie>(
      (event, emit) async {
        final result = await removeWatchlistMovie.execute(event.movie);

        result.fold(
          (l) => emit(state.copyWith(watchlistMessage: l.message)),
          (r) => emit(
            state.copyWith(watchlistMessage: r),
          ),
        );
        add(OnLoadWatchlistMovieStatus(event.movie.id));
      },
    );
    on<OnLoadWatchlistMovieStatus>(
      (event, emit) async {
        final result = await getMovieWatchlistStatus.execute(event.id);

        emit(state.copyWith(isAddedToWatchlist: result));
      },
    );
  }
}
