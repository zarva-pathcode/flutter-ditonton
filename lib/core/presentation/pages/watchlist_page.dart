import 'package:ditonton/core/common/constants.dart';
import 'package:ditonton/core/common/utils.dart';
import 'package:ditonton/movie_fixtures/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/movie_fixtures/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/tv_series_fixtures/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:ditonton/tv_series_fixtures/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      context.read<WatchlistTvBloc>().add(OnGetWatchlistTv());
      context.read<WatchlistMovieBloc>().add(OnGetWatchlistMovie());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnGetWatchlistMovie());
    context.read<WatchlistTvBloc>().add(OnGetWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: kMikadoYellow,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'Movies',
                  ),
                  Tab(
                    text: 'Tv Series',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                    builder: (context, state) {
                      if (state is WatchlistMovieLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WatchlistMovieHasData) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final movie = state.movies[index];

                            return MovieCard(movie);
                          },
                          itemCount: state.movies.length,
                        );
                      } else {
                        return Center(
                          key: Key('error_message'),
                          child: Text("Failure"),
                        );
                      }
                    },
                  ),

                  // second tab bar view widget
                  BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                    builder: (context, state) {
                      if (state is WatchlistTvLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WatchlistTvHasData) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final tv = state.tvs[index];

                            return TvCard(tv);
                          },
                          itemCount: state.tvs.length,
                        );
                      } else {
                        return Center(
                          key: Key('error_message'),
                          child: Text("Failure"),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
