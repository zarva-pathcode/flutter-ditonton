import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/core/common/state_enum.dart';
import 'package:ditonton/core/domain/entities/genre.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv_detail.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchlistStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late TvDetailBloc tvShowDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetTvWatchlistStatus mockGetTvWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetTvWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    tvShowDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getTvWatchlistStatus: mockGetTvWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final tvDetailDataInit = TvDetailData.empty();
  final tTv = Tv(
    backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
    id: 90462,
    name: "Chucky",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  );
  final tTvs = <Tv>[tTv];

  final tTvDetail = TvDetail(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [Genre(id: 1, name: 'Comedy')],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    numberOfEps: 0,
  );

  group('Get TvShow Detail', () {
    blocTest<TvDetailBloc, TvDetailData>(
      'Shoud emit TvDetailLoading, RecomendationLoading, TvShowDetailHasData and RecomendationHasData when get  Detail Tv and Recommendation Success',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvDetail(tId)),
      expect: () => [
        tvDetailDataInit.copyWith(detailState: RequestState.Loading),
        tvDetailDataInit.copyWith(
          recommendationState: RequestState.Loading,
          tv: tTvDetail,
          detailState: RequestState.Loaded,
          errorMessage: '',
        ),
        tvDetailDataInit.copyWith(
          detailState: RequestState.Loaded,
          tv: tTvDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: tTvs,
          errorMessage: '',
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailData>(
      'Shoud emit TvShowDetailLoading, RecomendationLoading, TvShowDetailHasData and RecommendationHasData when Get TvRecommendations Failed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvDetail(tId)),
      expect: () => [
        tvDetailDataInit.copyWith(detailState: RequestState.Loading),
        tvDetailDataInit.copyWith(
          recommendationState: RequestState.Loading,
          tv: tTvDetail,
          detailState: RequestState.Loaded,
          errorMessage: '',
        ),
        tvDetailDataInit.copyWith(
          detailState: RequestState.Loaded,
          tv: tTvDetail,
          recommendationState: RequestState.Error,
          errorMessage: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailData>(
      'Shoud emit TvDetailError when Get Tv Detail Failed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetTvDetail(tId)),
      expect: () => [
        tvDetailDataInit.copyWith(detailState: RequestState.Loading),
        tvDetailDataInit.copyWith(
          detailState: RequestState.Error,
          errorMessage: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('AddToWatchlist Tv', () {
    blocTest<TvDetailBloc, TvDetailData>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
      build: () {
        when(mockSaveWatchlist.execute(tTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
            .thenAnswer((_) async => true);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlistTv(tTvDetail)),
      expect: () => [
        tvDetailDataInit.copyWith(watchlistMessage: 'Added to Watchlist'),
        tvDetailDataInit.copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tTvDetail));
        verify(mockGetTvWatchlistStatus.execute(tTvDetail.id));
      },
    );

    blocTest<TvDetailBloc, TvDetailData>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockSaveWatchlist.execute(tTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
            .thenAnswer((_) async => false);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlistTv(tTvDetail)),
      expect: () => [
        tvDetailDataInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tTvDetail));
        verify(mockGetTvWatchlistStatus.execute(tTvDetail.id));
      },
    );
  });

  group('RemoveFromWatchlist Tv', () {
    blocTest<TvDetailBloc, TvDetailData>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist False when Success RemoveFromWatchlist',
      build: () {
        when(mockRemoveWatchlist.execute(tTvDetail))
            .thenAnswer((_) async => const Right('Removed From Watchlist'));
        when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
            .thenAnswer((_) async => false);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlistTv(tTvDetail)),
      expect: () => [
        tvDetailDataInit.copyWith(
          watchlistMessage: 'Removed From Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tTvDetail));
        verify(mockGetTvWatchlistStatus.execute(tTvDetail.id));
      },
    );

    blocTest<TvDetailBloc, TvDetailData>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockRemoveWatchlist.execute(tTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetTvWatchlistStatus.execute(tTvDetail.id))
            .thenAnswer((_) async => false);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlistTv(tTvDetail)),
      expect: () => [
        tvDetailDataInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tTvDetail));
        verify(mockGetTvWatchlistStatus.execute(tTvDetail.id));
      },
    );
  });

  group('LoadWatchlistStatus', () {
    blocTest<TvDetailBloc, TvDetailData>(
      'Should Emit AddWatchlistStatus True',
      build: () {
        when(mockGetTvWatchlistStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistTvStatus(tId)),
      expect: () => [
        tvDetailDataInit.copyWith(
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetTvWatchlistStatus.execute(tTvDetail.id));
      },
    );
  });
}
