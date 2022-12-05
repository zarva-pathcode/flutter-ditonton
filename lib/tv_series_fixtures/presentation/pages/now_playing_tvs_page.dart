import 'package:ditonton/tv_series_fixtures/presentation/bloc/now_playing/now_playing_tvs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/tv_card_list.dart';

class NowPlayingTvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tvs';

  @override
  _NowPlayingTvsPageState createState() => _NowPlayingTvsPageState();
}

class _NowPlayingTvsPageState extends State<NowPlayingTvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<NowPlayingTvsBloc>().add(OnGetNowPlayingTvs()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now PLaying Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvsBloc, NowPlayingTvsState>(
          builder: (context, state) {
            if (state is NowPlayingTvsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return TvCard(tv);
                },
                itemCount: state.tvs.length,
              );
            } else {
              return Center(
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }
}
