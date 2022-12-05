import '../../../core/common/exception.dart';
import '../../../core/data/db/database_helper.dart';
import '../models/tv_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvTable tv);
  Future<String> removeWatchlist(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTvs();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvTable tv) async {
    try {
      await databaseHelper.insertTvWatchlist(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTable tv) async {
    try {
      await databaseHelper.removeTvWatchlist(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTvs() async {
    final result = await databaseHelper.getWatchlistTvs();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  // @override
  // Future<void> cacheNowPlayingTvs(List<TvTable> movies) async {
  //   await databaseHelper.clearCache('now playing');
  //   // await databaseHelper.insertCacheTransaction(movies, 'now playing');
  // }

  // @override
  // Future<List<TvTable>> getCachedNowPlayingTvs() async {
  //   final result = await databaseHelper.getCacheMovies('now playing');
  //   if (result.length > 0) {
  //     return result.map((data) => TvTable.fromMap(data)).toList();
  //   } else {
  //     throw CacheException("Can't get the data :(");
  //   }
  // }
}
