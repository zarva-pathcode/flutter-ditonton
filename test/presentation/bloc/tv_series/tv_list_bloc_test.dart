import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_now_playing_tvs.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/list/tv_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs, GetPopularTvs, GetTopRatedTvs])
void main() {
  late NowPlayingTvListBloc nowPlayingTvListBloc;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;
  late PopularTvListBloc popularTvListBloc;
  late MockGetPopularTvs mockGetPopularTvs;
  late TopRatedTvListBloc topRatedTvListBloc;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    nowPlayingTvListBloc = NowPlayingTvListBloc(mockGetNowPlayingTvs);
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvListBloc = PopularTvListBloc(mockGetPopularTvs);
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    topRatedTvListBloc = TopRatedTvListBloc(mockGetTopRatedTvs);
  });

  final tTvShow = Tv(
    backdropPath: "/xAKMj134XHQVNHLC6rWsccLMenG.jpg",
    id: 90462,
    name: "Chucky",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    posterPath: "/iF8ai2QLNiHV4anwY1TuSGZXqfN.jpg",
  );
  final tTvShowList = <Tv>[tTvShow];

  group('NowPlaying Tv list', () {
    test('Initial state should be empty', () {
      expect(nowPlayingTvListBloc.state, NowPlayingTvListEmpty());
    });

    blocTest<NowPlayingTvListBloc, TvListState>(
      'Should emit [NowPlayingTvListLoading, NowPlayingTvListHasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return nowPlayingTvListBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingTvList()),
      expect: () => [
        NowPlayingTvListLoading(),
        NowPlayingTvListHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvs.execute());
      },
    );

    blocTest<NowPlayingTvListBloc, TvListState>(
      'Should emit [PopularTvListLoading, PopularTvListError] when get Failure',
      build: () {
        when(mockGetNowPlayingTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return nowPlayingTvListBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingTvList()),
      expect: () => [
        NowPlayingTvListLoading(),
        NowPlayingTvListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingTvs.execute());
      },
    );
  });

  group('Popular Tv Show list', () {
    test('Initial state should be empty', () {
      expect(popularTvListBloc.state, PopularTvListEmpty());
    });

    blocTest<PopularTvListBloc, TvListState>(
      'Should emit [PopularTvListLoading, PopularTvListHasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return popularTvListBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvList()),
      expect: () => [
        PopularTvListLoading(),
        PopularTvListHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvs.execute());
      },
    );

    blocTest<PopularTvListBloc, TvListState>(
      'Should emit [PopularTvListLoading, PopularTvListError] when get Failure',
      build: () {
        when(mockGetPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularTvListBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvList()),
      expect: () => [
        PopularTvListLoading(),
        PopularTvListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTvs.execute());
      },
    );
  });

  group('Top Rated Tv Show list', () {
    test('Initial state should be empty', () {
      expect(topRatedTvListBloc.state, TopRatedTvListEmpty());
    });

    blocTest<TopRatedTvListBloc, TvListState>(
      'Should emit [TopRatedTvListLoading, TopRatedTvListHasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return topRatedTvListBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvList()),
      expect: () => [
        TopRatedTvListLoading(),
        TopRatedTvListHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvs.execute());
      },
    );

    blocTest<TopRatedTvListBloc, TvListState>(
      'Should emit [TopRatedTvListLoading, TopRatedTvListHasData] when get Failure',
      build: () {
        when(mockGetTopRatedTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedTvListBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvList()),
      expect: () => [
        TopRatedTvListLoading(),
        TopRatedTvListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvs.execute());
      },
    );
  });
}
