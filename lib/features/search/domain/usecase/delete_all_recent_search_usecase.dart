import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import '../../data/repo/search_repo.dart';


class DeleteAllRecentSearchUsecase implements Usecase<void,DeleteAllRecentSearchParams> {
  SearchRepo repo ;

  DeleteAllRecentSearchUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(DeleteAllRecentSearchParams params) async {
    return await repo.deleteAllRecentSearch( params.screenCode);
  }
}

class DeleteAllRecentSearchParams {
  int screenCode;

  DeleteAllRecentSearchParams( this.screenCode);
}