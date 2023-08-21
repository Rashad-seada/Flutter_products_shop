import 'package:dartz/dartz.dart';
import 'package:eng_shop/features/search/domain/entity/recent_search_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../shop/domain/entity/product_entity.dart';

abstract class SearchRepo {

  //search
  Future<Either<Failure, List<ProductEntity>>> searchProduct(String searchTerm,int screenCode);

  Future<Either<Failure, void>> insertRecentSearch(RecentSearchEntity recentSearchEntity,int screenCode);
  Future<Either<Failure, void>> deleteRecentSearch(RecentSearchEntity recentSearchEntity,int screenCode);
  Future<Either<Failure, List<RecentSearchEntity>>> getRecentSearch(int screenCode);
  Future<Either<Failure, void>> deleteAllRecentSearch(int screenCode);


}