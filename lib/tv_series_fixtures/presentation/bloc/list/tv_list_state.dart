part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvListEmpty extends TvListState {}

class NowPlayingTvListLoading extends TvListState {}

class NowPlayingTvListError extends TvListState {
  final String message;

  const NowPlayingTvListError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvListHasData extends TvListState {
  final List<Tv> tvs;

  const NowPlayingTvListHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class PopularTvListEmpty extends TvListState {}

class PopularTvListLoading extends TvListState {}

class PopularTvListError extends TvListState {
  final String message;

  const PopularTvListError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvListHasData extends TvListState {
  final List<Tv> tvs;

  const PopularTvListHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}

class TopRatedTvListEmpty extends TvListState {}

class TopRatedTvListLoading extends TvListState {}

class TopRatedTvListError extends TvListState {
  final String message;

  const TopRatedTvListError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvListHasData extends TvListState {
  final List<Tv> tvs;

  const TopRatedTvListHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
