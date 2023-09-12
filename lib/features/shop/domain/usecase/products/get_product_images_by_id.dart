import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../entity/get_product_images_entity.dart';
import '../../repo/product_repo.dart';


class GetProductImagesByIdUsecase implements Usecase<GetProductImagesEntity,GetProductImagesByIdParams> {
  ProductRepo repo;


  GetProductImagesByIdUsecase({required this.repo});

  @override
  Future<Either<Failure, GetProductImagesEntity>> call(GetProductImagesByIdParams params) async {
    return await repo.getProductImagesById(params.id,params.screenCode);
  }
}

class GetProductImagesByIdParams {
  int id;
  int screenCode;

  GetProductImagesByIdParams(this.id, this.screenCode,);
}