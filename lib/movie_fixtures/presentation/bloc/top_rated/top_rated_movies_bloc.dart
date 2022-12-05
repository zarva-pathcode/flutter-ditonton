import 'package:bloc/bloc.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<OnGetTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());

      final result = await _getTopRatedMovies.execute();

      result.fold(
        (l) => emit(
          TopRatedMoviesHasError(l.message),
        ),
        (r) => emit(
          TopRatedMoviesHasData(r),
        ),
      );
    });
  }
}
