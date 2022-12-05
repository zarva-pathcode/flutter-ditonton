import 'package:ditonton/core/common/ssl_pinning.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/list/movie_list_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/detail/tv_detail_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/list/tv_list_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/now_playing/now_playing_tvs_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/popular/popular_tvs_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/search/search_tv_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/top_rated/top_rated_tvs_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/common/constants.dart';
import 'core/common/utils.dart';
import 'injection.dart' as di;
import 'movie_fixtures/presentation/bloc/popular/popular_movies_bloc.dart';
import 'movie_fixtures/presentation/bloc/search/search_movie_bloc.dart';
import 'movie_fixtures/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'movie_fixtures/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'movie_fixtures/presentation/pages/home_movie_page.dart';
import 'movie_fixtures/presentation/pages/movie_detail_page.dart';
import 'movie_fixtures/presentation/pages/popular_movies_page.dart';
import 'movie_fixtures/presentation/pages/search_movie_page.dart';
import 'movie_fixtures/presentation/pages/top_rated_movies_page.dart';
import 'core/presentation/pages/about_page.dart';
import 'core/presentation/pages/watchlist_page.dart';
import 'tv_series_fixtures/presentation/pages/home_tv_page.dart';
import 'tv_series_fixtures/presentation/pages/now_playing_tvs_page.dart';
import 'tv_series_fixtures/presentation/pages/popular_tvs_page.dart';
import 'tv_series_fixtures/presentation/pages/search_tv_page.dart';
import 'tv_series_fixtures/presentation/pages/top_rated_tvs_page.dart';
import 'tv_series_fixtures/presentation/pages/tv_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //? MOVIE
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),

        //? TV
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviePage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case SearchTvPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case NowPlayingTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingTvsPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
