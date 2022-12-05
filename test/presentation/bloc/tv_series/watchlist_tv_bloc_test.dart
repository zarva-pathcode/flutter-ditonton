import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_watchlist_tvs.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTvs);
  });
  final tTvShows = <Tv>[testTv];

  group('Watchlist Tv', () {
    test('Initial state should be empty', () {
      expect(watchlistTvBloc.state, WatchlistTvEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [WatchlistTvLoading, WatchlistTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(tTvShows));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData(tTvShows),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [WatchlistTvLoading, WatchlistTvHasData[], ] when data is empty',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Right(<Tv>[]));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        const WatchlistTvHasData(<Tv>[]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [WatchlistTvLoading, WatchlistTvHasError] when data is unsuccessful',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistTv()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      },
    );
  });
}
