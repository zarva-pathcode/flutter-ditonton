import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/list/movie_list_bloc.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/popular/popular_movies_bloc.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/search/search_movie_bloc.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/list/tv_list_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/now_playing/now_playing_tvs_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/popular/popular_tvs_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/top_rated/top_rated_tvs_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'core/common/network_info.dart';
import 'core/data/db/database_helper.dart';
import 'movie_fixtures/data/datasources/movie_local_data_source.dart';
import 'movie_fixtures/data/datasources/movie_remote_data_source.dart';
import 'movie_fixtures/data/repositories/movie_repository_impl.dart';
import 'movie_fixtures/domain/repositories/movie_repository.dart';
import 'movie_fixtures/domain/usecases/get_movie_detail.dart';
import 'movie_fixtures/domain/usecases/get_movie_recommendations.dart';
import 'movie_fixtures/domain/usecases/get_movie_watchlist_status.dart';
import 'movie_fixtures/domain/usecases/get_now_playing_movies.dart';
import 'movie_fixtures/domain/usecases/get_popular_movies.dart';
import 'movie_fixtures/domain/usecases/get_top_rated_movies.dart';
import 'movie_fixtures/domain/usecases/get_watchlist_movies.dart';
import 'movie_fixtures/domain/usecases/remove_watchlist_movie.dart';
import 'movie_fixtures/domain/usecases/save_watchlist_movie.dart';
import 'movie_fixtures/domain/usecases/search_movies.dart';
import 'tv_series_fixtures/data/datasources/tv_local_data_source.dart';
import 'tv_series_fixtures/data/datasources/tv_remote_data_source.dart';
import 'tv_series_fixtures/data/repositories/tv_repository_impl.dart';
import 'tv_series_fixtures/domain/repositories/tv_repository.dart';
import 'tv_series_fixtures/domain/usecases/get_now_playing_tvs.dart';
import 'tv_series_fixtures/domain/usecases/get_popular_tvs.dart';
import 'tv_series_fixtures/domain/usecases/get_top_rated_tvs.dart';
import 'tv_series_fixtures/domain/usecases/get_tv_detail.dart';
import 'tv_series_fixtures/domain/usecases/get_tv_recomendations.dart';
import 'tv_series_fixtures/domain/usecases/get_tv_watchlist_status.dart';
import 'tv_series_fixtures/domain/usecases/get_watchlist_tvs.dart';
import 'tv_series_fixtures/domain/usecases/remove_watchlist_tv.dart';
import 'tv_series_fixtures/domain/usecases/save_watchlist_tv.dart';
import 'tv_series_fixtures/domain/usecases/search_tvs.dart';
import 'tv_series_fixtures/presentation/bloc/search/search_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => NowPlayingMovieListBloc(locator()),
  );
  locator.registerFactory(
    () => PopularMovieListBloc(locator()),
  );

  locator.registerFactory(
    () => TopRatedMovieListBloc(locator()),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
        getMovieDetail: locator(),
        getMovieWatchlistStatus: locator(),
        removeWatchlistMovie: locator(),
        saveWatchlistMovie: locator(),
        getMovieRecommendations: locator()),
  );

  locator.registerFactory(
    () => SearchMovieBloc(locator()),
  );

  locator.registerFactory(() => PopularMoviesBloc(
        locator(),
      ));

  locator.registerFactory(() => TopRatedMoviesBloc(
        locator(),
      ));

  locator.registerFactory(() => WatchlistMovieBloc(
        locator(),
      ));

  locator.registerFactory(() => NowPlayingTvListBloc(
        locator(),
      ));

  locator.registerFactory(() => PopularTvListBloc(
        locator(),
      ));

  locator.registerFactory(() => TopRatedTvListBloc(
        locator(),
      ));

  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getTvWatchlistStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingTvsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetMovieWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
