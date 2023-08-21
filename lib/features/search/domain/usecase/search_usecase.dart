import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../../shop/domain/entity/product_entity.dart';
import '../../data/repo/search_repo.dart';


class SearchUsecase implements Usecase<List<ProductEntity>,SearchParams> {
  SearchRepo repo ;

  SearchUsecase({required this.repo});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(SearchParams params) async {
    return await repo.searchProduct(params.searchTerm, params.screenCode);
  }
}

class SearchParams {
  String searchTerm;
  int screenCode;

  SearchParams(this.searchTerm, this.screenCode);
}