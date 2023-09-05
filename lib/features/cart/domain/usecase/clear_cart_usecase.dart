import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/cart/domain/repo/cart_repo.dart';



class ClearCartUsecase implements Usecase<void,ClearCartParams> {
  CartRepo repo ;

  ClearCartUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(ClearCartParams params) async {
    return await repo.clearCartProduct(params.screenCode);
  }
}

class ClearCartParams {
  int screenCode;

  ClearCartParams(this.screenCode);
}