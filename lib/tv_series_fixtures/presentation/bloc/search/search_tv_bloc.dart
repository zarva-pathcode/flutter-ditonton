import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series_fixtures/domain/entities/tv.dart';
import 'package:ditonton/tv_series_fixtures/domain/usecases/search_tvs.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvs _searchTvs;

  SearchTvBloc(this._searchTvs) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());

        final result = await _searchTvs.execute(query);

        result.fold(
          (l) => emit(SearchError(l.message)),
          (r) => emit(
            SearchHasData(r),
          ),
        );
      },
      transformer: debounce(const Duration(milliseconds: 600)),
    );
  }
}
