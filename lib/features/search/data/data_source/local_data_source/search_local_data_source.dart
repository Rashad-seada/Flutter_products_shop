
import '../../../../../core/infrastructure/database/database.dart';
import '../../../domain/entity/recent_search_entity.dart';

abstract class SearchLocalDataSource {
  Future<void> insertRecentSearch(RecentSearchEntity recentSearchEntity);
  Future<List<RecentSearchEntity>> getRecentSearch();
  Future<void> deleteRecentSearch(RecentSearchEntity recentSearchEntity);
  Future<void> clearAllRecentSearch();

}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {

  AppDatabase database;
  SearchLocalDataSourceImpl(this.database);

  @override
  Future<void> clearAllRecentSearch() async {
    await database.searchDao.dropAllRecentSearch();
  }

  @override
  Future<void> deleteRecentSearch(RecentSearchEntity recentSearchEntity) async {
    await database.searchDao.deleteRecentSearch(recentSearchEntity);
  }

  @override
  Future<List<RecentSearchEntity>> getRecentSearch() async {
    return await database.searchDao.getAllRecentSearch();
  }

  @override
  Future<void> insertRecentSearch(RecentSearchEntity recentSearchEntity) async {
    await database.searchDao.insertRecentSearch(recentSearchEntity);
  }

}