import 'package:dartz/dartz.dart';
import 'package:eng_shop/core/error/failure.dart';
import 'package:eng_shop/core/util/usecase/usecase.dart';
import 'package:eng_shop/features/profile/domain/repo/profile_repo.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';

import '../entities/get_orders_entity.dart';



class GetOrdersByStateUsecase implements Usecase<List<GetOrderItemsEntity>,GetOrderByStateParams> {
  ProfileRepo repo ;

  GetOrdersByStateUsecase({required this.repo});

  @override
  Future<Either<Failure, List<GetOrderItemsEntity>>> call(GetOrderByStateParams params) async {
    return await repo.getOrderByState(orderState: params.orderState, screenCode: params.screenCode);
  }
}

class GetOrderByStateParams {
  int screenCode;
  int orderState;


  GetOrderByStateParams(this.orderState,this.screenCode);
}