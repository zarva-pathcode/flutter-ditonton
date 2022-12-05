part of 'top_rated_tvs_bloc.dart';

abstract class TopRatedTvsState extends Equatable {
  const TopRatedTvsState();

  @override
  List<Object> get props => [];
}

class TopRatedTvsEmpty extends TopRatedTvsState {}

class TopRatedTvsLoading extends TopRatedTvsState {}

class TopRatedTvsHasError extends TopRatedTvsState {
  final String message;
  const TopRatedTvsHasError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvsHasData extends TopRatedTvsState {
  final List<Tv> tvs;

  const TopRatedTvsHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
