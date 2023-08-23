import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/error_messages.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../data/repo/util/cart_response.dart';
import '../../../domain/entity/cart_entity.dart';
import '../../../domain/entity/product_entity.dart';
import '../../../domain/usecase/cart/add_to_cart_usecase.dart';
import '../../../domain/usecase/cart/get_cart_usecase.dart';
import '../../../domain/usecase/cart/remove_from_cart_usecase.dart';
import '../../../domain/usecase/cart/update_cart_usecase.dart';
import '../home/home_cubit.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCart() async {
    CartSuccess.cart.clear();
    emit(CartLoading());
    await getIt<GetCartUsecase>().call(GetCartParams(AppConsts.homeScreen)).then(
        (value) => value.fold(
          (error) {
            emit(CartFailure(error));
            if(error.exceptionCode.toString() + error.customCode.toString() == ErrorMessages.networkErrorCode){
              emit(CartNetworkError());
            }
          },
          (success) {
            emit(CartSuccess());
            CartSuccess.cart = success;
            HomeCubit.cartCount.value = getTotalItems() ;

            emit(CartInitial());
          },
        )
    );
  }

  double totalPrice = 0;

  int cartCount = 0;

  calculateTotal(){
    emit(CartInitial());
    CartSuccess.cart.forEach((element) {
      totalPrice += element.productEntity.price! * int.parse("${element.cartEntity.quantity}");
    });
    emit(CartSuccess());
  }

  void removeFromCart(CartResponse cartResponse,BuildContext context) {

    getIt<RemoveFromCartUsecase>().call(RemoveFromCartParams(cartResponse.productEntity, AppConsts.homeScreen)).then(
            (value) => value.fold(
              (error) {
                emit(CartFailure(error));
                emit(CartInitial());
              },
              (success) async {
                emit(CartSuccess());
                CartSuccess.cart.remove(cartResponse);

                HomeCubit.cartCount.value = getTotalItems() ;

                emit(CartInitial());
                calculateTotal();
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
        (success) async {
          emit(CartSuccess());

          await getCart();
          HomeCubit.cartCount.value = getTotalItems() ;

          CustomFlushBar(
              title: "Added to cart",
              message: "the product has been added to your cart",
              context: context
          );
          emit(CartInitial());
          calculateTotal();

        },
      )
    );
  }

  void updateCartProduct(CartEntity cartEntity,BuildContext context){

    getIt<UpdateCartUsecase>().call(UpdateCartParams(cartEntity, AppConsts.cartScreen)).then(
      (value) => value.fold(
        (error) {
          emit(CartFailure(error));
          emit(CartInitial());
        },
        (success) {
          emit(CartSuccess());
          emit(CartInitial());
        },
      )
    );
  }

  onIncrementTap(int index,BuildContext context) {
    CartSuccess.cart[index].cartEntity.quantity = CartSuccess.cart[index].cartEntity.quantity! + 1;
    calculateTotal();
    updateCartProduct(CartSuccess.cart[index].cartEntity,context);
  }

  onDeleteTap(int index,BuildContext context) {
    removeFromCart(CartSuccess.cart[index],context);
    calculateTotal();

  }

  onDecrementTap(int index,BuildContext context) {
    CartSuccess.cart[index].cartEntity.quantity = CartSuccess.cart[index].cartEntity.quantity! - 1;
    calculateTotal();
    updateCartProduct(CartSuccess.cart[index].cartEntity,context);
  }

  int getTotalItems() {
    return CartSuccess.cart.length;
  }

  onRefreash() {
    getCart();
  }

}
