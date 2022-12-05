part of 'top_rated_tvs_bloc.dart';

abstract class TopRatedTvsEvent extends Equatable {
  const TopRatedTvsEvent();

  @override
  List<Object> get props => [];
}

class OnGetTopRatedTvs extends TopRatedTvsEvent {}
