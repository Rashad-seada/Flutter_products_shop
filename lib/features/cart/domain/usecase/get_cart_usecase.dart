import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';

import '../../data/util/cart_response.dart';
import '../repo/cart_repo.dart';





class GetCartUsecase implements Usecase<List<CartResponse>,GetCartParams> {
  CartRepo repo ;

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