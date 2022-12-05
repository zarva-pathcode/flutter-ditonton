part of 'now_playing_tvs_bloc.dart';

abstract class NowPlayingTvsState extends Equatable {
  const NowPlayingTvsState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvsEmpty extends NowPlayingTvsState {}

class NowPlayingTvsLoading extends NowPlayingTvsState {}

class NowPlayingTvsHasError extends NowPlayingTvsState {
  final String message;

  const NowPlayingTvsHasError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvsHasData extends NowPlayingTvsState {
  final List<Tv> tvs;

  const NowPlayingTvsHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
