import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_top_rated_tvs.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/top_rated/top_rated_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvs])
void main() {
  late MockGetTopRatedTvs mockGetTopRatedTv;
  late TopRatedTvsBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTvs();
    topRatedTvBloc = TopRatedTvsBloc(mockGetTopRatedTv);
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

  group('Top Rated Tv Shows', () {
    test('Initial state should be empty', () {
      expect(topRatedTvBloc.state, TopRatedTvsEmpty());
    });

    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'Should emit [TopRatedTvLoading, TopRatedTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvs()),
      expect: () => [
        TopRatedTvsLoading(),
        TopRatedTvsHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'Should emit [TopRatedTvLoading, TopRatedTvHasData[], TopRatedTvEmpty] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => const Right(<Tv>[]));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvs()),
      expect: () => [
        TopRatedTvsLoading(),
        TopRatedTvsHasData(<Tv>[]),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'Should emit [TopRatedTvLoading, TopRatedTvError] when get Failure',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedTvs()),
      expect: () => [
        TopRatedTvsLoading(),
        const TopRatedTvsHasError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}
