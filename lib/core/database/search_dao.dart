import 'package:eng_shop/features/search/domain/entity/recent_search_entity.dart';
import 'package:floor/floor.dart';


@dao
abstract class SearchDao {

  @Query('SELECT * FROM RecentSearchEntity')
  Future<List<RecentSearchEntity>> getAllRecentSearch();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecentSearch(RecentSearchEntity recentSearchEntity);

  @delete
  Future<void> deleteRecentSearch(RecentSearchEntity recentSearchEntity);

  @Query('DROP TABLE RecentSearchEntity')
  Future<void> dropAllRecentSearch();
}
