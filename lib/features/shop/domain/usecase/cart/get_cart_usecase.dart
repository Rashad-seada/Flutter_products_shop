import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';


import '../../../data/repo/util/cart_response.dart';
import '../../repo/product_repo.dart';


class GetCartUsecase implements Usecase<List<CartResponse>,GetCartParams> {
  ProductRepo repo ;

  GetCartUsecase({required this.repo});

  @override
  Future<Either<Failure, List<CartResponse>>> call(GetCartParams params) async {
    return await repo.getCart(params.screenCode);
  }
}

class GetCartParams {
  int screenCode;

  GetCartParams(this.screenCode);
}