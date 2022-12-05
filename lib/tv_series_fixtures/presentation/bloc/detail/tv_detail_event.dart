part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetTvDetail extends TvDetailEvent {
  final int id;
  const OnGetTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class AddToWatchlistTv extends TvDetailEvent {
  final TvDetail tv;
  const AddToWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class RemoveFromWatchlistTv extends TvDetailEvent {
  final TvDetail tv;

  const RemoveFromWatchlistTv(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistTvStatus extends TvDetailEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}
