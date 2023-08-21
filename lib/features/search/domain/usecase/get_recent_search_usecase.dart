import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/util/usecase/usecase.dart';
import '../../data/repo/search_repo.dart';
import '../entity/recent_search_entity.dart';

class GetRecentSearchUsecase implements Usecase<List<RecentSearchEntity>,GetRecentSearchParams> {
  SearchRepo repo ;

  GetRecentSearchUsecase({required this.repo});

  @override
  Future<Either<Failure, List<RecentSearchEntity>>> call(GetRecentSearchParams params) async {
    return await repo.getRecentSearch(params.screenCode);
  }
}

class GetRecentSearchParams {
  int screenCode;

  GetRecentSearchParams( this.screenCode);
}