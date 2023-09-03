import 'package:bloc/bloc.dart';
import 'package:eng_shop/features/In_app_payments/view/screens/payment_datails_screen.dart';
import 'package:eng_shop/features/In_app_payments/view/screens/paymnet_user_info_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../shop/domain/entity/product_entity.dart';
import '../../../../shop/views/bloc/home/home_cubit.dart';
import '../../../../cart/domain/entity/cart_entity.dart';
import '../../../data/util/cart_response.dart';
import '../../../domain/usecase/add_to_cart_usecase.dart';
import '../../../domain/usecase/get_cart_usecase.dart';
import '../../../domain/usecase/remove_from_cart_usecase.dart';
import '../../../domain/usecase/update_cart_usecase.dart';


part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());
    await getIt<GetCartUsecase>().call(GetCartParams(AppConsts.homeScreen)).then(
        (value) => value.fold(
          (error) {
            emit(CartFailure(error));
          },
          (success) {
            emit(CartSuccess());
            CartSuccess.cart = success;
            HomeCubit.cartCount.value = getTotalItems() ;
            calculateTotalPrice();
            emit(CartInitial());
          },
        )
    );
  }

  double totalPrice = 0;

  int cartCount = 0;

  calculateTotalPrice(){
    totalPrice = 0;
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
                calculateTotalPrice();
              },
        )
    );
  }

  void addToCart(ProductEntity productEntity,BuildContext context){

    getIt<AddToCartUsecase>().call(AddToCartParams(productEntity, AppConsts.homeScreen)).then(
      (value) => value.fold(
        (error) {
          emit(CartFailure(error));
          CustomFlushBar(
              title: "Error ${error.code()}",
              message: error.message,
              context: context
          );
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
          calculateTotalPrice();

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

  onIncrementTap(int id,BuildContext context) {
    int index = CartSuccess.cart.indexWhere((element) => element.cartEntity.itemId == id);

    CartSuccess.cart[index].cartEntity.quantity = CartSuccess.cart[index].cartEntity.quantity! + 1;
    calculateTotalPrice();
    updateCartProduct(CartSuccess.cart[index].cartEntity,context);
  }

  onDeleteTap(int id,BuildContext context) {
    int index = CartSuccess.cart.indexWhere((element) => element.cartEntity.itemId == id);
    removeFromCart(CartSuccess.cart[index],context);
    calculateTotalPrice();
  }

  onDecrementTap(int id,BuildContext context) {
    int index = CartSuccess.cart.indexWhere((element) => element.cartEntity.itemId == id);

    if(CartSuccess.cart[index].cartEntity.quantity != 1) {
      CartSuccess.cart[index].cartEntity.quantity = CartSuccess.cart[index].cartEntity.quantity! - 1;
      calculateTotalPrice();
      updateCartProduct(CartSuccess.cart[index].cartEntity,context);
    }

  }

  int getTotalItems() {
    return CartSuccess.cart.length;
  }

  onRefreash() {
    CartSuccess.cart.clear();
    getCart();
  }

  onCheckoutClick(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_)=> const PaymentUserInfoScreen()));
  }

}
