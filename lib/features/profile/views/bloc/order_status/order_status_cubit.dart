import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/config/app_consts.dart';
import 'package:eng_shop/features/profile/domain/usecases/get_orders_by_state_usecase.dart';
import 'package:eng_shop/features/shop/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../domain/entities/get_orders_entity.dart';

part 'order_status_state.dart';

class OrderStatusCubit extends Cubit<OrderStatusState> {
  OrderStatusCubit() : super(OrderStatusInitial());

  getOrdersByState(int orderState,BuildContext context){
    OrderStatusSuccess.orders.clear();
    emit(OrderStatusLoading());
    getIt<GetOrdersByStateUsecase>().call(GetOrderByStateParams(orderState,AppConsts.orderStatusScreen)).then(
            (value) => value.fold(
                    (error) {
                      emit(OrderStatusFailure(error));
                      CustomFlushBar(
                          title: "Error ${error.code()}",
                          message: error.message,
                          context: context
                      );
                    },
                    (success) {
                      emit(OrderStatusSuccess());

                      OrderStatusSuccess.orders = success;

                      emit(OrderStatusInitial());
                    })
    );
  }

}
