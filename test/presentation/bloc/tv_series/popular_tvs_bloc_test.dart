import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/get_popular_tvs.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/popular/popular_tvs_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late MockGetPopularTvs mockGetPopularTv;
  late PopularTvsBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTvs();
    popularTvBloc = PopularTvsBloc(mockGetPopularTv);
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

  group('Popular Tv Shows', () {
    test('Initial state should be empty', () {
      expect(popularTvBloc.state, PopularTvsEmpty());
    });

    blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [PopularTvLoading, PopularTvHasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvs()),
      expect: () => [
        PopularTvsLoading(),
        PopularTvsHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [PopularTvLoading, PopularTvHasData[], PopularTvEmpty] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => const Right(<Tv>[]));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvs()),
      expect: () => [
        PopularTvsLoading(),
        PopularTvsHasData(<Tv>[]),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvsBloc, PopularTvsState>(
      'Should emit [PopularTvShowsLoading, PopularTvShowsError] when get Failure',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularTvs()),
      expect: () => [
        PopularTvsLoading(),
        PopularTvsHasError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}
