import 'package:bloc/bloc.dart';
import 'package:ditonton/movie_fixtures/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularMoviesEmpty()) {
    on<OnGetPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());

      final result = await _getPopularMovies.execute();

      result.fold(
        (l) => emit(
          PopularMoviesHasError(l.message),
        ),
        (r) => emit(
          PopularMoviesHasData(r),
        ),
      );
    });
  }
}
