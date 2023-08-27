import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/infrastructure/services/network_service.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/shop/domain/usecase/products/drop_all_products_usecase.dart';

import '../../entity/product_entity.dart';
import '../../repo/product_repo.dart';


class GetProductsUsecase implements Usecase<List<ProductEntity>,GetProductsParams> {
  DropAllProductsUsecase dropAllProductsUsecase;
  NetworkService networkService;

  ProductRepo repo;


  GetProductsUsecase({required this.repo,required this.dropAllProductsUsecase,required this.networkService});

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) async {
    if(params.refresh && await networkService.isConnected){
      dropAllProductsUsecase.call(DropAllProductsParams(params.screenCode));
    }
    return await repo.getProducts(params.pageNumber,params.screenCode);
  }
}

class GetProductsParams {
  int pageNumber;
  int screenCode;
  bool refresh;

  GetProductsParams(this.pageNumber, this.screenCode, {this.refresh = false});
}