import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/util/usecase/usecase.dart';
import '../../data/repo/search_repo.dart';
import '../entity/recent_search_entity.dart';

class InsertRecentSearchUsecase implements Usecase<void,InsertRecentSearchParams> {
  SearchRepo repo ;

  InsertRecentSearchUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(InsertRecentSearchParams params) async {
    return await repo.insertRecentSearch(params.recentSearchEntity,params.screenCode);
  }
}

class InsertRecentSearchParams {
  RecentSearchEntity recentSearchEntity;
  int screenCode;

  InsertRecentSearchParams(this.recentSearchEntity, this.screenCode);
}