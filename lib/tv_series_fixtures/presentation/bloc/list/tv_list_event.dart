part of 'tv_list_bloc.dart';

abstract class TvListEvent extends Equatable {
  const TvListEvent();

  @override
  List<Object> get props => [];
}

class OnGetNowPlayingTvList extends TvListEvent {}

class OnGetTopRatedTvList extends TvListEvent {}

class OnGetPopularTvList extends TvListEvent {}
