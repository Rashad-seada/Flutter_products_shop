import 'package:bloc/bloc.dart';
import 'package:eng_shop/core/error/error_messages.dart';
import 'package:eng_shop/features/order/domain/usecase/make_order_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/app_consts.dart';
import '../../../../../core/di/app_module.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/views/widgets/custom_flushbar.dart';
import '../../../../order/view/screens/paymnet_user_info_screen.dart';
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
            ErrorMessages().debugErrorCode(error.code());
          },
          (success) {
            CartSuccess.cart = success;
            HomeCubit.cartCount.value = getTotalItems() ;
            calculateTotalPrice();
            emit(CartSuccess());

          },
        )
    );
  }

  int? indexOfLoadingCartProduct;

  int cartCount = 0;

  double calculateTotalPrice(){
    double totalPrice = 0;
    emit(CartInitial());
    CartSuccess.cart.forEach((element) {
      totalPrice += double.parse("${element.productEntity.price!}") * double.parse("${element.cartEntity.quantity}");
    });
    emit(CartSuccess());
    return totalPrice;
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

  void addToCart(ProductEntity productEntity,int index,BuildContext context){

    indexOfLoadingCartProduct = index;
    emit(CartAddingToCart());

    getIt<AddToCartUsecase>().call(AddToCartParams(productEntity, AppConsts.homeScreen)).then(
      (value) => value.fold(
        (error) {
          emit(CartFailure(error));
          CustomFlushBar(
              title: "Error ${error.code()}",
              message: error.message,
              context: context
          );
          indexOfLoadingCartProduct = null;
          emit(CartInitial());
        },
        (success) async {
          emit(CartSuccess());

          await getCart();
          HomeCubit.cartCount.value = getTotalItems() ;

          indexOfLoadingCartProduct = null;
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
