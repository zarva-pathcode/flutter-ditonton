import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/movie_fixtures/domain/entities/movie.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/list/movie_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late NowPlayingMovieListBloc nowPlayingMovieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late PopularMovieListBloc popularMovieListBloc;
  late MockGetPopularMovies mockGetPopularMovies;
  late TopRatedMovieListBloc topRatedMovieListBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieListBloc = NowPlayingMovieListBloc(mockGetNowPlayingMovies);
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieListBloc = PopularMovieListBloc(mockGetPopularMovies);
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieListBloc = TopRatedMovieListBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('now playing movie list', () {
    test('Initial state should be empty', () {
      expect(nowPlayingMovieListBloc.state, NowPlayingMovieListEmpty());
    });

    blocTest<NowPlayingMovieListBloc, MovieListState>(
      'Should emit [MovieListLoading, MovieListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMovieListBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingMovieList()),
      expect: () => [
        NowPlayingMovieListLoading(),
        NowPlayingMovieListHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMovieListBloc, MovieListState>(
      'Should emit [MovieListLoading, MovieListError] when get Failure',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return nowPlayingMovieListBloc;
      },
      act: (bloc) => bloc.add(OnGetNowPlayingMovieList()),
      expect: () => [
        NowPlayingMovieListLoading(),
        NowPlayingMovieListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('popular movie list', () {
    test('Initial state should be empty', () {
      expect(popularMovieListBloc.state, PopularMovieListEmpty());
    });

    blocTest<PopularMovieListBloc, MovieListState>(
      'Should emit [MovieListLoading, MovieListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return popularMovieListBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularMovieList()),
      expect: () => [
        PopularMovieListLoading(),
        PopularMovieListHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMovieListBloc, MovieListState>(
      'Should emit [MovieListLoading, MovieListError] when get Failure',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return popularMovieListBloc;
      },
      act: (bloc) => bloc.add(OnGetPopularMovieList()),
      expect: () => [
        PopularMovieListLoading(),
        PopularMovieListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });

  group('top rated movie list', () {
    test('Initial state should be empty', () {
      expect(topRatedMovieListBloc.state, TopRatedMovieListEmpty());
    });

    blocTest<TopRatedMovieListBloc, MovieListState>(
      'Should emit [MovieListLoading, MovieListLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return topRatedMovieListBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedMovieList()),
      expect: () => [
        TopRatedMovieListLoading(),
        TopRatedMovieListHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMovieListBloc, MovieListState>(
      'Should emit [MovieListLoading, MovieListError] when get Failure',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return topRatedMovieListBloc;
      },
      act: (bloc) => bloc.add(OnGetTopRatedMovieList()),
      expect: () => [
        TopRatedMovieListLoading(),
        TopRatedMovieListError('Failed'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
