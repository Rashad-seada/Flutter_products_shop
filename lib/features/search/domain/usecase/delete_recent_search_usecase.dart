import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/util/usecase/usecase.dart';
import '../../data/repo/search_repo.dart';
import '../entity/recent_search_entity.dart';

class DeleteRecentSearchUsecase implements Usecase<void,DeleteRecentSearchParams> {
  SearchRepo repo ;

  DeleteRecentSearchUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(DeleteRecentSearchParams params) async {
    return await repo.deleteRecentSearch(params.recentSearchEntity, params.screenCode);
  }
}

class DeleteRecentSearchParams {
  RecentSearchEntity recentSearchEntity;
  int screenCode;

  DeleteRecentSearchParams(this.recentSearchEntity, this.screenCode);
}