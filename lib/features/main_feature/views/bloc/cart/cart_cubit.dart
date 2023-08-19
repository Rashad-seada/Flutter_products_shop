import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../domain/entity/product_entity.dart';
import '../../../domain/usecase/add_to_cart_usecase.dart';
import '../../../domain/usecase/get_cart_usecase.dart';
import '../../../domain/usecase/remove_from_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getCart(){
    emit(CartLoading());

    getIt<GetCartUsecase>().call(GetCartParams(AppConsts.homeScreen)).then(
        (value) => value.fold(
          (error) {
            emit(CartFailure(error));
            emit(CartInitial());

          },
          (success) {
            emit(CartSuccess());
            CartSuccess.cart = success;
            emit(CartInitial());

          },
        )
    );
  }

  void removeFromCart(ProductEntity productEntity,BuildContext context){

    getIt<RemoveFromCartUsecase>().call(RemoveFromCartParams(productEntity, AppConsts.homeScreen)).then(
            (value) => value.fold(
              (error) {
                emit(CartFailure(error));
                emit(CartInitial());

              },
              (success) {
                emit(CartSuccess());
                CustomFlushBar(
                    title: "Removed from cart",
                    message: "the product has been removed from your cart",
                    context: context
                );
                emit(CartInitial());

              },
        )
    );
  }

  void addToCart(ProductEntity productEntity,BuildContext context){

    getIt<AddToCartUsecase>().call(AddToCartParams(productEntity, AppConsts.homeScreen)).then(
            (value) => value.fold(
              (error) {
                emit(CartFailure(error));
                emit(CartInitial());
          },
              (success) {
                emit(CartSuccess());
            CustomFlushBar(
                title: "Added to cart",
                message: "the product has been added to your cart",
                context: context
            );
                emit(CartInitial());
          },
        )
    );
  }
}
