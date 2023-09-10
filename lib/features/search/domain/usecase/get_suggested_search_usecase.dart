import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../../shop/domain/entity/product_entity.dart';
import '../../data/repo/search_repo.dart';


class GetSuggestedUsecase implements Usecase<List<ProductEntity>,GetSuggestedParams> {
  SearchRepo repo ;

  GetSuggestedUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetSuggestedParams params) async {
    return await repo.searchProduct(params.searchTerm, params.screenCode);
  }
}

class GetSuggestedParams {
  String searchTerm;
  int screenCode;

  GetSuggestedParams(this.searchTerm, this.screenCode);
}