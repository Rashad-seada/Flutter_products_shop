import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/shop/views/bloc/home/home_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../data/repo/util/cart_response.dart';
import '../../../domain/entity/cart_entity.dart';
import '../../../domain/entity/product_entity.dart';
import '../../../domain/usecase/cart/add_to_cart_usecase.dart';
import '../../../domain/usecase/cart/get_cart_usecase.dart';
import '../../../domain/usecase/cart/remove_from_cart_usecase.dart';
import '../../../domain/usecase/cart/update_cart_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getCart(){
    CartSuccess.cart.clear();
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

  double totalPrice = 0;

  calculateTotal(){
    emit(CartInitial());
    CartSuccess.cart.forEach((element) {
      totalPrice += element.productEntity.price! * int.parse("${element.cartEntity.quantity}");
    });
    emit(CartSuccess());
  }

  void removeFromCart(CartResponse cartResponse,BuildContext context){

    getIt<RemoveFromCartUsecase>().call(RemoveFromCartParams(cartResponse.productEntity, AppConsts.homeScreen)).then(
            (value) => value.fold(
              (error) {
                emit(CartFailure(error));
                emit(CartInitial());
              },
              (success) {
                emit(CartSuccess());
                CartSuccess.cart.remove(cartResponse);
                print(CartSuccess.cart.length);
                CustomFlushBar(
                    title: "Removed from cart",
                    message: "the product has been removed from your cart",
                    context: context
                );
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
        (success) {
          emit(CartSuccess());
          CustomFlushBar(
              title: "Added to cart",
              message: "the product has been added to your cart",
              context: context
          );
          context.read<HomeCubit>().emit(HomeSuccess());
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

}
