part of 'popular_tvs_bloc.dart';

abstract class PopularTvsState extends Equatable {
  const PopularTvsState();

  @override
  List<Object> get props => [];
}

class PopularTvsEmpty extends PopularTvsState {}

class PopularTvsLoading extends PopularTvsState {}

class PopularTvsHasError extends PopularTvsState {
  final String message;

  const PopularTvsHasError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvsHasData extends PopularTvsState {
  final List<Tv> tvs;

  const PopularTvsHasData(this.tvs);

  @override
  List<Object> get props => [tvs];
}
