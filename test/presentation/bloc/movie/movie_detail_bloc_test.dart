import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/core/common/failure.dart';
import 'package:ditonton/core/common/state_enum.dart';
import 'package:ditonton/core/domain/entities/genre.dart';
import 'package:ditonton/movie_fixtures/domain/entities/movie.dart';
import 'package:ditonton/movie_fixtures/domain/entities/movie_detail.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/remove_watchlist_movie.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/save_watchlist_movie.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetMovieWatchlistStatus,
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetMovieWatchlistStatus mockGetMovieWatchlistStatus;
  late MockSaveWatchlistMovie mockSaveWatchlist;
  late MockRemoveWatchlistMovie mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetMovieWatchlistStatus = MockGetMovieWatchlistStatus();
    mockSaveWatchlist = MockSaveWatchlistMovie();
    mockRemoveWatchlist = MockRemoveWatchlistMovie();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getMovieWatchlistStatus: mockGetMovieWatchlistStatus,
      saveWatchlistMovie: mockSaveWatchlist,
      removeWatchlistMovie: mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final movieDetailEmptyInit = MovieDetailData.empty();
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
  final tMovies = <Movie>[tMovie];

  final tMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Comedy')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 1,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailData>(
      'Shoud emit MovieDetailLoading, RecomendationLoading, MovieDetailLoaded and RecomendationLoaded when get  Detail Movies and Recommendation Success',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetMovieDetail(tId)),
      expect: () => [
        movieDetailEmptyInit.copyWith(detailState: RequestState.Loading),
        movieDetailEmptyInit.copyWith(
          recommendationState: RequestState.Loading,
          movie: tMovieDetail,
          detailState: RequestState.Loaded,
          errorMessage: '',
        ),
        movieDetailEmptyInit.copyWith(
          detailState: RequestState.Loaded,
          movie: tMovieDetail,
          recommendationState: RequestState.Loaded,
          movieRecommendations: tMovies,
          errorMessage: '',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailData>(
      'Shoud emit MovieDetailLoading, RecomendationLoading, MovieDetailLoaded and RecommendationError when Get MovieRecommendations Failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(tMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetMovieDetail(tId)),
      expect: () => [
        movieDetailEmptyInit.copyWith(detailState: RequestState.Loading),
        movieDetailEmptyInit.copyWith(
          recommendationState: RequestState.Loading,
          movie: tMovieDetail,
          detailState: RequestState.Loaded,
          errorMessage: '',
        ),
        movieDetailEmptyInit.copyWith(
          detailState: RequestState.Loaded,
          movie: tMovieDetail,
          recommendationState: RequestState.Error,
          errorMessage: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailData>(
      'Shoud emit MovieDetailError when Get Movie Detail Failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnGetMovieDetail(tId)),
      expect: () => [
        movieDetailEmptyInit.copyWith(detailState: RequestState.Loading),
        movieDetailEmptyInit.copyWith(
          detailState: RequestState.Error,
          errorMessage: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('AddToWatchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailData>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
      build: () {
        when(mockSaveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetMovieWatchlistStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddToWatchlistMovie(tMovieDetail)),
      expect: () => [
        movieDetailEmptyInit.copyWith(watchlistMessage: 'Added to Watchlist'),
        movieDetailEmptyInit.copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tMovieDetail));
        verify(mockGetMovieWatchlistStatus.execute(tMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockSaveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetMovieWatchlistStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnAddToWatchlistMovie(tMovieDetail)),
      expect: () => [
        movieDetailEmptyInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tMovieDetail));
        verify(mockGetMovieWatchlistStatus.execute(tMovieDetail.id));
      },
    );
  });

  group('RemoveFromWatchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist False when Success RemoveFromWatchlist',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => const Right('Removed From Watchlist'));
        when(mockGetMovieWatchlistStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveFromWatchlistMovie(tMovieDetail)),
      expect: () => [
        movieDetailEmptyInit.copyWith(
          watchlistMessage: 'Removed From Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tMovieDetail));
        verify(mockGetMovieWatchlistStatus.execute(tMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit watchlistMessage when Failed',
      build: () {
        when(mockRemoveWatchlist.execute(tMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetMovieWatchlistStatus.execute(tMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnRemoveFromWatchlistMovie(tMovieDetail)),
      expect: () => [
        movieDetailEmptyInit.copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tMovieDetail));
        verify(mockGetMovieWatchlistStatus.execute(tMovieDetail.id));
      },
    );
  });

  group('LoadWatchlistStatus', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should Emit AddWatchlistStatus True',
      build: () {
        when(mockGetMovieWatchlistStatus.execute(tId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchlistMovieStatus(tId)),
      expect: () => [
        movieDetailEmptyInit.copyWith(
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieWatchlistStatus.execute(tMovieDetail.id));
      },
    );
  });
}
