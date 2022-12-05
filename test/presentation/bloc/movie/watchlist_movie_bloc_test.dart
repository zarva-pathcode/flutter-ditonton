import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/movie_fixtures/domain/entities/movie.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies);
  });

  final tMovies = <Movie>[testMovie];

  group('Watchlist Movies', () {
    test('Initial state should be empty', () {
      expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [WatchlistLoading, WatchlistHasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovies));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [WatchlistLoading, WatchlistHasData[], WatchlistEmpty] when data is empty',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right(<Movie>[]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieHasData(<Movie>[]),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [WatchlistLoading, WatchlistError] when data is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistMovie()),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
