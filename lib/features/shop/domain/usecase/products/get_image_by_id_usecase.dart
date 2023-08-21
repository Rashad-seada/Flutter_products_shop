import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../repo/product_repo.dart';


class GetImageByIdUsecase implements Usecase<String,GetImageByIdParams> {
  ProductRepo repo ;

  GetImageByIdUsecase({required this.repo});

  @override
  Future<Either<Failure, String>> call(GetImageByIdParams params) async {
    return await repo.getProductImageById(params.id, params.screenCode);
  }
}

class GetImageByIdParams {
  int id;
  int screenCode;

  GetImageByIdParams(this.id, this.screenCode);
}