import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/now_playing/now_playing_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late MockGetNowPlayingTvs mockGetNowPlayingTv;
  late NowPlayingTvsBloc nowPlayingTvBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTvs();
    nowPlayingTvBloc = NowPlayingTvsBloc(mockGetNowPlayingTv);
  });

  final tTv = Tv(
    backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
    id: 90462,
    name: "Chucky",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  );

  final tTvList = <Tv>[tTv];

  group('Now Playing Tv Series', () {
    test('Initial state should be empty', () {
      expect(nowPlayingTvBloc.state, NowPlayingTvsEmpty());
    });

    blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
      'Should emit [NowPlayingTvLoading, NowPlayingTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingTvs()),
      expect: () => [
        NowPlayingTvsLoading(),
        NowPlayingTvsHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
      'Should emit [NowPlayingTvLoading, NowPlayingTvHasData[], NowPlayingTvEmpty] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => const Right(<Tv>[]));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingTvs()),
      expect: () => [
        NowPlayingTvsLoading(),
        NowPlayingTvsHasData(<Tv>[]),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<NowPlayingTvsBloc, NowPlayingTvsState>(
      'Should emit [NowPlayingTvLoading, NowPlayingTvError] when get Failure',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingTvs()),
      expect: () => [
        NowPlayingTvsLoading(),
        NowPlayingTvsHasError('Failed'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTv.execute());
      },
    );
  });
}
