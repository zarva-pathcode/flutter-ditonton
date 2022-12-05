part of 'now_playing_tvs_bloc.dart';

abstract class NowPlayingTvsEvent extends Equatable {
  const NowPlayingTvsEvent();

  @override
  List<Object> get props => [];
}

class OnGetNowPlayingTvs extends NowPlayingTvsEvent {}
